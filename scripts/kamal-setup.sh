#!/bin/bash

# Kamal Setup Script for SimStudio
set -e

echo "🚀 Setting up Kamal deployment for SimStudio..."

# Check if Kamal is installed
if ! command -v kamal &> /dev/null; then
    echo "❌ Kamal is not installed. Please install it first:"
    echo "   gem install kamal"
    exit 1
fi

echo "✅ Kamal is installed"

# Check if Docker is logged into GHCR
echo "🐳 Checking Docker login to GitHub Container Registry..."
if ! docker info | grep -q "Username: "; then
    echo "⚠️  Please log in to GitHub Container Registry:"
    echo "   echo \$GITHUB_TOKEN | docker login ghcr.io -u jgross --password-stdin"
    echo ""
    echo "   Create a GitHub Personal Access Token with 'write:packages' scope"
fi

# Set up SSH key for droplet access
echo "🔑 Setting up SSH access to droplet..."
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "⚠️  No SSH key found. Please ensure you have SSH access to 138.197.122.5"
fi

# Test SSH connection
echo "🧪 Testing SSH connection to droplet..."
if ssh -o ConnectTimeout=5 -o BatchMode=yes root@138.197.122.5 exit 2>/dev/null; then
    echo "✅ SSH connection successful"
else
    echo "❌ Cannot connect to droplet. Please ensure:"
    echo "   1. Your SSH key is added to the droplet"
    echo "   2. You can run: ssh root@138.197.122.5"
fi

echo ""
echo "🎯 Next steps:"
echo "1. Push your code to trigger GitHub Actions (builds Docker images)"
echo "2. Run: kamal setup (first time only)"
echo "3. Run: kamal deploy"
echo ""
echo "🔧 Useful Kamal commands:"
echo "   kamal setup      - Set up servers for first deployment"
echo "   kamal deploy     - Deploy the application"
echo "   kamal rollback   - Rollback to previous version"
echo "   kamal logs       - View application logs"
echo "   kamal console    - SSH into a running container"
echo "   kamal details    - Show deployment details"
echo ""
echo "✨ Ready to deploy SimStudio with Kamal!"