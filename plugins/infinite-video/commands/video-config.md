---
description: Configure video generation settings - models, APIs, quality, output
argument-hint: [show|set|reset] [key] [value]
allowed-tools: Read, Write, Edit
---

# Video Configuration

Manage video generation pipeline settings.

## Usage

```
/video-config show                    # Show all settings
/video-config show chat_model         # Show specific setting
/video-config set style cartoon       # Set a value
/video-config reset                   # Reset to defaults
```

## Configuration Files

### `configs/idea2video.yaml`
Full pipeline from idea to video.

### `configs/script2video.yaml`
Direct script to video conversion.

## Key Settings

### Chat Model (LLM)
```yaml
chat_model:
  model: openrouter/anthropic/claude-sonnet
  api_key: ${OPENROUTER_API_KEY}
  base_url: https://openrouter.ai/api/v1
  temperature: 0.7
```

### Image Generator
```yaml
image_generator:
  class_path: tools.image_generators.nanobanana.NanobananImageGenerator
  api_key: ${GOOGLE_API_KEY}
  model: imagen-3.0-generate-001
```

### Video Generator
```yaml
video_generator:
  class_path: tools.video_generators.veo.VeoVideoGenerator
  api_key: ${GOOGLE_API_KEY}
  model: veo-001
```

### Output Settings
```yaml
working_dir: ./output/${JOB_ID}
output_format: mp4
resolution: 1920x1080
fps: 24
```

### Quality Settings
```yaml
quality:
  image_quality: high
  video_quality: high
  frame_consistency: true
  character_consistency: true
```

## Environment Variables

Required API keys (set in `.env`):
```bash
OPENROUTER_API_KEY=your_key
GOOGLE_API_KEY=your_key
YUNWU_API_KEY=your_key  # Optional
```

## Presets

Quick configuration presets:

```
/video-config preset fast    # Lower quality, faster
/video-config preset quality # Higher quality, slower
/video-config preset draft   # Quick preview
```
