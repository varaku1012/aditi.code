#!/bin/bash

# Script to copy and adapt agents from tara-hub-reference

SOURCE_DIR="../../codebase-reference/claude_code/tara-hub-reference/agents"
TARGET_DIR="../agents"

AGENTS=(
  "structure-analyst.md"
  "domain-expert.md"
  "pattern-detective.md"
  "quality-auditor.md"
  "context-synthesizer.md"
  "memory-coordinator.md"
  "integration-mapper.md"
  "ui-specialist.md"
  "test-strategist.md"
  "database-analyst.md"
  "messaging-architect.md"
  "api-design-analyst.md"
)

echo "🤖 Copying and adapting agents..."
echo ""

for agent in "${AGENTS[@]}"; do
  if [ -f "$SOURCE_DIR/$agent" ]; then
    echo "  ✓ Copying $agent"
    # Copy agent
    cp "$SOURCE_DIR/$agent" "$TARGET_DIR/$agent"

    # Adapt paths (replace tara-hub specific paths with generic ones)
    # This is a placeholder - actual implementation would use sed to replace paths
    # sed -i 's/\.claude\/tara-hub/.claude/g' "$TARGET_DIR/$agent"
  else
    echo "  ✗ Missing $agent (will need manual creation)"
  fi
done

echo ""
echo "✅ Agent copying complete!"
echo ""
echo "Agents copied to: $TARGET_DIR"
echo ""
echo "Next steps:"
echo "  1. Review agents for any tara-hub-specific references"
echo "  2. Test agent invocation"
echo "  3. Proceed with marketplace integration"
