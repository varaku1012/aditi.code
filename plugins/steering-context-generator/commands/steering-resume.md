---
description: Resume an interrupted generation from the last checkpoint
---

# Steering Context Generator - Resume

Continue a generation that was interrupted or failed.

## Quick Start

```bash
/steering-resume
```

## When to Use

- ⚠ Generation was interrupted (Ctrl+C, timeout, crash)
- ⚠ Agent execution failed mid-way
- ⚠ System resources exhausted
- ⚠ Network connectivity issues

## How It Works

### Checkpoint System

The system automatically saves checkpoints:

```
.claude/memory/orchestration/
├── current_session.json    # Current execution state
├── checkpoint_group1.json  # After Group 1 completes
├── checkpoint_group2.json  # After Group 2 completes
└── checkpoint_group3.json  # After Group 3 completes
```

### Resume Logic

```bash
# Check for checkpoint
if [ -f ".claude/memory/orchestration/current_session.json" ]; then
  PHASE=$(jq -r '.phase' .claude/memory/orchestration/current_session.json)
  STATUS=$(jq -r '.status' .claude/memory/orchestration/current_session.json)

  if [ "$STATUS" == "running" ] || [ "$STATUS" == "failed" ]; then
    echo "Found interrupted session at phase: $PHASE"
    echo "Resuming from checkpoint..."

    # Resume from last completed phase
    case $PHASE in
      "group1")
        # Restart Group 1 or skip if completed
        ;;
      "group2")
        # Skip Group 1, resume Group 2
        ;;
      "group3")
        # Skip Groups 1 & 2, resume Group 3
        ;;
      "synthesis")
        # Run final synthesis only
        ;;
    esac
  fi
fi
```

## Expected Output

```
🔄 Checking for interrupted session...

Found Session: gen_20251102_120000
  Status: interrupted
  Phase: group2 (60% complete)
  Last Activity: 2025-11-02 12:45:00

Agents Completed:
  ✓ structure-analyst (Group 1)
  ✓ integration-mapper (Group 1)
  ✓ ui-specialist (Group 1)
  ✓ domain-expert (Group 2)
  ⏳ pattern-detective (Group 2) - INTERRUPTED

Resuming from Group 2...

────────────────────────────────────────

Phase 2/3: Deep Analysis (Resumed)
  ✓ domain-expert: Already complete
  ⏳ pattern-detective: Resuming analysis...
  ⏳ test-strategist: Starting fresh...
  ⏳ database-analyst: Starting fresh...

[Continue with normal execution...]
```

## Manual Resume

If automatic resume fails:

```bash
# Check what's completed
ls .claude/memory/*/

# Manually continue with remaining agents
# Use Task tool to invoke specific agents that didn't complete
```

## Clearing Failed State

To start fresh (discard interrupted session):

```bash
# Remove checkpoint
rm .claude/memory/orchestration/current_session.json

# Run full generation
/steering-generate
```

## Troubleshooting

### "No checkpoint found"
The session completed or never started. Run `/steering-generate`.

### Resume keeps failing
Clear state and start fresh:
```bash
rm .claude/memory/orchestration/*.json
/steering-setup
/steering-generate
```

---

**Recover from interruptions:** Run `/steering-resume`
