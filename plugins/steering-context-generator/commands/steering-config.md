---
description: View and modify Steering Context Generator configuration settings
---

# Steering Context Generator - Configuration

View and customize system configuration.

## Quick Start

**View config**:
```bash
cat .claude/steering/config.json | jq '.'
```

**Edit config**:
```bash
vim .claude/steering/config.json
```

## Default Configuration

```json
{
  "version": "1.0.0",
  "initialized": true,
  "created": "2025-11-02T12:00:00Z",
  "excluded_patterns": [
    "node_modules/**",
    ".git/**",
    "dist/**",
    "build/**",
    ".next/**",
    "__pycache__/**",
    "*.pyc",
    "*.log"
  ],
  "focus_areas": [
    "architecture",
    "security",
    "performance",
    "testing"
  ],
  "output_format": "markdown",
  "parallel_execution": true,
  "incremental_updates": true
}
```

## Configuration Options

### Excluded Patterns

**Files/directories to skip**:
```json
"excluded_patterns": [
  "node_modules/**",       // Dependencies
  ".git/**",               // Version control
  "dist/**", "build/**",   // Build outputs
  "coverage/**",           // Test coverage
  "*.min.js",              // Minified files
  "vendor/**"              // Third-party code
]
```

### Focus Areas

**Analysis priorities**:
```json
"focus_areas": [
  "architecture",    // System design
  "security",        // Vulnerabilities
  "performance",     // Bottlenecks
  "testing",         // Test coverage
  "documentation"    // Code docs
]
```

### Execution Options

```json
"parallel_execution": true,    // Run agents in parallel (55% faster)
"incremental_updates": true   // Enable delta updates
```

## Common Customizations

### For Large Monorepos

```json
{
  "excluded_patterns": [
    "packages/*/node_modules/**",
    "apps/*/dist/**",
    "*.lock"
  ],
  "parallel_execution": true
}
```

### For Security-Focused Analysis

```json
{
  "focus_areas": ["security", "quality"],
  "deep_scan_enabled": true
}
```

### For Fast Iterations

```json
{
  "excluded_patterns": [
    "**/*.test.ts",
    "**/*.spec.ts",
    "**/__tests__/**"
  ],
  "parallel_execution": true
}
```

## Validation

After editing, validate config:
```bash
jq empty .claude/steering/config.json && echo "✓ Valid JSON" || echo "✗ Invalid JSON"
```

---

**Customize your analysis:** Edit `.claude/steering/config.json`
