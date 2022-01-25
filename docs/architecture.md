# THE 3.0 System Architecture

## Infrastructure Overview

```
                                    ┌─────────────────────────────────────┐
                                    │           AWS Cloud                  │
┌───────────────┐                   │  ┌─────────────────────────────────┐│
│  IoT Device   │◄──────────────────┼──│        Application Load         ││
│  (C++ Module) │   REST API        │  │          Balancer               ││
└───────────────┘   X-API-Key Auth  │  └─────────────┬───────────────────┘│
                                    │                │                     │
┌───────────────┐                   │  ┌─────────────▼───────────────────┐│
│  Web Browser  │◄──────────────────┼──│      EC2 (Tomcat + Spring)      ││
│  (Patient)    │   HTTPS           │  │                                  ││
└───────────────┘                   │  │  ┌─────────────────────────────┐││
                                    │  │  │    New Relic Java Agent     │││
┌───────────────┐                   │  │  └─────────────────────────────┘││
│  Web Browser  │◄──────────────────┼──│  ┌─────────────────────────────┐││
│  (Admin)      │   HTTPS           │  │  │   CloudWatch Agent          │││
└───────────────┘                   │  │  └─────────────────────────────┘││
                                    │  └─────────────┬───────────────────┘│
                                    │                │                     │
                                    │  ┌─────────────▼───────────────────┐│
                                    │  │          RDS (MySQL)            ││
                                    │  │                                  ││
                                    │  │  - member                        ││
                                    │  │  - adminData                     ││
                                    │  │  - diagnosis                     ││
                                    │  └─────────────────────────────────┘│
                                    │                                      │
                                    │  ┌─────────────────────────────────┐│
                                    │  │          S3 Bucket              ││
                                    │  │                                  ││
                                    │  │  - Static assets                 ││
                                    │  │  - Backup files                  ││
                                    │  └─────────────────────────────────┘│
                                    └─────────────────────────────────────┘
```

## AWS Services Used

| Service | Purpose | Configuration |
|---------|---------|---------------|
| **EC2** | Application server (Tomcat) | t3.medium, Amazon Linux 2 |
| **RDS** | MySQL database | db.t3.small, MySQL 8.0 |
| **S3** | Static file storage, backups | Standard storage class |
| **ALB** | Load balancing, SSL termination | HTTPS redirect enabled |
| **CloudWatch** | Metrics, logs, alarms | Custom namespace: THE3/EC2 |
| **Security Groups** | Network access control | Port 80, 443, 3306 |

## Monitoring Architecture

### CloudWatch Metrics

Collected every 60 seconds:

- **CPU**: Usage (idle, user, system)
- **Memory**: Used percent, available percent
- **Disk**: Used percent, inode free
- **Network**: Bytes sent/received, packets
- **Swap**: Used percent

### CloudWatch Alarms

| Alarm | Threshold | Action |
|-------|-----------|--------|
| High CPU | > 80% for 5 min | SNS notification |
| Low Disk | > 85% used | SNS notification |
| High Memory | > 90% for 5 min | SNS notification |
| RDS Connections | > 80% max | SNS notification |
| ALB 5xx Errors | > 10/min | SNS notification |

### Log Groups

| Log Group | Source | Retention |
|-----------|--------|-----------|
| `/the3/application` | Tomcat catalina.out | 30 days |
| `/the3/access` | Access logs | 30 days |
| `/the3/system` | System messages | 30 days |

### New Relic APM

- **Transaction Tracing**: All HTTP endpoints
- **Error Collection**: 500 errors, exceptions
- **JVM Metrics**: Heap, GC, threads
- **Custom Metrics**: Treatment counts, device connections

## Security

### API Authentication

IoT devices authenticate using API Key + SHA256:

```
X-API-Key: THE3-IOT-API-KEY-2021
```

Key validation flow:
1. Interceptor extracts X-API-Key header
2. Compare with stored key (SHA256 + Salt + 10000 iterations)
3. Reject with 401 if invalid

### Network Security

```
┌─────────────────────────────────────────────────────────────┐
│                    Security Groups                           │
├─────────────────────────────────────────────────────────────┤
│  ALB Security Group                                          │
│  - Inbound: 80, 443 from 0.0.0.0/0                          │
│  - Outbound: All to EC2 Security Group                      │
├─────────────────────────────────────────────────────────────┤
│  EC2 Security Group                                          │
│  - Inbound: 8080 from ALB Security Group only               │
│  - Inbound: 22 from Admin IP only                           │
│  - Outbound: 3306 to RDS Security Group                     │
├─────────────────────────────────────────────────────────────┤
│  RDS Security Group                                          │
│  - Inbound: 3306 from EC2 Security Group only               │
│  - No public access                                          │
└─────────────────────────────────────────────────────────────┘
```

## Deployment Process

### Standard Deployment

```bash
# 1. Build application
mvn clean package -DskipTests

# 2. Deploy to EC2
./scripts/deploy.sh v1.0.0

# 3. Verify deployment
curl https://the3.example.com/api/iot/health
```

### Rollback

```bash
# List available backups
ls -la /opt/tomcat/backup/

# Manual rollback
cp /opt/tomcat/backup/the3-[TIMESTAMP].war /opt/tomcat/webapps/ROOT.war
systemctl restart tomcat
```

## Data Flow

### Skin Analysis Flow

```
1. IoT Device sends POST /api/iot/skin-analysis
   ├── Headers: X-API-Key, Content-Type
   └── Body: deviceId, patientName, measurements...

2. ApiKeyInterceptor validates API key
   └── 401 Unauthorized if invalid

3. IoTApiController.submitSkinAnalysis()
   └── Maps request to AdminDataVO

4. AdminDataService.saveAdminData()
   └── Inserts to adminData table

5. Response: 200 OK with saved record ID
```

### Treatment Session Flow

```
1. IoT Device sends POST /api/iot/treatment
   └── Body: deviceId, patientName, treatmentType, duration...

2. Treatment types:
   ├── V (Vibration): mode, time, pressure
   ├── I (Iontophoresis): time, current
   ├── T (High-frequency): time, voltage
   └── L (LED): mode, brightness

3. Data stored in adminData with type indicator
```

## Performance Considerations

- **Connection Pooling**: HikariCP with 10-20 connections
- **Session Management**: File-based sessions, 2-hour timeout
- **Static Assets**: Served from S3 with CloudFront (future)
- **Database**: Read replicas for reporting (future)

## Disaster Recovery

| Component | Backup Strategy | RTO | RPO |
|-----------|-----------------|-----|-----|
| Database | RDS automated backups, 7 days | 1 hour | 5 min |
| Application | WAR files in S3 | 15 min | 0 |
| Configuration | Version controlled | 5 min | 0 |
