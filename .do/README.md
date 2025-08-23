# DigitalOcean App Platform Deployment

This directory contains everything needed to deploy SimStudio to DigitalOcean App Platform.

## Quick Start

1. **Generate secrets**: `./secrets.sh`
2. **Add environment variables**: Use DigitalOcean dashboard to add secrets
3. **Deploy**: Follow instructions in `deploy.md`

## Files

- **`app.yaml`**: App Platform configuration
- **`deploy.md`**: Detailed deployment guide  
- **`secrets.sh`**: Script to generate required environment variables
- **`README.md`**: This file

## Architecture

The deployment creates:
- Main Next.js application
- Socket.io realtime service
- External PostgreSQL database connection
- Pre-deploy migration job

## Cost

Estimated $15-30/month for basic setup, $50-150/month for production scale.

See `deploy.md` for complete instructions.