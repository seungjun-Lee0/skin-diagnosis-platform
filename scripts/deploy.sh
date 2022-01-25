#!/bin/bash
# THE3.0 Medical IoT Platform - Deployment Script
# Usage: ./deploy.sh [environment]

set -e

ENVIRONMENT=${1:-production}
APP_NAME="the3-medical-iot"
DEPLOY_PATH="/opt/tomcat/webapps"
BACKUP_PATH="/opt/backups"
WAR_FILE="target/the3.war"

echo "=========================================="
echo "THE3.0 Deployment - Environment: $ENVIRONMENT"
echo "=========================================="

# 1. Build
echo "[1/5] Building application..."
mvn clean package -DskipTests -P$ENVIRONMENT

# 2. Backup current version
echo "[2/5] Backing up current version..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
if [ -f "$DEPLOY_PATH/the3.war" ]; then
    cp "$DEPLOY_PATH/the3.war" "$BACKUP_PATH/the3_$TIMESTAMP.war"
    echo "Backup created: the3_$TIMESTAMP.war"
fi

# 3. Stop Tomcat
echo "[3/5] Stopping Tomcat..."
sudo systemctl stop tomcat || true
sleep 5

# 4. Deploy new version
echo "[4/5] Deploying new version..."
cp "$WAR_FILE" "$DEPLOY_PATH/the3.war"

# 5. Start Tomcat
echo "[5/5] Starting Tomcat..."
sudo systemctl start tomcat

# Health check
echo "Waiting for application to start..."
sleep 30

HEALTH_CHECK=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health || echo "000")
if [ "$HEALTH_CHECK" == "200" ]; then
    echo "=========================================="
    echo "Deployment successful!"
    echo "=========================================="
else
    echo "=========================================="
    echo "WARNING: Health check failed (HTTP $HEALTH_CHECK)"
    echo "Rolling back..."
    echo "=========================================="

    # Rollback
    sudo systemctl stop tomcat
    cp "$BACKUP_PATH/the3_$TIMESTAMP.war" "$DEPLOY_PATH/the3.war"
    sudo systemctl start tomcat

    exit 1
fi
