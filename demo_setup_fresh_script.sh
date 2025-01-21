#!/bin/bash

echo "🚀 Setting up EKS deployment..."

# Create EKS cluster
echo "Creating EKS cluster..."
eksctl create cluster \
    --name demo-eks-cluster \
    --region us-west-2 \
    --nodegroup-name standard-workers \
    --node-type t3.medium \
    --nodes 2 \
    --nodes-min 1 \
    --nodes-max 3 \
    --managed

# Create ECR repository
echo "Creating ECR repository..."
aws ecr create-repository \
    --repository-name demo-app \
    --region us-west-2

# Deploy with Helm
echo "Deploying application with Helm..."
helm upgrade --install demo-app helm/website-chart \
    --set image.repository=045940814242.dkr.ecr.us-west-2.amazonaws.com/demo-app \
    --set image.tag=latest

echo "✅ Setup complete!"
