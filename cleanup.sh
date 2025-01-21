#!/bin/bash

echo "🧹 Cleaning up EKS deployment..."

# Delete Helm release
echo "Deleting Helm release..."
helm uninstall demo-app

# Delete EKS cluster
echo "Deleting EKS cluster..."
eksctl delete cluster --name demo-eks-cluster --region us-west-2

# Delete ECR repository
echo "Deleting ECR repository..."
aws ecr delete-repository \
    --repository-name demo-app \
    --force \
    --region us-west-2

echo "✅ Cleanup complete!"
