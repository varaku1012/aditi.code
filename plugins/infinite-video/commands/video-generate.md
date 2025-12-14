---
description: Generate a video from an idea or script using InfiniteMedia pipeline
argument-hint: [idea|script] [content]
allowed-tools: Bash(python:*), Read, Write, Glob
---

# Video Generation Command

Generate a complete video using the InfiniteMedia multi-agent pipeline.

## Usage

```
/video-generate idea "A cat learning to play piano in a cozy apartment"
/video-generate script @scripts/my_story.txt
```

## Parameters

- **Type**: `idea` or `script`
  - `idea`: Uses Idea2VideoPipeline (full story development)
  - `script`: Uses Script2VideoPipeline (direct storyboarding)
- **Content**: The idea text or path to script file

## Process

1. **Validate Input**
   - Check content length and format
   - Verify config file exists

2. **Select Pipeline**
   - Idea: `python main_idea2video.py`
   - Script: `python main_script2video.py`

3. **Configure Job**
   - Set working directory
   - Apply style parameters
   - Configure API keys

4. **Execute Pipeline**
   - Run generation asynchronously
   - Monitor progress
   - Report completion status

## Configuration

Edit `configs/idea2video.yaml` or `configs/script2video.yaml`:

```yaml
chat_model:
  model: openrouter/anthropic/claude-sonnet

image_generator:
  class_path: tools.image_generators.nanobanana

video_generator:
  class_path: tools.video_generators.veo

working_dir: ./output/job_001
```

## Output

Job will create:
- `characters.json` - Extracted characters
- `story.txt` - Developed story (idea mode)
- `storyboard.json` - Shot descriptions
- `shot_*/` - Per-shot frames and videos
- `final_video.mp4` - Composited output
