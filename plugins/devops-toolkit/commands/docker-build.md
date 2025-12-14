---
description: Build and manage Docker images for the application
argument-hint: [--tag version] [--push] [--multi-arch]
allowed-tools: Bash, Read, Write
---

# Docker Build

Build Docker images for deployment.

## Usage

```
/docker-build                       # Build with default tag
/docker-build --tag v1.2.3          # Specific version tag
/docker-build --push                # Build and push to registry
/docker-build --multi-arch          # Build for multiple architectures
```

## Dockerfile

```dockerfile
# Dockerfile
FROM python:3.12-slim as builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.12-slim as production

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Copy virtual environment
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application
WORKDIR /app
COPY . .

# Run as non-root user
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8000/health')"

# Start application
CMD ["python", "main.py"]
```

## Build Commands

### Basic Build
```bash
docker build -t infinite-video:latest .
```

### With Version Tag
```bash
VERSION=$(git describe --tags --always)
docker build -t infinite-video:${VERSION} .
```

### Multi-stage for Size
```bash
# Uses builder pattern for smaller final image
docker build --target production -t infinite-video:latest .
```

### Multi-architecture
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t infinite-video:latest \
  --push .
```

## Docker Compose

### Development
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
      - ./output:/app/output
    env_file:
      - .env
    environment:
      - DEBUG=true

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Production
```yaml
# docker-compose.prod.yml
version: '3.8'

services:
  app:
    image: infinite-video:${VERSION}
    ports:
      - "8000:8000"
    env_file:
      - .env.production
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## Registry Push

```bash
# Docker Hub
docker tag infinite-video:latest username/infinite-video:latest
docker push username/infinite-video:latest

# GitHub Container Registry
docker tag infinite-video:latest ghcr.io/org/infinite-video:latest
docker push ghcr.io/org/infinite-video:latest

# AWS ECR
aws ecr get-login-password | docker login --username AWS --password-stdin ${ECR_URL}
docker tag infinite-video:latest ${ECR_URL}/infinite-video:latest
docker push ${ECR_URL}/infinite-video:latest
```

## Security Scan

```bash
# Scan image for vulnerabilities
docker scan infinite-video:latest

# Or use trivy
trivy image infinite-video:latest
```

## Size Optimization

```
Current: 1.2GB
After multi-stage: 450MB
With alpine base: 280MB

Tips:
- Use slim/alpine base images
- Multi-stage builds
- Minimize layers
- Clean up apt cache
- Use .dockerignore
```

## .dockerignore

```
# .dockerignore
.git
.gitignore
.env*
__pycache__
*.pyc
.pytest_cache
.mypy_cache
output/
tests/
docs/
*.md
!README.md
```
