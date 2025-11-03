#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

echo "🚀 Initializing Steering Context Generator..."

# Check if already initialized (improved idempotency)
if [ -f ".claude/steering/config.json" ] && \
   [ -f ".claude/memory/orchestration/state.json" ] && \
   [ -f ".claude/memory/orchestration/agents.json" ]; then
    echo "✓ System already initialized. Checking state..."
    if grep -q '"initialized": true' .claude/steering/config.json 2>/dev/null; then
        echo "✓ System is ready"
        echo ""
        echo "To reinitialize, run: rm -rf .claude && /steering-setup"
        exit 0
    fi
fi

# Create directory structure
echo "Creating directory structure..."
mkdir -p .claude/steering/{v2.0/{source,index,cache},logs,archives}
mkdir -p .claude/memory/{structure,domain,patterns,quality,synthesis,orchestration}
mkdir -p .claude/memory/{integrations,ui,testing,database,messaging,api-design,archives}
mkdir -p .claude/logs/{sessions,agents,metrics,errors,archives}

# Verify directories were created
if [ ! -d ".claude/steering" ] || [ ! -d ".claude/memory" ] || [ ! -d ".claude/logs" ]; then
    echo "❌ Error: Failed to create directory structure"
    exit 1
fi

# Create default configuration
cat > .claude/steering/config.json << EOF
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

# Initialize orchestration state
cat > .claude/memory/orchestration/state.json << EOF
{
  "phase": "ready",
  "timestamp": "$(date -Iseconds)",
  "initialized": true,
  "last_run": null,
  "agents_status": {}
}
EOF

# Create agent registry
cat > .claude/memory/orchestration/agents.json << EOF
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

# Verify JSON files were created successfully
if [ ! -f ".claude/steering/config.json" ] || \
   [ ! -f ".claude/memory/orchestration/state.json" ] || \
   [ ! -f ".claude/memory/orchestration/agents.json" ]; then
    echo "❌ Error: Failed to create configuration files"
    exit 1
fi

echo "✓ Directory structure created"
echo "✓ Configuration initialized"
echo "✓ Orchestration state ready"
echo ""
echo "✅ Steering Context Generator initialized successfully!"
echo ""
echo "Next steps:"
echo "  1. Run: /steering-generate"
echo "  2. Check status: /steering-status"
echo "  3. View docs: .claude/steering/*.md"
