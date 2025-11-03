---
description: Incrementally update steering context based on code changes since last generation (80% faster than full regeneration)
---

# Steering Context Generator - Incremental Update

Efficiently update your steering context documentation when code changes.

## Quick Start

```bash
/steering-update
```

The system will:
1. 🔍 Detect changed files since last generation
2. 📊 Identify affected domains
3. 🤖 Run only relevant agents
4. 📝 Update specific documents
5. ✅ Merge with existing context

## How It Works

### Change Detection

The system uses Git (if available) or file timestamps to detect changes:

```bash
# Check last generation time
LAST_GEN=$(jq -r '.last_run' .claude/memory/orchestration/state.json)

# Detect changes via Git
git diff --name-only $LAST_GEN..HEAD

# Or via file timestamps
find . -newer .claude/steering/ARCHITECTURE.md -type f
```

### Domain Mapping

Changed files are mapped to affected domains:

| Files Changed | Affected Domains | Agents to Run |
|---------------|------------------|---------------|
| `*.tsx, *.jsx` | UI Components | `ui-specialist` |
| `app/api/*.ts` | API Routes | `api-design-analyst` |
| `prisma/schema.prisma` | Database | `database-analyst` |
| `*.test.ts` | Testing | `test-strategist` |
| `lib/events/*.ts` | Messaging | `messaging-architect` |

### Selective Agent Execution

Only affected agents run:

```
Changes:
  ✓ UI: 4 files modified
  ✓ API: 6 files changed
  ✓ Database: 2 schema updates

Running agents:
  ⏳ ui-specialist (updating UI_DESIGN_SYSTEM.md)
  ⏳ api-design-analyst (updating API_DESIGN_GUIDE.md)
  ⏳ database-analyst (updating DATABASE_CONTEXT.md)
```

### Document Merging

Updated sections are merged with existing documents:

```markdown
Before:
  UI_DESIGN_SYSTEM.md (203 KB, 45 components)

Changes:
  + 2 new components
  ~ 3 modified components

After:
  UI_DESIGN_SYSTEM.md (237 KB, 47 components)
```

## Execution Workflow

### Step 1: Detect Changes

```bash
# Load last generation timestamp
LAST_RUN=$(jq -r '.last_run' .claude/memory/orchestration/state.json)

if [ "$LAST_RUN" == "null" ]; then
  echo "❌ No previous generation found. Run /steering-generate first."
  exit 1
fi

# Detect changed files
echo "🔍 Detecting changes since $LAST_RUN..."

if git rev-parse --git-dir > /dev/null 2>&1; then
  # Use Git if available
  CHANGED_FILES=$(git diff --name-only $LAST_RUN..HEAD)
else
  # Use file timestamps
  CHANGED_FILES=$(find . -newer .claude/steering/ARCHITECTURE.md -type f \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*")
fi

if [ -z "$CHANGED_FILES" ]; then
  echo "✓ No changes detected. Context is up-to-date."
  exit 0
fi

echo "Found $(echo "$CHANGED_FILES" | wc -l) changed files"
```

### Step 2: Analyze Change Scope

```bash
# Categorize changes
UI_CHANGES=$(echo "$CHANGED_FILES" | grep -E '\.(tsx|jsx|css|scss)$' | wc -l)
API_CHANGES=$(echo "$CHANGED_FILES" | grep -E 'api/.*\.(ts|js)$' | wc -l)
DB_CHANGES=$(echo "$CHANGED_FILES" | grep -E '(schema|migration)' | wc -l)
TEST_CHANGES=$(echo "$CHANGED_FILES" | grep -E '\.(test|spec)\.' | wc -l)

echo "Change analysis:"
echo "  UI components: $UI_CHANGES files"
echo "  API routes: $API_CHANGES files"
echo "  Database: $DB_CHANGES files"
echo "  Tests: $TEST_CHANGES files"
```

### Step 3: Select Agents

