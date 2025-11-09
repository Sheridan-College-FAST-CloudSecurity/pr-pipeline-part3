#!/bin/bash

echo "==========================================="
echo "Installing Required Jenkins Plugins"
echo "==========================================="

# List of essential plugins for our CI/CD pipeline
PLUGINS=(
    "workflow-aggregator"
    "git"
    "github"
    "github-branch-source"
    "pipeline-github"
    "aws-credentials"
    "docker-plugin"
    "docker-workflow"
    "blueocean"
    "credentials-binding"
    "ssh-credentials"
    "email-ext"
    "ws-cleanup"
    "timestamper"
    "pipeline-utility-steps"
    "htmlpublisher"
    "warnings-ng"
    "junit"
)

echo "Installing ${#PLUGINS[@]} plugins..."

for plugin in "${PLUGINS[@]}"; do
    echo "Installing: $plugin"
    java -jar /var/lib/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ install-plugin "$plugin" -deploy
done

echo "Restarting Jenkins to apply plugins..."
sudo systemctl restart jenkins

echo "✅ Jenkins plugins installation complete!"
echo "Plugins installed:"
printf " - %s\n" "${PLUGINS[@]}"
