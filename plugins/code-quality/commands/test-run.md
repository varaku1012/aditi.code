---
description: Run tests with intelligent filtering and parallel execution
argument-hint: [path|pattern] [--failed] [--watch]
allowed-tools: Bash, Read, Grep, Glob
---

# Run Tests

Execute tests with smart filtering and reporting.

## Usage

```
/test-run                          # Run all tests
/test-run tests/unit/              # Run specific directory
/test-run test_pipeline            # Run matching pattern
/test-run --failed                 # Re-run failed tests only
/test-run --watch                  # Watch mode
```

## Test Execution

### Default Run
```bash
pytest tests/ -v --tb=short
```

### With Coverage
```bash
pytest tests/ --cov=src --cov-report=term-missing
```

### Parallel Execution
```bash
pytest tests/ -n auto
```

### Failed Only
```bash
pytest tests/ --lf
```

## Test Categories

### Unit Tests
```bash
pytest tests/unit/ -v
```
- Fast, isolated tests
- Mock external dependencies
- Run frequently

### Integration Tests
```bash
pytest tests/integration/ -v -m integration
```
- Test component interactions
- May use real services
- Run before merge

### E2E Tests
```bash
pytest tests/e2e/ -v -m e2e
```
- Full pipeline tests
- Slowest but most comprehensive
- Run before release

## Output

```
======================== test session starts ========================
platform linux -- Python 3.12.0, pytest-8.0.0
collected 156 items

tests/unit/test_character_extractor.py ......                  [  4%]
tests/unit/test_storyboard_artist.py ........                  [ 10%]
tests/unit/test_video_generator.py .....                       [ 14%]
tests/integration/test_pipeline.py .....                       [ 17%]
...

====================== 152 passed, 4 skipped ======================
Duration: 45.2s
Coverage: 78%
```

## Watch Mode

Automatically re-run tests on file changes:
```bash
pytest-watch tests/ -- -v --tb=short
```

Shows:
- Changed files detected
- Affected tests
- Quick feedback loop

## Markers

Filter tests by marker:
```bash
pytest -m "not slow"           # Skip slow tests
pytest -m "api"                # Only API tests
pytest -m "not integration"    # Skip integration
```

Define markers in `pytest.ini`:
```ini
[pytest]
markers =
    slow: marks tests as slow
    integration: integration tests
    api: API tests
    e2e: end-to-end tests
```
