---
description: Initialize the Steering Context Generator system. Run this ONCE to set up agents, memory structure, and configuration.
---

# Steering Context Generator - Setup

Initialize the complete system for codebase analysis and steering context generation.

## What This Does

This command sets up:
- 📁 Directory structure for memory and outputs
- 🤖 12 specialized analysis agents
- ⚙️ Configuration with sensible defaults
- 📊 Orchestration state management
- ✅ Validation checks

## Quick Start

Simply run the initialization script:

```bash
bash scripts/init.sh
```

Or follow the manual steps below for more control.

## Manual Setup Steps

### Step 1: Verify Environment

Check that you have the required tools:

```bash
# Check Claude Code version
claude --version

# Check bash availability
bash --version

# Check jq (optional but recommended)
jq --version
```

**Requirements**:
- Claude Code CLI (any recent version)
- Bash shell
- At least 100MB disk space

### Step 2: Check Existing Installation

See if you've already initialized:

```bash
ls -la .claude/steering/
```

If you see `config.json` and directories, the system may already be set up.

Run validation:

```bash
bash scripts/validate.sh
```

If validation passes, skip to **Usage** section.

### Step 3: Create Directory Structure

```bash
# Core directories
mkdir -p .claude/steering/{v2.0/{source,index,cache},logs,archives}

# Memory directories for each agent
mkdir -p .claude/memory/{structure,domain,patterns,quality,synthesis,orchestration}
mkdir -p .claude/memory/{integrations,ui,testing,database,messaging,api-design,archives}

# Logging directories
mkdir -p .claude/logs/{sessions,agents,metrics,errors,archives}
```

### Step 4: Initialize Configuration

```bash
cat > .claude/steering/config.json << 'EOF'
{
  "version": "1.0.0",
  "initialized": true,
  "created": "$(date -Iseconds)",
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
EOF
```

### Step 5: Initialize Orchestration State

```bash
cat > .claude/memory/orchestration/state.json << 'EOF'
{
  "phase": "ready",
  "timestamp": "$(date -Iseconds)",
  "initialized": true,
  "last_run": null,
  "agents_status": {}
}
EOF
```

### Step 6: Create Agent Registry

```bash
cat > .claude/memory/orchestration/agents.json << 'EOF'
{
  "version": "1.0.0",
  "agents": [
    "structure-analyst",
    "domain-expert",
    "pattern-detective",
    "quality-auditor",
    "context-synthesizer",
    "memory-coordinator",
    "integration-mapper",
    "ui-specialist",
    "test-strategist",
    "database-analyst",
    "messaging-architect",
    "api-design-analyst"
  ],
  "last_updated": "$(date -Iseconds)"
}
EOF
```

### Step 7: Verify Setup

Run validation to ensure everything is correct:

```bash
bash scripts/validate.sh
```

**Expected Output**:
```
🔍 Validating Steering Context Generator installation...

Checking directory structure...
  ✓ .claude/steering
  ✓ .claude/memory/structure
  ✓ .claude/memory/domain
  [... more checks ...]

✅ Validation passed! System is healthy.
```

## Verification Checklist

After setup, verify:

- [ ] Directory structure exists (`.claude/steering/`, `.claude/memory/`)
- [ ] Configuration file valid (`.claude/steering/config.json`)
- [ ] Orchestration state initialized (`.claude/memory/orchestration/state.json`)
- [ ] Agent registry created (`.claude/memory/orchestration/agents.json`)
- [ ] Validation script passes (`bash scripts/validate.sh`)

## Configuration Options

The default `config.json` includes sensible defaults, but you can customize:

### Excluded Patterns

Add patterns to skip during analysis:

```json
"excluded_patterns": [
  "node_modules/**",
  ".git/**",
  "vendor/**",
  "*.min.js",
  "coverage/**"
]
```

### Focus Areas

Prioritize specific analysis areas:

```json
"focus_areas": [
  "architecture",
  "security",
  "performance",
  "testing",
  "documentation"
]
```

### Parallel Execution

Enable/disable parallel agent execution:

```json
"parallel_execution": true  // 55% faster, but uses more resources
```

### Output Format

Choose output format (currently markdown only):

```json
"output_format": "markdown"
```

## Next Steps

After successful setup:

1. **Generate Context**: Run `/steering-generate` to analyze your codebase
2. **Check Status**: Run `/steering-status` to see system status
3. **View Configuration**: Edit `.claude/steering/config.json` if needed

## Troubleshooting

### "Directory already exists" errors

The system is already initialized. Run validation:

```bash
bash scripts/validate.sh
```

If errors found, remove and reinitialize:

```bash
rm -rf .claude/steering .claude/memory
bash scripts/init.sh
```

### "Permission denied" errors

Make scripts executable:

```bash
chmod +x scripts/*.sh
```

### "jq: command not found"

jq is optional. The system will work without it, but validation checks will be limited.

Install jq:
- **macOS**: `brew install jq`
- **Ubuntu/Debian**: `sudo apt-get install jq`
- **Windows**: Download from https://stedolan.github.io/jq/

### Agents not appearing

The agents are part of the plugin installation. They should be automatically available at:
- Plugin agents directory (part of installation)

If issues persist, reinstall the plugin:

```bash
/plugin uninstall steering-context-generator@aditi.code
/plugin install steering-context-generator@aditi.code
```

## Advanced Setup

### Custom Memory Location

To use a different memory location:

```bash
export STEERING_MEMORY_PATH="/custom/path/.claude/memory"
mkdir -p $STEERING_MEMORY_PATH
```

Then update paths in configuration.

### Multi-Project Setup

For analyzing multiple projects from a central location:

```bash
# Create project-specific configs
mkdir -p ~/steering-projects/{project-a,project-b}

# Link to projects
ln -s /path/to/project-a ~/steering-projects/project-a/source
ln -s /path/to/project-b ~/steering-projects/project-b/source
```

## System Requirements

### Minimum
- Disk space: 100MB
- Memory: Available Claude context window
- Platform: macOS, Linux, Windows/WSL

### Recommended
- Disk space: 1GB (for large codebases)
- Memory: Sonnet model context window (200K tokens)
- Tools: bash, jq, git

## What Gets Created

```
.claude/
├── steering/
│   ├── config.json                 # System configuration
│   ├── v2.0/                       # Version 2.0 structure
│   │   ├── source/                 # Source documents
│   │   ├── index/                  # Search index
│   │   └── cache/                  # Query cache
│   ├── logs/                       # Execution logs
│   └── archives/                   # Historical runs
│
└── memory/                          # Agent memory
    ├── structure/                  # Structure analyst
    ├── domain/                     # Domain expert
    ├── patterns/                   # Pattern detective
    ├── quality/                    # Quality auditor
    ├── synthesis/                  # Context synthesizer
    ├── orchestration/              # Memory coordinator
    ├── integrations/               # Integration mapper
    ├── ui/                         # UI specialist
    ├── testing/                    # Test strategist
    ├── database/                   # Database analyst
    ├── messaging/                  # Messaging architect
    ├── api-design/                 # API design analyst
    └── archives/                   # Historical data
```

## Success Indicators

✅ **Setup Complete When**:
- All directories exist
- Configuration valid
- Validation passes
- No error messages

You're now ready to generate steering context with `/steering-generate`!

## Additional Resources

- **Plugin README**: Full documentation
- **Generation Guide**: `/steering-generate` command
- **Status Check**: `/steering-status` command
- **Cleanup**: `/steering-clean` command

---

**Setup Complete?** Run `/steering-generate` to start analyzing your codebase!
