#!/bin/bash
# THE3.0 Medical IoT Platform - Monitoring Setup Script
# Run this on EC2 instance to configure monitoring

set -e

echo "=========================================="
echo "THE3.0 Monitoring Setup"
echo "=========================================="

# Variables
NEW_RELIC_LICENSE_KEY=${NEW_RELIC_LICENSE_KEY:-"YOUR_LICENSE_KEY"}
REGION="ap-northeast-2"

# 1. Install CloudWatch Agent
echo "[1/4] Installing CloudWatch Agent..."
if ! command -v amazon-cloudwatch-agent &> /dev/null; then
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
    sudo rpm -U ./amazon-cloudwatch-agent.rpm
    rm amazon-cloudwatch-agent.rpm
fi

# 2. Configure CloudWatch Agent
echo "[2/4] Configuring CloudWatch Agent..."
sudo cp monitoring/cloudwatch/amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
    -s

# 3. Install New Relic Java Agent
echo "[3/4] Installing New Relic Java Agent..."
NEW_RELIC_DIR="/opt/newrelic"
if [ ! -d "$NEW_RELIC_DIR" ]; then
    sudo mkdir -p $NEW_RELIC_DIR
    cd $NEW_RELIC_DIR
    sudo curl -O https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip
    sudo unzip newrelic-java.zip
    sudo rm newrelic-java.zip
fi

# 4. Configure New Relic
echo "[4/4] Configuring New Relic..."
sudo cp monitoring/newrelic/newrelic.yml $NEW_RELIC_DIR/newrelic.yml
sudo sed -i "s/<%= ENV\[\"NEW_RELIC_LICENSE_KEY\"\] %>/$NEW_RELIC_LICENSE_KEY/g" $NEW_RELIC_DIR/newrelic.yml

# Update Tomcat JAVA_OPTS
TOMCAT_CONF="/opt/tomcat/bin/setenv.sh"
if ! grep -q "newrelic" $TOMCAT_CONF 2>/dev/null; then
    echo 'JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/newrelic/newrelic.jar"' | sudo tee -a $TOMCAT_CONF
fi

echo "=========================================="
echo "Monitoring setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart Tomcat: sudo systemctl restart tomcat"
echo "2. Verify CloudWatch Agent: sudo systemctl status amazon-cloudwatch-agent"
echo "3. Check New Relic dashboard in ~5 minutes"
echo "=========================================="
