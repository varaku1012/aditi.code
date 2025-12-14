---
description: Check CI/CD pipeline status and manage workflows
argument-hint: [--branch] [--workflow] [--logs]
allowed-tools: Bash, Read, WebFetch
---

# CI/CD Status

Check and manage CI/CD pipeline status.

## Usage

```
/ci-status                          # Current branch status
/ci-status --branch main            # Specific branch
/ci-status --workflow tests         # Specific workflow
/ci-status --logs                   # Show recent logs
```

## Status Dashboard

```
┌────────────────────────────────────────────────┐
│           CI/CD Pipeline Status                │
├────────────────────────────────────────────────┤
│ Branch: feature/video-api                      │
│ Commit: abc123f "Add video generation API"     │
├────────────────────────────────────────────────┤
│ Workflows:                                     │
│ ✓ lint          Passed    (2m 34s)            │
│ ✓ tests         Passed    (5m 12s)            │
│ ✓ security      Passed    (1m 45s)            │
│ ● build         Running   (3m 22s)            │
│ ○ deploy        Pending                        │
├────────────────────────────────────────────────┤
│ Overall: In Progress (4/5 complete)            │
└────────────────────────────────────────────────┘
```

## GitHub Actions

### Check Status
```bash
# List recent runs
gh run list --limit 5

# Check specific run
gh run view 12345

# Watch running workflow
gh run watch
```

### Trigger Workflow
```bash
# Trigger manually
gh workflow run tests.yml

# With inputs
gh workflow run deploy.yml -f environment=staging
```

### View Logs
```bash
# Download logs
gh run download 12345 --name logs

# View in terminal
gh run view 12345 --log
```

## Workflow Files

### Test Workflow
```yaml
# .github/workflows/tests.yml
name: Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install dependencies
        run: |
          pip install uv
          uv sync --frozen

      - name: Run tests
        run: pytest tests/ --cov=src

      - name: Upload coverage
        uses: codecov/codecov-action@v4
```

### Deploy Workflow
```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      environment:
        type: choice
        options: [staging, production]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ github.event.inputs.environment || 'staging' }}
    steps:
      - uses: actions/checkout@v4

      - name: Deploy to Railway
        run: railway up
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
```

## Pipeline Metrics

```
Last 30 days:
- Total runs: 156
- Success rate: 94.2%
- Avg duration: 8m 34s

Slowest stages:
1. tests (5m 12s avg)
2. build (3m 45s avg)
3. security (1m 30s avg)

Most failures:
1. tests (6 failures)
2. build (2 failures)
3. lint (1 failure)
```

## Troubleshooting

### Common Issues

**Tests Failing**
```
/ci-status --workflow tests --logs

Error: test_video_generation failed
Reason: API timeout
Fix: Increase timeout or mock API calls
```

**Build Failing**
```
/ci-status --workflow build --logs

Error: Docker build failed
Reason: Missing dependency
Fix: Add to requirements.txt
```

### Re-run Failed Jobs
```bash
# Re-run failed jobs only
gh run rerun 12345 --failed

# Re-run entire workflow
gh run rerun 12345
```
