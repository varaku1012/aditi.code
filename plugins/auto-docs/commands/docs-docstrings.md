---
description: Generate or improve docstrings for Python code
argument-hint: [file|module] [--style google|numpy|sphinx]
allowed-tools: Read, Write, Edit, Glob
---

# Generate Docstrings

Add or improve docstrings for Python functions and classes.

## Usage

```
/docs-docstrings src/pipelines/     # Add to all files
/docs-docstrings src/agents/screenwriter.py  # Specific file
/docs-docstrings --style numpy      # Use NumPy style
/docs-docstrings --missing-only     # Only add missing
```

## Docstring Styles

### Google Style (default)
```python
def process_video(
    frames: list[Path],
    config: VideoConfig,
) -> VideoOutput:
    """Process frames into video output.

    Takes a sequence of frame images and generates
    a complete video file using the specified configuration.

    Args:
        frames: List of paths to frame images.
        config: Video generation configuration including
            resolution, framerate, and codec settings.

    Returns:
        VideoOutput containing the path to the generated
        video and associated metadata.

    Raises:
        ValueError: If frames list is empty.
        FileNotFoundError: If any frame file doesn't exist.
        EncodingError: If video encoding fails.

    Example:
        >>> frames = [Path("frame1.png"), Path("frame2.png")]
        >>> config = VideoConfig(fps=24)
        >>> output = process_video(frames, config)
        >>> print(output.video_path)
    """
```

### NumPy Style
```python
def process_video(frames, config):
    """
    Process frames into video output.

    Parameters
    ----------
    frames : list of Path
        List of paths to frame images.
    config : VideoConfig
        Video generation configuration.

    Returns
    -------
    VideoOutput
        Generated video output with metadata.

    Raises
    ------
    ValueError
        If frames list is empty.

    Examples
    --------
    >>> output = process_video(frames, config)
    """
```

### Sphinx Style
```python
def process_video(frames, config):
    """
    Process frames into video output.

    :param frames: List of paths to frame images.
    :type frames: list[Path]
    :param config: Video generation configuration.
    :type config: VideoConfig
    :returns: Generated video output.
    :rtype: VideoOutput
    :raises ValueError: If frames is empty.
    """
```

## Generated Content

### For Functions
- Brief description
- Detailed explanation (if complex)
- Args/Parameters
- Returns
- Raises
- Example usage

### For Classes
- Class purpose
- Attributes
- Example usage

### For Modules
- Module purpose
- Key components
- Usage overview

## Analysis Process

1. **Parse function signature**
   - Extract parameter names and types
   - Get return type annotation
   - Identify raised exceptions

2. **Analyze implementation**
   - Understand function purpose
   - Identify edge cases
   - Note side effects

3. **Generate docstring**
   - Write clear description
   - Document all parameters
   - Add relevant examples

## Options

### `--missing-only`
Only add docstrings to undocumented code.

### `--improve`
Enhance existing docstrings without overwriting.

### `--include-private`
Document private functions (_prefix).

### `--dry-run`
Preview changes without writing.

## Configuration

In `pyproject.toml`:
```toml
[tool.auto-docs]
docstring_style = "google"
include_examples = true
include_types = true
line_length = 88
```
