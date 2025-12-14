---
description: Auto-fix code quality issues - formatting, imports, simple errors
argument-hint: [path]
allowed-tools: Bash, Read, Write, Edit
---

# Auto-Fix Code Quality Issues

Automatically fix code quality issues that can be safely corrected.

## Usage

```
/quality-fix                    # Fix entire project
/quality-fix src/pipelines/     # Fix specific directory
/quality-fix --dry-run          # Preview changes only
```

## What Gets Fixed

### Auto-Fixed (Safe)
- Code formatting (black/ruff format)
- Import sorting (isort)
- Trailing whitespace
- Missing newlines at EOF
- Unused imports removal
- Simple syntax fixes

### Requires Review
- Type annotation changes
- Security vulnerabilities
- Logic changes
- API modifications

## Fix Process

### Step 1: Format Code
```bash
ruff format .
```

### Step 2: Fix Linting Issues
```bash
ruff check . --fix
```

### Step 3: Sort Imports
```bash
ruff check . --select I --fix
```

### Step 4: Remove Unused
```bash
ruff check . --select F401,F841 --fix
```

## Dry Run Output

```
=== Dry Run: Quality Fix ===

Files to modify: 12

src/pipelines/idea2video_pipeline.py:
  - Line 5: Remove unused import 'os'
  - Line 23: Reformat long line
  - Line 45-47: Sort imports

src/agents/screenwriter.py:
  - Line 12: Remove trailing whitespace
  - Line 89: Add missing newline

Total changes: 27 fixes across 12 files
Run without --dry-run to apply.
```

## Safety

All changes are:
- Reversible (git checkout)
- Non-breaking (formatting only)
- Tested (no logic changes)

For complex issues:
- Security: Use `/quality-check` and review
- Types: Run `mypy` and fix manually
- Logic: Review with code reviewer agent