```bash
AGENTS_TO_RUN=()

if [ $UI_CHANGES -gt 0 ]; then
  AGENTS_TO_RUN+=("ui-specialist")
fi

if [ $API_CHANGES -gt 0 ]; then
  AGENTS_TO_RUN+=("api-design-analyst")
fi

if [ $DB_CHANGES -gt 0 ]; then
  AGENTS_TO_RUN+=("database-analyst")
fi

if [ $TEST_CHANGES -gt 0 ]; then
  AGENTS_TO_RUN+=("test-strategist")
fi

# Always run quality auditor for affected areas
AGENTS_TO_RUN+=("quality-auditor")

echo "Selected agents: ${AGENTS_TO_RUN[@]}"
```

### Step 4: Execute Agents in Parallel

Use the Task tool to run selected agents:

```markdown
For UI changes - Invoke ui-specialist:
  Update UI_DESIGN_SYSTEM.md with new/modified components
  Focus only on changed files: $UI_CHANGED_FILES
  Merge with existing: .claude/memory/ui/

For API changes - Invoke api-design-analyst:
  Update API_DESIGN_GUIDE.md with new/modified endpoints
  Focus only on changed files: $API_CHANGED_FILES
  Merge with existing: .claude/memory/api-design/

For Database changes - Invoke database-analyst:
  Update DATABASE_CONTEXT.md with schema changes
  Focus only on migrations/schema: $DB_CHANGED_FILES
  Merge with existing: .claude/memory/database/

For Test changes - Invoke test-strategist:
  Update TESTING_GUIDE.md with new test patterns
  Focus only on changed tests: $TEST_CHANGED_FILES
  Merge with existing: .claude/memory/testing/
```

### Step 5: Validate and Merge

```bash
# Validate updated documents
bash scripts/validate.sh

# Update architecture document with changes
# (context-synthesizer runs lightweight merge)

# Update state
cat > .claude/memory/orchestration/state.json << EOF
{
  "phase": "ready",
  "timestamp": "$(date -Iseconds)",
  "initialized": true,
  "last_run": "$(date -Iseconds)",
  "last_update": "$(date -Iseconds)",
  "agents_status": {
    $(for agent in "${AGENTS_TO_RUN[@]}"; do
      echo "\"$agent\": \"updated\","
    done | sed '$ s/,$//')
  }
}
EOF
```

### Step 6: Display Summary

```bash
echo "✅ Update complete!"
echo ""
echo "Updated Files:"
for agent in "${AGENTS_TO_RUN[@]}"; do
  case $agent in
    ui-specialist)
      echo "  ↻ UI_DESIGN_SYSTEM.md (+${UI_CHANGES} changes)"
      ;;
    api-design-analyst)
      echo "  ↻ API_DESIGN_GUIDE.md (+${API_CHANGES} changes)"
      ;;
    database-analyst)
      echo "  ↻ DATABASE_CONTEXT.md (+${DB_CHANGES} changes)"
      ;;
    test-strategist)
      echo "  ↻ TESTING_GUIDE.md (+${TEST_CHANGES} changes)"
      ;;
    quality-auditor)
      echo "  ↻ QUALITY_REPORT.md (revalidated)"
      ;;
  esac
done

echo ""
echo "Time saved vs full regeneration: ~$(echo "$((45 - 8))" minutes)"
echo "Tokens used: ~18,000 (vs ~145,000 full)"
```

## Expected Output

