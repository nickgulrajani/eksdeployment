#!/bin/bash

# Colors for better output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Demo: Helm + GitHub Actions Value Proposition${NC}\n"

# 1. Show current deployment
echo -e "${GREEN}1. Current Deployment Status:${NC}"
helm list
kubectl get pods
echo -e "\n"

# 2. Make a visible change to the application
echo -e "${GREEN}2. Making a change to the application...${NC}"
cat > website/public/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>EKS Demo - Updated Version</title>
    <style>
        body { 
            font-family: Arial; 
            text-align: center; 
            padding-top: 50px;
            background-color: #f0f8ff;
        }
        .info {
            color: #2c3e50;
            margin: 20px;
            padding: 20px;
            border-radius: 5px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <h1>Welcome to Our EKS Demo!</h1>
    <div class="info">
        <h2>Deployment Information</h2>
        <p>✅ Deployed via GitHub Actions</p>
        <p>🎯 Managed by Helm</p>
        <p>🚀 Running on EKS</p>
        <p>⏰ Last Updated: <script>document.write(new Date().toLocaleString())</script></p>
    </div>
</body>
</html>
EOF

# 3. Commit and push changes
echo -e "${GREEN}3. Committing and pushing changes...${NC}"
git add website/public/index.html
git commit -m "demo: Update website with deployment info"
git push origin main

# 4. Show GitHub Actions workflow status
echo -e "${GREEN}4. GitHub Actions workflow triggered automatically!${NC}"
echo "Check your GitHub repository's Actions tab to see the workflow in action."

# 5. Monitor deployment
echo -e "${GREEN}5. Monitoring deployment (press Ctrl+C to stop watching):${NC}"
kubectl get pods -w &
PODS_PID=$!

# Wait for user input
read -p "Press Enter to continue with deployment verification..."
kill $PODS_PID

# 6. Show Helm history
echo -e "${GREEN}6. Helm Release History:${NC}"
helm history demo-app

# 7. Show LoadBalancer URL
echo -e "${GREEN}7. Application URL:${NC}"
kubectl get svc demo-app-website -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
echo -e "\n"

# 8. Demonstrate rollback capability
echo -e "${GREEN}8. Helm Rollback Capability:${NC}"
echo "To rollback to previous version:"
echo "helm rollback demo-app 1"

echo -e "\n${BLUE}Demo Complete!${NC}"
echo "This demonstrates:"
echo "✓ Automated deployments via GitHub Actions"
echo "✓ Version control with Helm"
echo "✓ Zero-downtime updates"
echo "✓ Easy rollbacks"
echo "✓ Infrastructure as Code"
