#!/bin/bash

echo "==========================================="
echo "AWS ECR Repository Setup"
echo "==========================================="

# Variables
AWS_REGION="us-east-1"
ECR_REPO_NAME="secure-flask-app"

echo "[1/3] Creating ECR repository..."
aws ecr create-repository \
    --repository-name $ECR_REPO_NAME \
    --region $AWS_REGION \
    --image-scanning-configuration scanOnPush=true \
    --image-tag-mutability MUTABLE

echo "[2/3] Setting repository policy..."
cat > ecr-policy.json << EOL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ECRPolicy",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789012:root"
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ]
        }
    ]
}
EOL

aws ecr set-repository-policy \
    --repository-name $ECR_REPO_NAME \
    --policy-text file://ecr-policy.json \
    --region $AWS_REGION

echo "[3/3] Repository created successfully!"
echo "ECR Repository URI: 123456789012.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME"
