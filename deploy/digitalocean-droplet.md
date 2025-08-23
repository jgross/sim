# DigitalOcean Droplet Deployment

## Prerequisites

1. **DigitalOcean Account**
2. **Domain name** pointing to your droplet
3. **SSH access** to the droplet

## Setup Steps

### 1. Create Droplet

```bash
# Create a droplet (8GB RAM recommended)
doctl compute droplet create sim-server \
  --region nyc1 \
  --image ubuntu-22-04-x64 \
  --size s-4vcpu-8gb \
  --ssh-keys YOUR_SSH_KEY_ID \
  --enable-monitoring
```

### 2. Initial Server Setup

SSH into your droplet and run:

```bash
# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker
systemctl start docker

# Install Docker Compose
apt install docker-compose-plugin -y

# Install Nginx
apt install nginx certbot python3-certbot-nginx -y

# Create app directory
mkdir -p /opt/sim
cd /opt/sim
```

### 3. Clone and Setup Application

```bash
# Clone repository
git clone https://github.com/your-username/sim.git .

# Create production environment file
cat > .env.production << 'EOF'
# Database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=CHANGE_THIS_SECURE_PASSWORD
POSTGRES_DB=simstudio
DATABASE_URL=postgresql://postgres:CHANGE_THIS_SECURE_PASSWORD@db:5432/simstudio

# Application URLs (update with your domain)
NEXT_PUBLIC_APP_URL=https://yourdomain.com
BETTER_AUTH_URL=https://yourdomain.com
SOCKET_SERVER_URL=https://yourdomain.com:3002
NEXT_PUBLIC_SOCKET_URL=https://yourdomain.com:3002

# Authentication & Security (generate with: openssl rand -hex 32)
BETTER_AUTH_SECRET=CHANGE_THIS_32_CHAR_SECRET
ENCRYPTION_KEY=CHANGE_THIS_32_CHAR_SECRET
DIGBI_JWT_SECRET=CHANGE_THIS_32_CHAR_SECRET

# Optional: API Keys
OPENAI_API_KEY=your_openai_api_key
ANTHROPIC_API_KEY_1=your_anthropic_api_key
RESEND_API_KEY=your_resend_api_key

# Optional: OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_CLIENT_SECRET=your_github_client_secret
EOF

# Generate secure secrets
sed -i "s/CHANGE_THIS_32_CHAR_SECRET/$(openssl rand -hex 32)/g" .env.production
sed -i "s/CHANGE_THIS_SECURE_PASSWORD/$(openssl rand -base64 32)/g" .env.production

# Set proper permissions
chmod 600 .env.production
```

### 4. Create Docker Compose Override

```bash
cat > docker-compose.override.yml << 'EOF'
services:
  simstudio:
    ports:
      - "127.0.0.1:3000:3000"  # Only bind to localhost
    environment:
      - NODE_ENV=production

  realtime:
    ports:
      - "127.0.0.1:3002:3002"  # Only bind to localhost
    environment:
      - NODE_ENV=production

  db:
    ports:
      - "127.0.0.1:5432:5432"  # Only bind to localhost
    volumes:
      - /opt/sim/data/postgres:/var/lib/postgresql/data
EOF

# Create data directory
mkdir -p /opt/sim/data/postgres
```

### 5. Configure Nginx Reverse Proxy

```bash
cat > /etc/nginx/sites-available/sim << 'EOF'
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;

    # SSL Configuration (will be configured by certbot)
    
    # Security headers
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

    # Main application
    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
        proxy_read_timeout 300;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        client_max_body_size 50M;
    }

    # Socket.IO server
    location /socket.io/ {
        proxy_pass http://127.0.0.1:3002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Update domain names in the config
sed -i 's/yourdomain.com/YOUR_ACTUAL_DOMAIN/g' /etc/nginx/sites-available/sim

# Enable site
ln -sf /etc/nginx/sites-available/sim /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx config
nginx -t
systemctl reload nginx
```

### 6. Setup SSL with Let's Encrypt

```bash
# Get SSL certificate
certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Test auto-renewal
certbot renew --dry-run
```

### 7. Create Systemd Service

```bash
cat > /etc/systemd/system/sim.service << 'EOF'
[Unit]
Description=Sim Application
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/sim
ExecStart=/usr/bin/docker compose --env-file .env.production -f docker-compose.prod.yml up -d
ExecStop=/usr/bin/docker compose --env-file .env.production -f docker-compose.prod.yml down
TimeoutStartSec=0
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
systemctl enable sim.service
systemctl start sim.service

# Check status
systemctl status sim.service
```

### 8. Setup Log Rotation

```bash
cat > /etc/logrotate.d/sim << 'EOF'
/opt/sim/logs/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    copytruncate
    create 644 root root
}
EOF
```

### 9. Create Backup Script

```bash
cat > /opt/sim/backup.sh << 'EOF'
#!/bin/bash
set -e

# Configuration
BACKUP_DIR="/opt/sim/backups"
DATE=$(date +%Y%m%d_%H%M%S)
DB_CONTAINER="sim-db-1"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup database
docker exec "$DB_CONTAINER" pg_dump -U postgres simstudio > "$BACKUP_DIR/database_$DATE.sql"

# Backup environment file
cp .env.production "$BACKUP_DIR/env_$DATE"

# Compress old backups
find "$BACKUP_DIR" -name "*.sql" -mtime +7 -exec gzip {} \;

# Remove backups older than 30 days
find "$BACKUP_DIR" -name "*.gz" -mtime +30 -delete

echo "Backup completed: $DATE"
EOF

chmod +x /opt/sim/backup.sh

# Add to crontab (daily at 2 AM)
(crontab -l 2>/dev/null; echo "0 2 * * * /opt/sim/backup.sh") | crontab -
```

### 10. Monitoring Script

```bash
cat > /opt/sim/monitor.sh << 'EOF'
#!/bin/bash

# Check if containers are running
if ! docker compose --env-file .env.production -f docker-compose.prod.yml ps | grep -q "Up"; then
    echo "$(date): Containers not running, attempting restart..."
    systemctl restart sim.service
fi

# Check disk space
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 80 ]; then
    echo "$(date): Disk usage is ${DISK_USAGE}% - Warning!"
fi

# Check memory usage
MEM_USAGE=$(free | awk 'NR==2{printf "%.2f", $3*100/$2}')
if (( $(echo "$MEM_USAGE > 90" | bc -l) )); then
    echo "$(date): Memory usage is ${MEM_USAGE}% - Warning!"
fi
EOF

chmod +x /opt/sim/monitor.sh

# Add to crontab (every 5 minutes)
(crontab -l 2>/dev/null; echo "*/5 * * * * /opt/sim/monitor.sh") | crontab -
```

## Deploy the Application

```bash
# Start the application
cd /opt/sim
systemctl start sim.service

# Check if everything is running
docker compose --env-file .env.production -f docker-compose.prod.yml ps
```

## Estimated Monthly Cost

- **Droplet**: s-4vcpu-8gb = $24/month
- **Bandwidth**: Usually included
- **Backups**: $2.40/month (optional)
- **Total**: ~$26/month

## Maintenance Commands

```bash
# View logs
docker compose --env-file .env.production -f docker-compose.prod.yml logs -f

# Update application
cd /opt/sim
git pull origin main
systemctl restart sim.service

# Manual backup
./backup.sh

# Check system resources
htop
df -h
```

This setup provides a robust, production-ready deployment of your Sim application on DigitalOcean with automatic SSL, monitoring, backups, and security best practices.