# SimStudio Kamal Deployment Guide

This guide covers deploying SimStudio using Kamal to DigitalOcean.

## Prerequisites

1. **Kamal installed** (✅ Already installed)
2. **SSH access to droplet** (✅ Already configured)
3. **GitHub Container Registry access** (⚠️ Needs setup)
4. **Docker images built** (Will be automated)

## Setup Steps

### 1. GitHub Container Registry Access

Create a GitHub Personal Access Token with `write:packages` scope:

```bash
# Replace YOUR_TOKEN with your actual token
echo YOUR_TOKEN | docker login ghcr.io -u jgross --password-stdin
```

### 2. First Time Setup

```bash
# Initialize Kamal on the server
kamal setup
```

### 3. Deploy

```bash
# Deploy the application
kamal deploy
```

## Architecture

The deployment includes:

- **Main App** (`simstudio`): Next.js application with Bun runtime
- **Realtime Service** (`realtime`): Socket.io server for real-time features
- **Database Migrations**: Automated pre-deployment migrations
- **Traefik Load Balancer**: Handles routing and SSL

## Configuration Files

- `config/deploy.yml` - Main Kamal configuration
- `.kamal/secrets` - Environment variables (excluded from git)
- `apps/sim/Dockerfile.prod` - Production container for main app
- `apps/sim/Dockerfile.realtime` - Container for realtime service
- `.github/workflows/build-and-push.yml` - Automated image builds

## Services

### Main Application
- **Port**: 3000 (internal), 80/443 (external via Traefik)
- **Health Check**: `/api/health`
- **Image**: `ghcr.io/jgross/sim/simstudio:latest`

### Realtime Service
- **Port**: 3002
- **WebSocket endpoint**: `/socket.io`
- **Image**: `ghcr.io/jgross/sim/simstudio-realtime:latest`

## Useful Commands

```bash
# View logs
kamal logs
kamal logs -f  # Follow logs

# Application status
kamal details

# Rollback deployment
kamal rollback

# SSH into container
kamal console

# Restart services
kamal restart

# Update deployment
git push  # Triggers new image build
kamal deploy
```

## Environment Variables

All sensitive environment variables are stored in `.kamal/secrets`:

- `DATABASE_URL` - PostgreSQL connection string
- `BETTER_AUTH_SECRET` - Authentication secret
- `ENCRYPTION_KEY` - Data encryption key
- `BETTER_AUTH_URL` - Auth service URL
- `NEXT_PUBLIC_APP_URL` - Public app URL
- `SOCKET_SERVER_URL` - Socket server URL
- `NEXT_PUBLIC_SOCKET_URL` - Public socket URL

## SSL/TLS

Kamal is configured to automatically obtain SSL certificates via Let's Encrypt for your domain.

## Monitoring

- Container health checks every 20 seconds
- Automatic container restarts on failure
- Rolling deployments with zero downtime
- Retain last 5 container versions for rollback

## Troubleshooting

### Check container status
```bash
kamal details
```

### View recent logs
```bash
kamal logs --tail 100
```

### SSH into running container
```bash
kamal console
```

### Restart stuck deployment
```bash
kamal rollback
kamal deploy
```