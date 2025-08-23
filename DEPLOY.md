# 🚀 DigitalOcean Deployment Guide

Deploy your Sim application to DigitalOcean with **3 deployment options**:

## 📋 **Quick Comparison**

| Option | Cost/Month | Complexity | Best For |
|--------|------------|------------|----------|
| **App Platform** | ~$32 | ⭐ Easy | Getting started quickly |
| **Kubernetes** | ~$36 | ⭐⭐⭐ Advanced | High availability & scaling |
| **Droplet** | ~$26 | ⭐⭐ Medium | Cost optimization |

---

## 🎯 **Option 1: App Platform (Recommended)**

**✅ Fully managed, zero DevOps, automatic SSL**

### Prerequisites
- DigitalOcean account
- GitHub repository with your code
- Domain name (optional)

### Quick Deploy

1. **Fork/Upload Code** to GitHub with your integrated DigBI + Sim code

2. **Create App** using the provided spec:
   ```bash
   # Deploy with doctl CLI
   doctl apps create --spec digitalocean-app.yaml
   ```

3. **Set Environment Variables** in DO Dashboard:
   ```bash
   BETTER_AUTH_SECRET=$(openssl rand -hex 32)
   ENCRYPTION_KEY=$(openssl rand -hex 32) 
   DIGBI_JWT_SECRET=$(openssl rand -hex 32)
   OPENAI_API_KEY=your-api-key
   RESEND_API_KEY=your-email-key
   ```

4. **Custom Domain** (optional):
   - Add domain in DO Dashboard
   - Update DNS records

**📄 Detailed Guide**: [digitalocean-app.yaml](./digitalocean-app.yaml)

---

## 🚀 **Option 2: Kubernetes (DOKS)**

**✅ Auto-scaling, high availability, professional grade**

### Prerequisites
- `kubectl`, `helm`, `doctl` installed
- Basic Kubernetes knowledge

### Quick Deploy

1. **Create Cluster**:
   ```bash
   doctl kubernetes cluster create sim-cluster \
     --region nyc1 --node-pool "name=sim-pool;size=s-2vcpu-4gb;count=2"
   ```

2. **Deploy Application**:
   ```bash
   # Install with Helm
   helm install sim ./helm/sim \
     --set app.env.BETTER_AUTH_SECRET="$(openssl rand -hex 32)" \
     --set app.env.ENCRYPTION_KEY="$(openssl rand -hex 32)" \
     --set app.env.DIGBI_JWT_SECRET="$(openssl rand -hex 32)"
   ```

3. **Configure Domain & SSL**:
   ```bash
   # Automatic SSL with cert-manager
   kubectl apply -f cert-issuer.yaml
   ```

**📄 Detailed Guide**: [deploy/digitalocean-kubernetes.md](./deploy/digitalocean-kubernetes.md)

---

## 💰 **Option 3: Docker Droplet (Cost-Effective)**

**✅ Full control, lowest cost, Docker Compose**

### Prerequisites
- SSH access to Ubuntu 22.04 droplet
- Domain name for SSL

### Quick Deploy

1. **Create Droplet**:
   ```bash
   doctl compute droplet create sim-server \
     --region nyc1 --image ubuntu-22-04-x64 --size s-4vcpu-8gb
   ```

2. **Setup Application**:
   ```bash
   # SSH into droplet and run setup script
   curl -sSL https://raw.githubusercontent.com/your-username/sim/main/scripts/setup-droplet.sh | bash
   ```

3. **Configure SSL**:
   ```bash
   certbot --nginx -d yourdomain.com
   ```

**📄 Detailed Guide**: [deploy/digitalocean-droplet.md](./deploy/digitalocean-droplet.md)

---

## 🔧 **Environment Configuration**

### **Required Variables** (All Options)

```bash
# Generate with: openssl rand -hex 32
BETTER_AUTH_SECRET="your-32-char-secret"
ENCRYPTION_KEY="your-32-char-secret"
DIGBI_JWT_SECRET="your-32-char-secret"  # For DigBI integration

# URLs (update with your domain)
NEXT_PUBLIC_APP_URL="https://yourdomain.com"
BETTER_AUTH_URL="https://yourdomain.com"

# Database (managed or self-hosted)
DATABASE_URL="postgresql://user:pass@host:port/simstudio"
```

### **Optional API Keys**

```bash
# AI Providers
OPENAI_API_KEY="sk-your-openai-key"
ANTHROPIC_API_KEY_1="sk-ant-your-claude-key"
MISTRAL_API_KEY="your-mistral-key"

# Email
RESEND_API_KEY="re_your-resend-key"

# OAuth (if using social login)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
```

**📄 Complete Guide**: [deploy/environment-setup.md](./deploy/environment-setup.md)

---

## 🗄️ **Database Options**

### **DigitalOcean Managed PostgreSQL** (Recommended)
- Automatic backups & scaling
- Built-in pgvector support
- ~$15/month for basic tier

### **Self-Hosted PostgreSQL**
- Install pgvector extension manually
- Handle backups yourself
- Lower cost but more maintenance

---

## 🔐 **Security Checklist**

- ✅ **SSL certificates** (automatic with all options)
- ✅ **Environment secrets** properly configured
- ✅ **Database encryption** at rest
- ✅ **Firewall rules** configured
- ✅ **Regular backups** enabled
- ✅ **Security headers** in Nginx/ingress

---

## 📊 **Monitoring & Maintenance**

### **Health Checks**
```bash
# Check application health
curl https://yourdomain.com/api/health

# Check realtime server
curl https://yourdomain.com/socket.io/health
```

### **Logs Access**
```bash
# App Platform
doctl apps logs sim-app --follow

# Kubernetes
kubectl logs -f deployment/sim-app

# Droplet
docker compose logs -f
```

### **Updates**
All options support zero-downtime rolling updates through their respective management interfaces.

---

## 🆘 **Troubleshooting**

### **Common Issues**

1. **Database Connection**: Verify DATABASE_URL and pgvector extension
2. **JWT Authentication**: Check DIGBI_JWT_SECRET matches between apps  
3. **SSL Issues**: Ensure domain DNS points to correct IP
4. **Memory Issues**: Increase instance size if needed

### **Getting Help**

- **Documentation**: [docs.sim.ai](https://docs.sim.ai)
- **Discord**: [Join Community](https://discord.gg/Hr4UWYEcTT)
- **GitHub Issues**: [Report Problems](https://github.com/simstudioai/sim/issues)

---

## 🎉 **Next Steps**

Once deployed:

1. **Setup DigBI Integration**: Configure JWT authentication between apps
2. **Configure AI Providers**: Add your preferred API keys
3. **Create First Workflow**: Test the integrated system
4. **Setup Monitoring**: Enable alerts and logging
5. **Backup Strategy**: Schedule regular database backups

**Your Sim application with DigBI integration is ready for production!** 🚀