---
description: Generate detailed code quality report with metrics and trends
argument-hint: [--format json|html|md]
allowed-tools: Bash, Read, Write, Glob
---

# Code Quality Report

Generate a comprehensive code quality report.

## Usage

```
/quality-report                     # Generate markdown report
/quality-report --format json       # JSON for CI/CD
/quality-report --format html       # HTML dashboard
/quality-report --compare main      # Compare with branch
```

## Report Sections

### 1. Summary Dashboard
```
┌─────────────────────────────────────┐
│     Code Quality Score: 87/100     │
├─────────────────────────────────────┤
│ Linting:     ████████░░  85%       │
│ Type Safety: █████████░  92%       │
│ Security:    ██████████  100%      │
│ Test Cov:    ███████░░░  72%       │
│ Complexity:  ████████░░  80%       │
└─────────────────────────────────────┘
```

### 2. Metrics

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Lines of Code | 5,234 | - | Info |
| Lint Issues | 12 | <20 | ✅ |
| Type Coverage | 92% | >90% | ✅ |
| Test Coverage | 72% | >80% | ⚠️ |
| Cyclomatic Complexity | 8.2 | <10 | ✅ |
| Security Issues | 0 | 0 | ✅ |

### 3. Hot Spots

Files with most issues:
```
1. src/tools/video_generator.py - 5 issues
2. src/agents/character_extractor.py - 3 issues
3. src/pipelines/idea2video_pipeline.py - 2 issues
```

### 4. Trends

```
Quality Score Over Time:
100 ┤
 90 ┤    ╭──────╮
 80 ┼────╯      ╰────
 70 ┤
    └───────────────────
    -7d  -5d  -3d  -1d  now
```

### 5. Recommendations

**Priority Actions:**
1. ⚠️ Increase test coverage in `tools/` (currently 45%)
2. 📝 Add type hints to `agents/screenwriter.py`
3. 🔄 Reduce complexity in `process_frames()` function

## Output Formats

### Markdown (default)
```markdown
# Quality Report - 2025-12-13
...
```

### JSON (CI/CD)
```json
{
  "score": 87,
  "metrics": {...},
  "issues": [...],
  "timestamp": "2025-12-13T15:00:00Z"
}
```

### HTML
Interactive dashboard with charts and drill-down.

## CI/CD Integration

```yaml
# GitHub Actions
- name: Quality Gate
  run: |
    /quality-report --format json > report.json
    score=$(jq '.score' report.json)
    if [ $score -lt 80 ]; then
      exit 1
    fi
```
