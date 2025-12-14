---
description: Manage video generation job queue - list, prioritize, cancel jobs
argument-hint: [list|cancel|priority] [job-id]
allowed-tools: Bash, Read, Write, Glob
---

# Video Queue Management

Manage the video generation job queue.

## Commands

```
/video-queue list                    # List all queued jobs
/video-queue cancel job_002          # Cancel a pending job
/video-queue priority job_003 high   # Set job priority
/video-queue clear                   # Clear all pending jobs
```

## Queue Operations

### List Jobs
Shows all jobs with their status:
- Position in queue
- Job ID and type
- Priority level
- Estimated start time

### Cancel Job
Cancels a pending or running job:
- Stops any running processes
- Preserves checkpoint files
- Marks job as cancelled

### Set Priority
Adjust queue position:
- `high` - Move to front
- `normal` - Default priority
- `low` - Run when idle

## Queue File Format

Jobs are tracked in `queue/jobs.json`:

```json
{
  "jobs": [
    {
      "id": "job_001",
      "type": "idea2video",
      "status": "running",
      "priority": "normal",
      "created": "2025-12-13T14:30:00Z",
      "started": "2025-12-13T14:30:05Z",
      "config": {
        "idea": "A cat playing piano",
        "style": "cartoon"
      }
    }
  ]
}
```

## Concurrency

Default: 1 concurrent job (API rate limits)
Configure in `configs/queue.yaml`:

```yaml
max_concurrent_jobs: 1
retry_failed_jobs: true
max_retries: 3
job_timeout_minutes: 60
```
