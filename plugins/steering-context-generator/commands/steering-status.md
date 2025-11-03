---
description: Check the status of Steering Context Generator installation, last generation, and generated files
---

# Steering Context Generator - Status

View system status, generated files, and recommendations.

## Quick Start

```bash
/steering-status
```

## Expected Output

```
📊 Steering Context Generator - Status

═══════════════════════════════════════════════════════════

INSTALLATION
  Plugin Version: 1.0.0
  Installed: 2025-11-01 14:00:00
  Status: ✓ Ready

CONFIGURATION
  Config File: .claude/steering/config.json
  Parallel Execution: ✓ Enabled
  Incremental Updates: ✓ Enabled
  Output Format: markdown

LAST GENERATION
  Date: 2025-11-01 15:30:45 (1 day ago)
  Duration: 44 minutes
  Workflow: Standard (Moderate complexity)
  Agents: 7 executed
  Status: ✓ Complete

GENERATED FILES (.claude/steering/)
  ✓ ARCHITECTURE.md        342 KB    Fresh
  ✓ AI_CONTEXT.md          156 KB    Fresh
  ✓ CODEBASE_GUIDE.md      278 KB    Fresh
  ✓ DOMAIN_CONTEXT.md      189 KB    Fresh
  ✓ QUALITY_REPORT.md      134 KB    Fresh
  ✓ TESTING_GUIDE.md       167 KB    Fresh
  ✓ UI_DESIGN_SYSTEM.md    203 KB    Fresh

MEMORY USAGE
  Total: 1.2 MB
  Structure: 127 KB
  Domain: 189 KB
  Patterns: 98 KB
  Quality: 134 KB
  UI: 203 KB
  Testing: 167 KB
  Archives: 450 KB (2 previous runs)

CODEBASE STATUS
  Files Tracked: 387
  Last Change: 1 day ago (12 files modified)
  Tech Stack: Node.js/TypeScript, Next.js 14
  Complexity: Moderate

═══════════════════════════════════════════════════════════

RECOMMENDATIONS
  ⚠ Context may be outdated (12 files changed)
  → Run: /steering-update

  💡 Archive size growing (450 KB)
  → Run: /steering-clean

═══════════════════════════════════════════════════════════

QUICK ACTIONS
  /steering-update     Update with latest changes
  /steering-generate   Full regeneration
  /steering-clean      Clean up archives
  /steering-export     Export to other formats
```

## Implementation

