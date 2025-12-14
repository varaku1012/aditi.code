---
description: Sync documentation with code changes - identify outdated docs
argument-hint: [--fix] [--report]
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Sync Documentation

Identify and fix documentation that's out of sync with code.

## Usage

```
/docs-sync                          # Check for mismatches
/docs-sync --fix                    # Auto-fix issues
/docs-sync --report                 # Generate detailed report
```

## What Gets Checked

### 1. Function Signatures
- Parameter names match docstring
- Return types are documented
- New parameters are documented

### 2. Class Attributes
- All attributes documented
- Types are accurate
- Removed attributes cleaned up

### 3. README Accuracy
- Installation steps work
- Examples are runnable
- File paths exist

### 4. API Documentation
- All public APIs documented
- Signatures are current
- Examples compile

## Sync Report

```markdown
## Documentation Sync Report

### Out of Sync: 5 items

#### Critical (broken docs)
1. `src/pipelines/idea2video.py:process_idea`
   - Docstring mentions `timeout` parameter
   - Parameter was removed in recent commit
   - Fix: Remove from docstring

2. `README.md:Installation`
   - Shows `pip install infinitemedia`
   - Package name is `infinite-video`
   - Fix: Update package name

#### Warnings (incomplete)
1. `src/agents/screenwriter.py:generate_story`
   - New parameter `temperature` not documented
   - Fix: Add to Args section

2. `docs/api/tools.md`
   - Missing documentation for `VeoVideoGenerator`
   - Fix: Generate API docs

#### Info (style issues)
1. `src/tools/nanobanana.py`
   - Docstring uses NumPy style
   - Project uses Google style
   - Fix: Convert to Google style
```

## Auto-Fix

With `--fix` flag:

### Safe Fixes (automatic)
- Add missing parameters to docstrings
- Remove deleted parameters
- Update type annotations
- Fix file path references

### Manual Review Required
- Change function descriptions
- Update complex examples
- Modify architecture docs

## CI/CD Integration

```yaml
# GitHub Actions
- name: Check Docs Sync
  run: |
    /docs-sync --report > sync-report.md
    if grep -q "Critical" sync-report.md; then
      exit 1
    fi
```

## Configuration

In `docs-sync.yaml`:
```yaml
check:
  - docstrings
  - readme
  - api_docs
  - examples

ignore:
  - "tests/*"
  - "scripts/*"

strict_mode: false  # Fail on warnings too
```

## Keeping Docs Fresh

### Pre-commit Hook
```yaml
# .pre-commit-config.yaml
- repo: local
  hooks:
    - id: docs-sync
      name: Check documentation sync
      entry: /docs-sync
      language: system
      pass_filenames: false
```

### PR Template
```markdown
## Documentation
- [ ] Docstrings updated for changed functions
- [ ] README updated if needed
- [ ] API docs regenerated
```
