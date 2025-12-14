---
description: Generate API reference documentation from code
argument-hint: [module] [--format md|json]
allowed-tools: Read, Write, Glob, Grep
---

# Generate API Documentation

Create API reference documentation from Python code.

## Usage

```
/docs-api                           # Document all modules
/docs-api src/pipelines/            # Specific module
/docs-api --format json             # JSON output for tools
```

## What Gets Documented

### Classes
```python
class VideoGenerator:
    """
    Generates videos from frame sequences.

    This class handles the video synthesis process,
    coordinating frame assembly and encoding.

    Attributes:
        config: Video generation configuration
        api_client: External API client for generation

    Example:
        >>> generator = VideoGenerator(config)
        >>> video = await generator.generate(frames)
    """
```

### Functions
```python
async def process_script(
    script: Script,
    config: VideoConfig,
    *,
    timeout: int = 30,
) -> VideoOutput:
    """
    Process a script into video output.

    Args:
        script: The validated script to process
        config: Video generation configuration
        timeout: Maximum processing time in seconds

    Returns:
        VideoOutput containing the generated video path
        and metadata.

    Raises:
        ValidationError: If script is invalid
        TimeoutError: If processing exceeds timeout
        APIError: If external API fails

    Example:
        >>> output = await process_script(script, config)
        >>> print(output.video_path)
    """
```

### Pydantic Models
```python
class VideoOutput(BaseModel):
    """
    Output from video generation.

    Attributes:
        video_path: Path to generated video file
        duration: Video duration in seconds
        resolution: Video resolution (width, height)
        frames_used: Number of frames in video
        metadata: Additional generation metadata
    """
    video_path: Path
    duration: float
    resolution: tuple[int, int]
    frames_used: int
    metadata: dict[str, Any] = {}
```

## Output Format

### Markdown
```markdown
# API Reference

## pipelines

### Idea2VideoPipeline

Transforms an idea into a complete video.

#### Constructor

```python
Idea2VideoPipeline(config: PipelineConfig)
```

**Parameters:**
- `config` (PipelineConfig): Pipeline configuration

#### Methods

##### run

```python
async def run(
    idea: str,
    style: str = "default"
) -> VideoOutput
```

Run the full idea-to-video pipeline.

**Parameters:**
- `idea` (str): The video idea/concept
- `style` (str): Visual style preset

**Returns:**
- `VideoOutput`: Generated video output

**Raises:**
- `ValidationError`: If idea is empty
- `GenerationError`: If any stage fails
```

### JSON (for tools)
```json
{
  "modules": {
    "pipelines.idea2video_pipeline": {
      "classes": {
        "Idea2VideoPipeline": {
          "docstring": "...",
          "methods": {
            "run": {
              "signature": "async def run(idea: str, style: str = 'default') -> VideoOutput",
              "parameters": [...],
              "returns": {...},
              "raises": [...]
            }
          }
        }
      }
    }
  }
}
```

## Auto-Detection

The command automatically detects:
- Public classes and functions
- Type annotations
- Docstrings (Google, NumPy, Sphinx style)
- Pydantic models
- Dataclasses
