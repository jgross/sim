# DigitalOcean Kubernetes (DOKS) Deployment

## Prerequisites

1. **DigitalOcean Account** with Kubernetes enabled
2. **kubectl** installed locally
3. **helm** installed locally
4. **doctl** (DigitalOcean CLI) installed

## Setup Steps

### 1. Create DOKS Cluster

```bash
# Create a cluster with 2 nodes
doctl kubernetes cluster create sim-cluster \
  --region nyc1 \
  --version 1.28 \
  --node-pool "name=sim-pool;size=s-2vcpu-4gb;count=2;auto-scale=true;min-nodes=1;max-nodes=5"

# Configure kubectl
doctl kubernetes cluster kubeconfig save sim-cluster
```

### 2. Install Required Add-ons

```bash
# Install NGINX Ingress Controller
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# Install cert-manager for SSL
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --set installCRDs=true
```

### 3. Create Production Values

Create `values-production.yaml`:

```yaml
global:
  imageRegistry: "ghcr.io"

app:
  enabled: true
  replicaCount: 2
  
  image:
    repository: simstudioai/simstudio
    tag: latest
    
  resources:
    requests:
      memory: "2Gi"
      cpu: "1000m"
    limits:
      memory: "4Gi"
      cpu: "2000m"
  
  env:
    NEXT_PUBLIC_APP_URL: "https://yourdomain.com"
    BETTER_AUTH_URL: "https://yourdomain.com"
    SOCKET_SERVER_URL: "https://yourdomain.com"
    NEXT_PUBLIC_SOCKET_URL: "https://yourdomain.com"
    
    # Required secrets - set via kubectl secrets
    BETTER_AUTH_SECRET: ""
    ENCRYPTION_KEY: ""
    DIGBI_JWT_SECRET: ""
    
    # Optional API keys
    OPENAI_API_KEY: ""
    ANTHROPIC_API_KEY_1: ""
    RESEND_API_KEY: ""

realtime:
  enabled: true
  replicaCount: 1
  
  resources:
    requests:
      memory: "512Mi"
      cpu: "250m"
    limits:
      memory: "1Gi" 
      cpu: "500m"

postgresql:
  enabled: true
  auth:
    enablePostgresUser: true
    postgresPassword: "your-secure-password"
    database: "simstudio"
  
  primary:
    persistence:
      enabled: true
      size: 20Gi
      storageClass: do-block-storage
    
    resources:
      requests:
        memory: "1Gi"
        cpu: "500m"
      limits:
        memory: "2Gi"
        cpu: "1000m"

ingress:
  enabled: true
  className: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/proxy-body-size: "50m"
  
  hosts:
    - host: yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  
  tls:
    - secretName: sim-tls
      hosts:
        - yourdomain.com

# HPA for auto-scaling
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
```

### 4. Create Secrets

```bash
# Generate secure secrets
export BETTER_AUTH_SECRET=$(openssl rand -hex 32)
export ENCRYPTION_KEY=$(openssl rand -hex 32)
export DIGBI_JWT_SECRET=$(openssl rand -hex 32)

# Create secret
kubectl create secret generic sim-secrets \
  --from-literal=BETTER_AUTH_SECRET="$BETTER_AUTH_SECRET" \
  --from-literal=ENCRYPTION_KEY="$ENCRYPTION_KEY" \
  --from-literal=DIGBI_JWT_SECRET="$DIGBI_JWT_SECRET"

# Optional: Create API keys secret
kubectl create secret generic sim-api-keys \
  --from-literal=OPENAI_API_KEY="your-openai-key" \
  --from-literal=ANTHROPIC_API_KEY_1="your-anthropic-key" \
  --from-literal=RESEND_API_KEY="your-resend-key"
```

### 5. Create SSL Certificate Issuer

```yaml
# cert-issuer.yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@domain.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
```

```bash
kubectl apply -f cert-issuer.yaml
```

### 6. Deploy Sim

```bash
# Deploy using Helm
helm install sim ./helm/sim \
  -f values-production.yaml \
  --set app.env.BETTER_AUTH_SECRET="$BETTER_AUTH_SECRET" \
  --set app.env.ENCRYPTION_KEY="$ENCRYPTION_KEY" \
  --set app.env.DIGBI_JWT_SECRET="$DIGBI_JWT_SECRET"

# Check deployment status
kubectl get pods -l app.kubernetes.io/name=sim
kubectl get ingress
```

## Monitoring & Maintenance

### Check Logs
```bash
kubectl logs -f deployment/sim-app
kubectl logs -f deployment/sim-realtime
```

### Scale Application
```bash
kubectl scale deployment sim-app --replicas=3
```

### Update Application
```bash
helm upgrade sim ./helm/sim -f values-production.yaml
```

## Estimated Monthly Cost

- **DOKS Cluster**: 2 x s-2vcpu-4gb nodes = ~$24/month
- **Load Balancer**: $10/month
- **Block Storage**: 20GB = ~$2/month
- **Total**: ~$36/month

## Benefits of DOKS

✅ **Auto-scaling** based on CPU/memory usage  
✅ **High availability** with multiple replicas  
✅ **Rolling updates** with zero downtime  
✅ **Built-in monitoring** and logging  
✅ **SSL certificates** automatically managed  