# DigitalOcean App Platform Deployment Guide

## Prerequisites

1. **DigitalOcean Account**: Sign up at [digitalocean.com](https://digitalocean.com)
2. **GitHub Repository**: Push your code to GitHub (make it public or connect DO to private repo)
3. **doctl CLI** (optional): Install for command-line deployment

## Environment Variables Setup

Before deploying, you need the following environment variables:

### Required Secrets
- `DATABASE_URL`: Your PostgreSQL connection string
- `BETTER_AUTH_SECRET`: Authentication secret (generate with `openssl rand -hex 32`)
- `ENCRYPTION_KEY`: Encryption key (generate with `openssl rand -hex 32`)

### Optional OAuth Secrets (for social login)
- `GOOGLE_CLIENT_ID` & `GOOGLE_CLIENT_SECRET`: From Google Cloud Console
- `GITHUB_CLIENT_ID` & `GITHUB_CLIENT_SECRET`: From GitHub Developer Settings

### Optional Email Service
- `RESEND_API_KEY`: From [resend.com](https://resend.com) for email functionality

## Deployment Methods

### Method 1: DigitalOcean Web Interface (Recommended)

1. **Create App**:
   - Go to [cloud.digitalocean.com/apps](https://cloud.digitalocean.com/apps)
   - Click "Create App"
   - Choose "GitHub" as source
   - Select your repository and branch

2. **Import Configuration**:
   - In the app creation flow, look for "Advanced" or "Import from spec"
   - Upload or paste the contents of `.do/app.yaml`

3. **Set Environment Variables**:
   - Go to the "Environment Variables" section
   - Add the required secrets (contact your admin for the actual values)
   - Add any optional secrets you want to use

4. **Deploy**:
   - Review the configuration
   - Click "Create Resources"
   - Wait for deployment (usually 5-10 minutes)

### Method 2: doctl CLI

1. **Install doctl**:
```bash
# macOS
brew install doctl

# Linux
curl -sL https://github.com/digitalocean/doctl/releases/download/v1.104.0/doctl-1.104.0-linux-amd64.tar.gz | tar -xzv
sudo mv doctl /usr/local/bin
```

2. **Authenticate**:
```bash
doctl auth init
```

3. **Deploy**:
```bash
doctl apps create --spec .do/app.yaml
```

4. **Set Secrets**: Use the DigitalOcean dashboard to add environment variables

## Post-Deployment Configuration

1. **Custom Domain** (optional):
   - In the DO dashboard, go to your app
   - Click "Settings" → "Domains"
   - Add your custom domain and configure DNS

2. **Scaling**:
   - Monitor performance in the "Metrics" tab
   - Adjust instance sizes/counts in the "Components" section

## Architecture

This deployment creates:
- **Main App** (`simstudio-app`): Next.js application on port 80/443
- **Realtime Service** (`simstudio-realtime`): Socket.io server on port 3002
- **External Database**: Uses your existing PostgreSQL database
- **Migration Job**: Runs database migrations before each deployment (with `sim_` prefixed tables)

## Monitoring

- **Logs**: Available in the DO dashboard under "Runtime Logs"
- **Metrics**: CPU, memory, and request metrics in the "Metrics" tab
- **Alerts**: Set up in "Settings" → "Alerts"

## Troubleshooting

### Common Issues:

1. **Build Failures**:
   - Check build logs in the DO dashboard
   - Ensure all dependencies are in `package.json`
   - Verify build commands work locally

2. **Database Connection Issues**:
   - Verify `DATABASE_URL` is correctly set
   - Check if database migrations ran successfully

3. **Environment Variables**:
   - Ensure all required secrets are set
   - Check variable names match exactly

### Getting Help:
- Check DO documentation: [docs.digitalocean.com/products/app-platform](https://docs.digitalocean.com/products/app-platform/)
- DigitalOcean Community: [digitalocean.com/community](https://digitalocean.com/community)

## Cost Estimation

- **Basic Setup**: ~$15-30/month
  - App: $5-15/month (basic instances)
  - Database: $0/month (using existing infrastructure)
  - Bandwidth: $10-15/month (depending on usage)

- **Production Scale**: $50-150/month
  - Larger instances
  - Multiple environments
  - Additional services
  - (Database costs excluded since using existing infrastructure)