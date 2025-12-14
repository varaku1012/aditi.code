---
description: Retry failed video generation jobs from last checkpoint
argument-hint: [job-id] [--from-stage]
allowed-tools: Bash(python:*), Read, Write, Glob
---

# Retry Failed Jobs

Resume or retry failed video generation jobs.

## Usage

```
/video-retry job_001                      # Retry from last checkpoint
/video-retry job_001 --from-stage frames  # Retry from specific stage
/video-retry job_001 --fresh              # Start completely fresh
```

## Resume Logic

The pipeline automatically detects checkpoints:

1. **Check existing files**
   - `characters.json` exists? Skip extraction
   - `storyboard.json` exists? Skip design
   - `shot_X/first_frame.png` exists? Skip that frame

2. **Resume from checkpoint**
   - Load previous state
   - Continue from next incomplete step
   - Preserve all completed work

## Stage Options

Retry from a specific stage:

```
--from-stage story      # Redo story development
--from-stage characters # Redo character extraction
--from-stage storyboard # Redo shot design
--from-stage frames     # Redo frame generation
--from-stage video      # Redo video synthesis
--from-stage compose    # Redo final composition
```

## Common Failure Scenarios

### API Rate Limit
```
Error: Rate limit exceeded
Solution: Wait and retry, or reduce parallel requests
Command: /video-retry job_001
```

### Invalid Response
```
Error: Failed to parse LLM response
Solution: Retry with fresh context
Command: /video-retry job_001 --from-stage storyboard
```

### Generation Failed
```
Error: Image generation failed
Solution: Retry specific shots
Command: /video-retry job_001 --from-stage frames
```

## Retry Configuration

In `configs/retry.yaml`:

```yaml
auto_retry: true
max_retries: 3
retry_delay_seconds: 30
exponential_backoff: true
preserve_checkpoints: true
```
