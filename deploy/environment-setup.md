# Production Environment Configuration

## Required Environment Variables

### 🔐 **Security & Authentication (REQUIRED)**

```bash
# Generate these with: openssl rand -hex 32
BETTER_AUTH_SECRET="your-32-character-secret"
ENCRYPTION_KEY="your-32-character-secret"  
DIGBI_JWT_SECRET="your-32-character-secret"  # For DigBI integration
```

### 🌐 **Application URLs (REQUIRED)**

```bash
# Update with your actual domain
NEXT_PUBLIC_APP_URL="https://yourdomain.com"
BETTER_AUTH_URL="https://yourdomain.com"
SOCKET_SERVER_URL="https://yourdomain.com"  # or separate subdomain
NEXT_PUBLIC_SOCKET_URL="https://yourdomain.com"  # client-side URL
```

### 🗄️ **Database (REQUIRED)**

```bash
# For DigitalOcean Managed Database
DATABASE_URL="postgresql://username:password@db-postgresql-nyc1-12345-do-user-123456-0.b.db.ondigitalocean.com:25060/simstudio?sslmode=require"

# For self-hosted PostgreSQL with pgvector
DATABASE_URL="postgresql://postgres:your-password@localhost:5432/simstudio"
```

### 📧 **Email Configuration (RECOMMENDED)**

```bash
# Resend (recommended)
RESEND_API_KEY="re_your_api_key"
FROM_EMAIL_ADDRESS="Sim <noreply@yourdomain.com>"
EMAIL_DOMAIN="yourdomain.com"

# Or use other providers (see documentation)
```

### 🤖 **AI Provider API Keys (OPTIONAL)**

```bash
# OpenAI (for GPT models)
OPENAI_API_KEY="sk-your-openai-key"
OPENAI_API_KEY_1="sk-backup-key-1"  # Load balancing
OPENAI_API_KEY_2="sk-backup-key-2"  # Load balancing

# Anthropic (for Claude models)
ANTHROPIC_API_KEY_1="sk-ant-your-key"
ANTHROPIC_API_KEY_2="sk-ant-backup-key"

# Other providers
MISTRAL_API_KEY="your-mistral-key"
GROQ_API_KEY="your-groq-key"

# Local models (if using)
OLLAMA_URL="http://localhost:11434"
```

### 🔑 **OAuth Integration (OPTIONAL)**

```bash
# Google OAuth
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"

# GitHub OAuth  
GITHUB_CLIENT_ID="your-github-client-id"
GITHUB_CLIENT_SECRET="your-github-client-secret"
```

### ⚡ **Performance & Rate Limiting**

```bash
# Rate limiting (requests per minute)
RATE_LIMIT_WINDOW_MS="60000"
RATE_LIMIT_FREE_SYNC="10"
RATE_LIMIT_PRO_SYNC="25"
RATE_LIMIT_TEAM_SYNC="75"
RATE_LIMIT_ENTERPRISE_SYNC="150"

# Memory and execution limits
NODE_OPTIONS="--max-old-space-size=4096"
NEXT_TELEMETRY_DISABLED="1"
VERCEL_TELEMETRY_DISABLED="1"
```

## Environment Setup by Platform

### **DigitalOcean App Platform**

1. **Via Dashboard**: Go to App → Settings → Environment Variables
2. **Via CLI**: 
```bash
# Create app spec with environment variables
doctl apps create --spec digitalocean-app.yaml
```

### **DigitalOcean Kubernetes**

```bash
# Create secrets
kubectl create secret generic sim-secrets \
  --from-literal=BETTER_AUTH_SECRET="$(openssl rand -hex 32)" \
  --from-literal=ENCRYPTION_KEY="$(openssl rand -hex 32)" \
  --from-literal=DIGBI_JWT_SECRET="$(openssl rand -hex 32)"

# Create API keys secret (optional)
kubectl create secret generic sim-api-keys \
  --from-literal=OPENAI_API_KEY="your-key" \
  --from-literal=ANTHROPIC_API_KEY_1="your-key" \
  --from-literal=RESEND_API_KEY="your-key"
```

### **Docker Droplet**

Create `.env.production`:

```bash
cat > .env.production << 'EOF'
# Copy all required variables here
NODE_ENV=production
DATABASE_URL=postgresql://postgres:password@db:5432/simstudio
BETTER_AUTH_SECRET=$(openssl rand -hex 32)
# ... etc
EOF
```

## Security Best Practices

### 🛡️ **Secret Generation**
```bash
# Generate secure 32-character secrets
openssl rand -hex 32

# Generate secure passwords
openssl rand -base64 32
```

### 🔒 **Environment Variable Security**

1. **Never commit** `.env` files to git
2. **Use secret managers** for production (K8s secrets, DO Secrets)
3. **Rotate secrets** regularly (every 90 days)
4. **Limit access** to environment variables

### 📝 **Environment File Template**

```bash
# .env.template - Safe to commit
NODE_ENV=production
NEXT_PUBLIC_APP_URL=https://yourdomain.com
BETTER_AUTH_URL=https://yourdomain.com

# Secrets - Set these in production
BETTER_AUTH_SECRET=
ENCRYPTION_KEY=
DIGBI_JWT_SECRET=
DATABASE_URL=

# Optional API Keys
OPENAI_API_KEY=
ANTHROPIC_API_KEY_1=
RESEND_API_KEY=
```

## Validation Script

Create a validation script to check your environment:

```bash
#!/bin/bash
# validate-env.sh

echo "🔍 Validating environment configuration..."

# Check required variables
REQUIRED_VARS=(
    "DATABASE_URL"
    "BETTER_AUTH_SECRET"
    "ENCRYPTION_KEY" 
    "NEXT_PUBLIC_APP_URL"
    "BETTER_AUTH_URL"
)

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo "❌ Missing required variable: $var"
        exit 1
    else
        echo "✅ $var is set"
    fi
done

# Check secret lengths
if [ ${#BETTER_AUTH_SECRET} -lt 32 ]; then
    echo "❌ BETTER_AUTH_SECRET should be at least 32 characters"
    exit 1
fi

if [ ${#ENCRYPTION_KEY} -lt 32 ]; then
    echo "❌ ENCRYPTION_KEY should be at least 32 characters"  
    exit 1
fi

echo "✅ Environment validation passed!"
```

## Database Setup

### **DigitalOcean Managed PostgreSQL**

1. **Create Database**:
   - Go to Databases → Create Database
   - Choose PostgreSQL 15+
   - Enable pgvector extension

2. **Get Connection String**:
   ```
   postgresql://username:password@host:25060/database?sslmode=require
   ```

### **Self-Hosted PostgreSQL with pgvector**

```sql
-- Connect to PostgreSQL and run:
CREATE DATABASE simstudio;
\c simstudio;
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

## SSL Certificate Setup

### **Automatic (Recommended)**
- **App Platform**: Automatic SSL
- **Kubernetes**: cert-manager with Let's Encrypt
- **Droplet**: Certbot with Nginx

### **Manual Certificate**
If using custom certificates:

```bash
# Copy certificates to:
/etc/ssl/certs/yourdomain.com.crt
/etc/ssl/private/yourdomain.com.key
```

This configuration ensures your Sim application runs securely and efficiently in production.