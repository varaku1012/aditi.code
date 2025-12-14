---
description: Analyze test coverage with detailed reports and gap identification
argument-hint: [--html] [--threshold N]
allowed-tools: Bash, Read, Write, Glob
---

# Test Coverage Analysis

Generate detailed test coverage reports.

## Usage

```
/test-coverage                      # Terminal report
/test-coverage --html               # HTML report
/test-coverage --threshold 80       # Fail if below threshold
/test-coverage --diff main          # Coverage of changes only
```

## Coverage Report

### Terminal Output
```
Name                                      Stmts   Miss  Cover   Missing
-----------------------------------------------------------------------
src/pipelines/idea2video_pipeline.py        234     45    81%   45-67, 120-135
src/pipelines/script2video_pipeline.py      189     23    88%   78-89
src/agents/screenwriter.py                  156     12    92%   34-39
src/agents/character_extractor.py           123      8    93%   56-60
src/agents/storyboard_artist.py             201     67    67%   90-156
src/tools/image_generators/nanobanana.py     89     45    49%   23-67
src/tools/video_generators/veo.py            76     38    50%   12-50
-----------------------------------------------------------------------
TOTAL                                      1068    238    78%

Coverage: 78% (Target: 80%)
```

### Coverage by Component

```
┌────────────────────────────────────────┐
│           Coverage by Module           │
├────────────────────────────────────────┤
│ Pipelines   ████████▒░  84%           │
│ Agents      █████████░  91%           │
│ Tools       █████░░░░░  50%  ⚠️       │
│ Interfaces  ██████████  98%           │
│ Utils       ███████░░░  72%           │
└────────────────────────────────────────┘
```

## Gap Analysis

### Untested Code

**Critical Gaps (high-risk untested code):**
1. `tools/video_generators/veo.py:12-50` - API error handling
2. `tools/image_generators/nanobanana.py:23-67` - Rate limiting logic
3. `pipelines/idea2video_pipeline.py:120-135` - Retry logic

**Suggested Tests:**
```python
# tests/unit/test_veo_error_handling.py
async def test_veo_api_timeout():
    """Test handling of API timeout."""
    pass

async def test_veo_rate_limit():
    """Test rate limit backoff."""
    pass
```

## HTML Report

Generate interactive HTML report:
```bash
pytest --cov=src --cov-report=html
open htmlcov/index.html
```

Features:
- Line-by-line coverage highlighting
- Branch coverage visualization
- Module drill-down
- Historical trends

## Thresholds

Set coverage requirements:

### pyproject.toml
```toml
[tool.coverage.run]
source = ["src"]
branch = true

[tool.coverage.report]
fail_under = 80
exclude_lines = [
    "pragma: no cover",
    "if TYPE_CHECKING:",
    "raise NotImplementedError",
]
```

### CI/CD Gate
```yaml
- name: Coverage Check
  run: |
    pytest --cov=src --cov-fail-under=80
```

## Diff Coverage

Check coverage of changed lines only:
```bash
diff-cover coverage.xml --compare-branch=main
```

Useful for:
- PR reviews
- Incremental improvements
- Focus on new code
