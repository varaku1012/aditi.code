---
description: Deploy application to target environment with safety checks
argument-hint: [environment] [--dry-run] [--force]
allowed-tools: Bash, Read, Glob
---

# Deploy Application

Deploy the application to specified environment.

## Usage

```
/deploy staging                     # Deploy to staging
/deploy production                  # Deploy to production
/deploy staging --dry-run           # Preview without deploying
/deploy production --force          # Skip confirmation
```

## Environments

### Development
- Local or cloud dev environment
- Auto-deploy on push
- Relaxed validation

### Staging
- Production-like environment
- Requires tests passing
- Manual trigger

### Production
- Live environment
- Requires approval
- Full validation

## Deployment Process

### 1. Pre-flight Checks
```bash
# Verify clean working directory
git status --porcelain

# Ensure on correct branch
git branch --show-current

# Run tests
pytest tests/ -q

# Check build
python -m build --check
```

### 2. Build
```bash
# Build Docker image
docker build -t app:${VERSION} .

# Run security scan
docker scan app:${VERSION}
```

### 3. Deploy
```bash
# Railway
railway up --environment ${ENV}

# Kubernetes
kubectl apply -f k8s/${ENV}/

# Docker Compose
docker-compose -f docker-compose.${ENV}.yml up -d
```

### 4. Verification
```bash
# Health check
curl -f https://${APP_URL}/health

# Smoke tests
pytest tests/smoke/ --env=${ENV}
```

## Deployment Targets

### Railway (recommended)
```yaml
# railway.toml
[build]
builder = "nixpacks"

[deploy]
healthcheckPath = "/health"
healthcheckTimeout = 300
restartPolicyType = "on_failure"
```

### Docker
```dockerfile
# Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "main.py"]
```

### Kubernetes
```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: infinite-video
spec:
  replicas: 2
  selector:
    matchLabels:
      app: infinite-video
  template:
    spec:
      containers:
        - name: app
          image: infinite-video:latest
```

## Safety Features

### Dry Run
Preview all deployment steps without executing:
```
/deploy production --dry-run

Would execute:
1. Run test suite
2. Build Docker image
3. Push to registry
4. Update deployment
5. Run health checks
```

### Rollback
Automatic rollback on failure:
```bash
# Manual rollback
/deploy rollback production

# To specific version
/deploy rollback production --version v1.2.3
```

### Approval Gates
Production deployments require:
- All tests passing
- Security scan clean
- Manual approval (unless --force)

## Configuration

In `deploy.yaml`:
```yaml
environments:
  staging:
    url: staging.infinitevideo.ai
    auto_deploy: true
    branch: develop

  production:
    url: infinitevideo.ai
    auto_deploy: false
    branch: main
    approval_required: true

health_check:
  endpoint: /health
  timeout: 30
  retries: 3
```
