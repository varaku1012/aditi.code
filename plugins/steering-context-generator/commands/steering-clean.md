---
description: Clean up old archives, logs, and temporary files to free disk space
---

# Steering Context Generator - Clean

Remove old archives and temporary files to free up disk space.

## Quick Start

```bash
/steering-clean
```

This will:
- Archive current context (backup)
- Remove archives older than 7 days
- Clean logs older than 30 days
- Remove cache files
- Delete temporary files

## What Gets Cleaned

| Item | Location | Retention | Impact |
|------|----------|-----------|--------|
| Old archives | `.claude/memory/archives/` | 7 days | Can regenerate |
| Old logs | `.claude/logs/` | 30 days | Lost history |
| Cache files | `.claude/steering/v2.0/cache/` | All | Rebuilt on next use |
| Temp files | `.claude/memory/**/*.tmp` | All | Safe to delete |

## Implementation

```bash
bash scripts/cleanup.sh
```

## Expected Output

```
🧹 Cleaning Steering Context Generator artifacts...

Artifacts to clean:
  Archives: 450 MB
  Logs: 23 MB
  Cache: 12 MB

Continue? (y/N) y

Archiving current context to .claude/memory/archives/backup_20251102_120000...
  ✓ Archived 9 files

Cleaning old archives (>7 days)...
  ✓ Removed 3 old archives (380 MB freed)

Cleaning old logs (>30 days)...
  ✓ Removed 145 log files (18 MB freed)

Cleaning cache...
  ✓ Cleared cache (12 MB freed)

Cleaning temporary files...
  ✓ Removed 23 temp files (2 MB freed)

Cleanup complete!
Current usage:
  Archives: 70 MB
  Logs: 5 MB
  Total: 250 MB

Total freed: 412 MB
```

## Safety Features

**Automatic Backup**:
Before cleaning, current context is archived:
```
.claude/memory/archives/backup_YYYYMMDD_HHMMSS/
├── ARCHITECTURE.md
├── AI_CONTEXT.md
├── CODEBASE_GUIDE.md
└── ...
```

**Confirmation Prompt**:
Interactive mode asks for confirmation before deleting.

**Dry Run**:
See what would be cleaned without actually deleting:
```bash
bash scripts/cleanup.sh --dry-run
```

## Cleanup Options

### Aggressive Cleanup

Remove all archives (not recommended):
```bash
# Manual aggressive cleanup
rm -rf .claude/memory/archives/*
rm -rf .claude/logs/*
```

### Selective Cleanup

Clean specific areas only:

**Archives only**:
```bash
find .claude/memory/archives -type d -mtime +7 -exec rm -rf {} +
```

**Logs only**:
```bash
find .claude/logs -type f -mtime +30 -delete
```

**Cache only**:
```bash
rm -rf .claude/steering/v2.0/cache/*
```

### Custom Retention

Edit `scripts/cleanup.sh` to change retention periods:
```bash
# Archives: Change from 7 to 30 days
find .claude/memory/archives -type d -mtime +30 -exec rm -rf {} +

# Logs: Change from 30 to 90 days
find .claude/logs -type f -mtime +90 -delete
```

## When to Clean

**Regular Maintenance**:
- Weekly: For active projects
- Monthly: For stable projects
- Before: Major releases
- When: Low disk space warnings

**Signs You Need Cleaning**:
- ⚠ Archive size > 500 MB
- ⚠ Total .claude/ size > 2 GB
- ⚠ Disk space warnings
- ⚠ Slow operations

## Recovering Cleaned Data

**Recent Backup**:
```bash
# List available backups
ls -lh .claude/memory/archives/backup_*/

# Restore latest backup
LATEST=$(ls -t .claude/memory/archives/backup_* | head -1)
cp -r $LATEST/*.md .claude/steering/
```

**From Git**:
If context files are committed:
```bash
git log -- .claude/steering/
git checkout HEAD~1 -- .claude/steering/
```

**Regenerate**:
If no backups available:
```bash
/steering-generate
```

## Troubleshooting

### "Permission denied" errors
```bash
chmod +x scripts/cleanup.sh
```

### Cleanup doesn't free space
Check hidden or locked files:
```bash
lsof | grep .claude
```

### Accidentally deleted current context
```bash
# Restore from latest backup
LATEST=$(ls -t .claude/memory/archives/backup_* | head -1)
cp -r $LATEST/*.md .claude/steering/
```

---

**Free up space:** Run `/steering-clean` regularly!
