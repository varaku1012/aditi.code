---
description: Check infrastructure health and resource status
argument-hint: [--full] [--fix]
allowed-tools: Bash, Read, WebFetch
---

# Infrastructure Check

Verify infrastructure health and resource availability.

## Usage

```
/infra-check                        # Quick health check
/infra-check --full                 # Comprehensive check
/infra-check --fix                  # Auto-fix common issues
```

## Health Checks

### Quick Check
```
┌─────────────────────────────────────────┐
│        Infrastructure Health            │
├─────────────────────────────────────────┤
│ Services:                               │
│ ✓ API Server      Running (8000)       │
│ ✓ Redis           Running (6379)       │
│ ✓ PostgreSQL      Running (5432)       │
│                                         │
│ External APIs:                          │
│ ✓ OpenRouter      Connected            │
│ ✓ Google API      Connected            │
│ ⚠ Yunwu API       Rate Limited         │
│                                         │
│ Storage:                                │
│ ✓ Disk Space      45GB free (67%)      │
│ ✓ Output Dir      Writable             │
│                                         │
│ Overall: Healthy (1 warning)            │
└─────────────────────────────────────────┘
```

### Full Check
```
=== Full Infrastructure Report ===

## Compute
- CPU Usage: 23% (4 cores)
- Memory: 4.2GB / 16GB (26%)
- Load Average: 0.45, 0.52, 0.48

## Storage
- Root Disk: 45GB / 100GB (45%)
- Output Dir: 12GB used
- Temp Space: 8GB free

## Network
- Outbound: OK
- API Latency:
  - OpenRouter: 145ms
  - Google: 89ms
  - Yunwu: 234ms

## Services
- API Server: Running (PID 12345)
  - Uptime: 3 days 12 hours
  - Requests: 1,234 (last hour)
  - Errors: 2 (0.16%)

## Dependencies
- Python: 3.12.0 ✓
- FFmpeg: 6.1 ✓
- Docker: 24.0.7 ✓
```

## Checks Performed

### Service Health
```bash
# Check API server
curl -f http://localhost:8000/health

# Check database
pg_isready -h localhost -p 5432

# Check Redis
redis-cli ping
```

### API Connectivity
```bash
# Test OpenRouter
curl -H "Authorization: Bearer ${OPENROUTER_API_KEY}" \
  https://openrouter.ai/api/v1/models

# Test Google API
curl "https://generativelanguage.googleapis.com/v1/models?key=${GOOGLE_API_KEY}"
```

### Resource Usage
```bash
# Disk space
df -h /

# Memory
free -h

# CPU
top -bn1 | head -5
```

### Dependencies
```bash
# Python packages
pip check

# System dependencies
which ffmpeg
ffmpeg -version
```

## Auto-Fix

With `--fix` flag:

### Fixable Issues
- Clear temp files when disk low
- Restart crashed services
- Rotate logs when too large
- Refresh expired tokens

### Manual Action Required
- Upgrade dependencies
- Scale resources
- Fix API credentials
- Resolve network issues

## Alerts Configuration

In `infra.yaml`:
```yaml
alerts:
  disk_space:
    warning: 80%
    critical: 90%

  memory:
    warning: 85%
    critical: 95%

  api_latency:
    warning: 500ms
    critical: 2000ms

notifications:
  slack: https://hooks.slack.com/...
  email: ops@company.com
```

## Monitoring Integration

### Prometheus Metrics
```
# Exposed at /metrics
http_requests_total
http_request_duration_seconds
video_generation_duration_seconds
api_call_duration_seconds
```

### Grafana Dashboard
```
/infra-check --dashboard

Opens Grafana at: http://localhost:3000/d/infra
```