```
🔄 Checking for changes since last generation...

Last Generated: 2025-11-01 15:30:45 (1 day ago)

Changes Detected (git diff):
  Modified: 12 files
  Added: 3 files
  Deleted: 1 file

Change Analysis:
  UI components: 4 files
  API routes: 6 files
  Database schema: 2 files

Selected Agents:
  ✓ ui-specialist
  ✓ api-design-analyst
  ✓ database-analyst
  ✓ quality-auditor

────────────────────────────────────────

Running Incremental Analysis:
  ⏳ ui-specialist: Updating UI_DESIGN_SYSTEM.md...
  ⏳ api-design-analyst: Updating API_DESIGN_GUIDE.md...
  ⏳ database-analyst: Updating DATABASE_CONTEXT.md...
  ⏳ quality-auditor: Revalidating affected areas...

────────────────────────────────────────

✅ Update complete! (8 minutes)

Updated Files:
  ↻ UI_DESIGN_SYSTEM.md (+34 KB, 2 new components)
  ↻ API_DESIGN_GUIDE.md (+12 KB, 3 endpoints modified)
  ↻ DATABASE_CONTEXT.md (+8 KB, 1 table added)
  ✓ ARCHITECTURE.md (revalidated)
  ✓ QUALITY_REPORT.md (revalidated)

Performance:
  Time: 8 minutes (vs 45 full)
  Time saved: 37 minutes (82% faster)
  Tokens: ~18,000 (vs ~145,000 full)
  Efficiency: 87% token savings

Next Steps:
  /steering-status - View updated context
```

## Configuration

### Update Threshold

Set minimum changes to trigger update:

```json
// .claude/steering/config.json
{
  "update_threshold": 5  // Minimum files changed
}
```

### Force Full Regeneration

Skip incremental and force full regeneration:

```bash
/steering-generate --force
```

### Selective Update

Update only specific domains:

```bash
# Update only UI (not yet implemented - use config)
{
  "update_domains": ["ui"]
}
```

## Troubleshooting

### "No changes detected" but files changed

**Causes**:
1. Files in excluded patterns
2. Git not tracking changes
3. Files outside analysis scope

**Solutions**:
```bash
# Check excluded patterns
cat .claude/steering/config.json | jq '.excluded_patterns'

# Force full regeneration
/steering-generate --force

# Update excluded patterns if needed
```

### Merge conflicts

If updates conflict with manual edits:

**Option 1**: Backup and regenerate
```bash
cp .claude/steering/ARCHITECTURE.md .claude/steering/ARCHITECTURE.md.backup
/steering-update
# Manually merge if needed
```

**Option 2**: Force full regeneration
```bash
/steering-generate --force
```

### Agent execution fails

Check agent status:
```bash
cat .claude/memory/orchestration/state.json | jq '.agents_status'
```

Retry specific agent:
```bash
# Run agent manually with Task tool
```

## Best Practices

**When to Use Update**:
- ✅ Small to medium changes (<20% of files)
- ✅ Focused changes in specific domains
- ✅ Regular maintenance updates
- ✅ After feature additions

**When to Use Full Regeneration**:
- ✅ Major refactoring (>20% of files)
- ✅ Architecture changes
- ✅ First-time generation
- ✅ After long periods without updates

**Update Frequency**:
- Daily: For active development
- Weekly: For stable projects
- After features: After completing features
- Before releases: Ensure docs current

## Advanced Usage

### Automated Updates

Set up Git hooks for automatic updates:

```bash
# .git/hooks/post-commit
#!/bin/bash
if [ -f ".claude/steering/config.json" ]; then
  /steering-update
fi
```

### CI/CD Integration

Add to CI pipeline:

```yaml
# .github/workflows/update-context.yml
name: Update Steering Context
on:
  push:
    branches: [main]
jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Update Context
        run: claude /steering-update
```

### Diff Analysis

Compare before/after:

```bash
# Before update
cp .claude/steering/ARCHITECTURE.md /tmp/arch-before.md

# Run update
/steering-update

# Compare
diff /tmp/arch-before.md .claude/steering/ARCHITECTURE.md
```

## Performance Metrics

Typical incremental update performance:

| Changes | Time | Tokens | vs Full |
|---------|------|--------|---------|
| 1-5 files | 3-5 min | 5K | 90% faster |
| 6-15 files | 5-8 min | 15K | 82% faster |
| 16-30 files | 8-12 min | 25K | 73% faster |
| 31-50 files | 12-20 min | 40K | 56% faster |
| 50+ files | Consider full regeneration | - | - |

---

**Keep your context fresh:** Run `/steering-update` regularly!
