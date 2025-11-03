#!/bin/bash

echo "🔍 Validating Steering Context Generator installation..."

ERRORS=0

# Check directory structure
echo ""
echo "Checking directory structure..."
REQUIRED_DIRS=(
    ".claude/steering"
    ".claude/memory/structure"
    ".claude/memory/domain"
    ".claude/memory/patterns"
    ".claude/memory/quality"
    ".claude/memory/synthesis"
    ".claude/memory/orchestration"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✓ $dir"
    else
        echo "  ✗ $dir (missing)"
        ((ERRORS++))
    fi
done

# Check configuration
echo ""
echo "Checking configuration..."
if [ -f ".claude/steering/config.json" ]; then
    if jq empty .claude/steering/config.json 2>/dev/null; then
        echo "  ✓ config.json (valid JSON)"
    else
        echo "  ✗ config.json (invalid JSON)"
        ((ERRORS++))
    fi
else
    echo "  ✗ config.json (missing)"
    ((ERRORS++))
fi

# Check orchestration state
echo ""
echo "Checking orchestration state..."
if [ -f ".claude/memory/orchestration/state.json" ]; then
    if jq empty .claude/memory/orchestration/state.json 2>/dev/null; then
        echo "  ✓ state.json (valid JSON)"
    else
        echo "  ✗ state.json (invalid JSON)"
        ((ERRORS++))
    fi
else
    echo "  ✗ state.json (missing)"
    ((ERRORS++))
fi

# Check generated outputs (if any)
echo ""
echo "Checking generated outputs..."
if [ -d ".claude/steering" ]; then
    MD_COUNT=$(find .claude/steering -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
    if [ "$MD_COUNT" -gt 0 ]; then
        echo "  ✓ Found $MD_COUNT steering documents"
        find .claude/steering -maxdepth 1 -name "*.md" -exec basename {} \; | while read file; do
            echo "    - $file"
        done
    else
        echo "  ⚠ No steering documents generated yet (run /steering-generate)"
    fi
fi

# Check disk space
echo ""
echo "Checking disk space..."
USAGE=$(du -sh .claude 2>/dev/null | cut -f1)
echo "  ℹ Current usage: $USAGE"

# Final result
echo ""
echo "────────────────────────────────────────"
if [ $ERRORS -eq 0 ]; then
    echo "✅ Validation passed! System is healthy."
    exit 0
else
    echo "❌ Validation failed with $ERRORS error(s)."
    echo ""
    echo "To fix, run: /steering-setup"
    exit 1
fi
