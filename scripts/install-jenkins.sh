#!/bin/bash

echo "==========================================="
echo "Part 1: Jenkins Setup on AWS EC2"
echo "==========================================="

echo "[1/8] Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "[2/8] Installing Java (Jenkins dependency)..."
sudo apt install -y openjdk-11-jdk

echo "[3/8] Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

echo "[4/8] Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "[5/8] Installing essential tools..."
sudo apt install -y python3 python3-pip python3-venv jq curl wget git unzip

echo "[6/8] Installing Docker for container operations..."
sudo apt install -y docker.io
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

echo "[7/8] Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

echo "[8/8] Configuring Jenkins user permissions..."
sudo usermod -aG sudo jenkins
echo 'jenkins ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/jenkins

echo "==========================================="
echo "✅ Jenkins Setup Complete!"
echo "==========================================="
echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
echo "Access Jenkins at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080"
echo "==========================================="
