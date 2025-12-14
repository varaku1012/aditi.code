---
description: Check status of video generation jobs and view progress
argument-hint: [job-id|all]
allowed-tools: Bash(ls:*), Bash(cat:*), Read, Glob
---

# Video Job Status

Check the status of video generation jobs.

## Usage

```
/video-status all           # List all jobs
/video-status job_001       # Check specific job
/video-status latest        # Check most recent job
```

## Status Information

Shows for each job:
- **Job ID**: Unique identifier
- **Status**: pending | running | completed | failed
- **Pipeline**: idea2video | script2video
- **Progress**: Current stage and completion %
- **Duration**: Time elapsed
- **Output**: Path to generated files

## Progress Stages

### Idea2Video Pipeline
1. Story Development (10%)
2. Character Extraction (20%)
3. Portrait Generation (30%)
4. Script Writing (40%)
5. Storyboarding (60%)
6. Frame Generation (80%)
7. Video Synthesis (90%)
8. Composition (100%)

### Script2Video Pipeline
1. Character Extraction (15%)
2. Storyboard Design (30%)
3. Camera Tree Construction (45%)
4. Frame Generation (70%)
5. Video Synthesis (85%)
6. Composition (100%)

## Checkpoint Files

Check these files to verify stage completion:
- `characters.json` - Characters extracted
- `story.txt` - Story developed
- `script.json` - Script generated
- `storyboard.json` - Shots designed
- `camera_tree.json` - Camera positions set
- `shot_*/first_frame.png` - Frames generated
- `shot_*/video.mp4` - Videos synthesized

## Example Output

```
Job: job_001
Status: running
Pipeline: idea2video
Progress: Frame Generation (65%)
Started: 2025-12-13 14:30:00
Elapsed: 12m 34s
Shots: 8/12 completed
Output: ./output/job_001/
```
