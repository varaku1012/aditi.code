---
description: Run comprehensive code quality checks - linting, type checking, security scan
argument-hint: [--fix] [path]
allowed-tools: Bash, Read, Grep, Glob
---

# Code Quality Check

Run all code quality checks on the codebase.

## Usage

```
/quality-check                  # Check entire project
/quality-check src/             # Check specific directory
/quality-check --fix            # Auto-fix issues
/quality-check --fix src/api/   # Fix specific path
```

## Checks Performed

### 1. Python Linting (Ruff)
```bash
ruff check . --output-format=grouped
```
- Style violations (PEP 8)
- Import sorting
- Unused imports/variables
- Code complexity

### 2. Type Checking (MyPy)
```bash
mypy . --ignore-missing-imports
```
- Type annotation errors
- Type mismatches
- Missing return types

### 3. Security Scan (Bandit)
```bash
bandit -r . -ll
```
- Hardcoded secrets
- SQL injection risks
- Shell injection
- Unsafe deserialization

### 4. Dependency Check
```bash
pip-audit
```
- Known vulnerabilities
- Outdated packages
- Security advisories

## Output Format

```
=== Code Quality Report ===

✅ Linting: 0 issues
⚠️  Type Checking: 3 warnings
❌ Security: 1 critical issue
✅ Dependencies: All secure

Total Issues: 4
- Critical: 1
- Warning: 3
- Info: 0

Details:
[Detailed findings listed here]
```

## Configuration

### pyproject.toml
```toml
[tool.ruff]
line-length = 88
select = ["E", "F", "W", "I", "N", "UP", "B", "C4"]
ignore = ["E501"]

[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_ignores = true

[tool.bandit]
exclude_dirs = ["tests", "venv"]
```

## Auto-Fix

With `--fix` flag:
- Auto-format with ruff
- Sort imports
- Remove unused imports
- Apply safe transformations

**Not auto-fixed:**
- Type errors (manual review)
- Security issues (manual review)
- Logic errors
