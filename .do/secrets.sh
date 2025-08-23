#!/bin/bash

# DigitalOcean App Platform - Environment Variables Setup Script
# Run this script to generate required secrets for your SimStudio deployment

echo "🔐 Generating secrets for SimStudio deployment..."
echo ""

# Generate required secrets
BETTER_AUTH_SECRET=$(openssl rand -hex 32)
ENCRYPTION_KEY=$(openssl rand -hex 32)

echo "✅ Generated required secrets:"
echo ""
echo "BETTER_AUTH_SECRET=$BETTER_AUTH_SECRET"
echo "ENCRYPTION_KEY=$ENCRYPTION_KEY"
echo ""

echo "💾 Add these to your DigitalOcean App Platform environment variables"
echo ""
echo "🚀 Next steps:"
echo "1. Copy these secrets to your DigitalOcean App Platform environment variables"
echo "2. Add your DATABASE_URL to the environment variables"
echo "3. Deploy using the DigitalOcean web interface or doctl CLI"
echo ""
echo "📖 See .do/deploy.md for detailed deployment instructions"