```bash
#!/bin/bash

echo "📊 Steering Context Generator - Status"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo ""

# Check installation
if [ ! -f ".claude/steering/config.json" ]; then
  echo "❌ NOT INSTALLED"
  echo ""
  echo "Run: /steering-setup"
  exit 1
fi

# Plugin version
echo "INSTALLATION"
echo "  Plugin Version: 1.0.0"
if [ -f ".claude/memory/orchestration/state.json" ]; then
  INSTALLED=$(jq -r '.timestamp' .claude/memory/orchestration/state.json)
  echo "  Installed: $INSTALLED"
  echo "  Status: ✓ Ready"
else
  echo "  Status: ⚠ Incomplete setup"
fi
echo ""

# Configuration
echo "CONFIGURATION"
echo "  Config File: .claude/steering/config.json"
PARALLEL=$(jq -r '.parallel_execution' .claude/steering/config.json)
INCREMENTAL=$(jq -r '.incremental_updates' .claude/steering/config.json)
FORMAT=$(jq -r '.output_format' .claude/steering/config.json)
echo "  Parallel Execution: $([ "$PARALLEL" == "true" ] && echo "✓ Enabled" || echo "✗ Disabled")"
echo "  Incremental Updates: $([ "$INCREMENTAL" == "true" ] && echo "✓ Enabled" || echo "✗ Disabled")"
echo "  Output Format: $FORMAT"
echo ""

# Last generation
echo "LAST GENERATION"
if [ -f ".claude/memory/orchestration/state.json" ]; then
  LAST_RUN=$(jq -r '.last_run' .claude/memory/orchestration/state.json)
  if [ "$LAST_RUN" != "null" ]; then
    echo "  Date: $LAST_RUN"
    echo "  Status: ✓ Complete"
  else
    echo "  Status: ⚠ Never run"
    echo "  → Run: /steering-generate"
  fi
else
  echo "  Status: ⚠ No generation data"
fi
echo ""

# Generated files
echo "GENERATED FILES (.claude/steering/)"
if [ -d ".claude/steering" ]; then
  for file in .claude/steering/*.md; do
    if [ -f "$file" ]; then
      BASENAME=$(basename "$file")
      SIZE=$(du -h "$file" | cut -f1)
      AGE=$(find "$file" -mtime -1 2>/dev/null && echo "Fresh" || echo "Stale")
      echo "  ✓ $BASENAME$(printf '%*s' $((30-${#BASENAME})) '')$SIZE    $AGE"
    fi
  done
else
  echo "  ⚠ No files generated"
fi
echo ""

# Memory usage
echo "MEMORY USAGE"
if [ -d ".claude/memory" ]; then
  TOTAL=$(du -sh .claude 2>/dev/null | cut -f1)
  echo "  Total: $TOTAL"
else
  echo "  No memory data"
fi
echo ""

# Codebase status
echo "CODEBASE STATUS"
FILE_COUNT=$(find . -type f \
  -not -path "*/node_modules/*" \
  -not -path "*/.git/*" \
  -not -path "*/dist/*" \
  2>/dev/null | wc -l | tr -d ' ')
echo "  Files Tracked: $FILE_COUNT"

if git rev-parse --git-dir > /dev/null 2>&1; then
  LAST_COMMIT=$(git log -1 --format=%cd --date=relative)
  echo "  Last Change: $LAST_COMMIT"
fi
echo ""

echo "═══════════════════════════════════════════════════════════"
echo ""

# Recommendations
echo "RECOMMENDATIONS"
# Check if update needed
if [ -f ".claude/steering/ARCHITECTURE.md" ]; then
  CHANGED=$(find . -newer .claude/steering/ARCHITECTURE.md -type f \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    2>/dev/null | wc -l | tr -d ' ')
  if [ "$CHANGED" -gt 10 ]; then
    echo "  ⚠ Context may be outdated ($CHANGED files changed)"
    echo "  → Run: /steering-update"
    echo ""
  fi
fi

# Check archive size
if [ -d ".claude/memory/archives" ]; then
  ARCHIVE_SIZE=$(du -sm .claude/memory/archives 2>/dev/null | cut -f1)
  if [ "$ARCHIVE_SIZE" -gt 100 ]; then
    echo "  💡 Archive size growing (${ARCHIVE_SIZE}MB)"
    echo "  → Run: /steering-clean"
    echo ""
  fi
fi

echo "═══════════════════════════════════════════════════════════"
echo ""

echo "QUICK ACTIONS"
echo "  /steering-update     Update with latest changes"
echo "  /steering-generate   Full regeneration"
echo "  /steering-clean      Clean up archives"
echo "  /steering-export     Export to other formats"
```

## Status Indicators

**Installation Status**:
- ✓ Ready: Fully installed and configured
- ⚠ Incomplete: Missing files or configuration
- ❌ Not Installed: Run `/steering-setup`

**Generation Status**:
- ✓ Complete: Successfully generated
- ⏳ Running: Generation in progress
- ⚠ Never run: No generation yet
- ❌ Failed: Last generation failed

**File Freshness**:
- Fresh: Modified within 24 hours
- Stale: Modified >24 hours ago
- Missing: Expected file not found

## Checking Specific Information

### Installation Details
```bash
cat .claude/steering/config.json | jq '.'
```

### Generation History
```bash
cat .claude/memory/orchestration/state.json | jq '.'
```

### Memory Breakdown
```bash
du -sh .claude/memory/*/ | sort -h
```

### File Details
```bash
ls -lh .claude/steering/*.md
```

### Agent Status
```bash
cat .claude/memory/orchestration/agents.json | jq '.agents'
```

## Troubleshooting

### "Not Installed" Message
```bash
/steering-setup
```

### Missing Files
```bash
# Regenerate
/steering-generate

# Or validate
bash scripts/validate.sh
```

### Incorrect Status
```bash
# Reset state
rm .claude/memory/orchestration/state.json
bash scripts/init.sh
```

---

**Quick check:** Run `/steering-status` anytime!
