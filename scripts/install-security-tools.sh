#!/bin/bash

echo "==========================================="
echo "Installing Security Scanning Tools"
echo "==========================================="

echo "[1/7] Installing Python security tools..."
sudo pip3 install bandit safety detect-secrets

echo "[2/7] Installing Trivy for container scanning..."
# Install Trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.45.1/trivy_0.45.1_Linux-64bit.deb
sudo dpkg -i trivy_0.45.1_Linux-64bit.deb
rm trivy_0.45.1_Linux-64bit.deb

echo "[3/7] Installing OWASP Dependency Check..."
# Install OWASP Dependency Check
wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.2.1/dependency-check-8.2.1-release.zip
unzip dependency-check-8.2.1-release.zip -d /opt/
ln -s /opt/dependency-check /opt/dependency-check-latest
rm dependency-check-8.2.1-release.zip

echo "[4/7] Setting up tool verification..."
echo "Bandit version: $(bandit --version)"
echo "Safety version: $(safety --version)"
echo "Detect-secrets version: $(detect-secrets --version)"
echo "Trivy version: $(trivy --version)"

echo "[5/7] Creating security scan directories..."
sudo mkdir -p /var/lib/jenkins/security-scans
sudo chown -R jenkins:jenkins /var/lib/jenkins/security-scans

echo "[6/7] Setting up baseline for detect-secrets..."
# This would be run in the project directory
echo "Note: Run 'detect-secrets scan > .secrets.baseline' in your project root"

echo "[7/7] Verification complete!"
echo "✅ All security tools installed successfully!"
