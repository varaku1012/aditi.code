---
description: Generate comprehensive steering context documentation by analyzing your codebase with specialized AI agents
---

# Steering Context Generator - Full Generation

Analyze your entire codebase and generate comprehensive AI-readable documentation.

## Quick Start

```bash
/steering-generate
```

That's it! The system will:
1. 🔍 Detect your project type and tech stack
2. 📊 Assess complexity and select workflow
3. 🤖 Execute specialized agents in parallel
4. 📝 Generate comprehensive documentation
5. ✅ Validate and save outputs

## What Gets Generated

The following documents are created in `.claude/steering/`:

### Core Documents (Always Generated)

| Document | Purpose | Typical Size |
|----------|---------|--------------|
| `ARCHITECTURE.md` | System architecture, components, data flow | 200-400 KB |
| `AI_CONTEXT.md` | Bootstrap context for AI agents | 100-200 KB |
| `CODEBASE_GUIDE.md` | Developer onboarding guide | 150-300 KB |

### Extended Documents (Based on Project Type)

| Document | Generated When | Purpose |
|----------|----------------|---------|
| `DOMAIN_CONTEXT.md` | Complex projects | Business logic and rules |
| `QUALITY_REPORT.md` | Always | Security, performance analysis |
| `UI_DESIGN_SYSTEM.md` | Frontend detected | Component catalog, design tokens |
| `TESTING_GUIDE.md` | Tests found | Testing patterns, coverage |
| `DATABASE_CONTEXT.md` | Database detected | Schema, DAL patterns |
| `MESSAGING_GUIDE.md` | Queues/events found | Event catalog, pub/sub |
| `API_DESIGN_GUIDE.md` | API endpoints found | REST standards, error handling |

## How It Works

### Phase 1: Project Detection

The system automatically detects:

**Tech Stack**:
- Package managers (npm, pnpm, pip, cargo, go, maven, gradle)
- Frameworks (Next.js, React, Django, FastAPI, etc.)
- Databases (Prisma, Drizzle, TypeORM, MongoDB, etc.)
- Testing frameworks (Jest, Vitest, pytest, etc.)

**Project Structure**:
- Monorepo vs single-package
- Microservices vs monolith
- Frontend, backend, or full-stack
- File count and directory depth

**Complexity Assessment**:
```
Simple:    < 50 files, < 3 levels deep    → 20 min
Moderate:  50-200 files, 3-6 levels deep  → 45 min
Complex:   200+ files, 6+ levels deep     → 85 min
```

### Phase 2: Agent Selection

Based on detection, the system selects appropriate agents:

**Foundation Agents** (Always Run):
- `structure-analyst`: Map file system and dependencies
- `pattern-detective`: Identify architectural patterns
- `quality-auditor`: Security and quality analysis

**Domain-Specific Agents** (Conditional):
- `ui-specialist`: If frontend components found
- `test-strategist`: If test files found
- `database-analyst`: If database schemas found
- `messaging-architect`: If queues/events found
- `api-design-analyst`: If API routes found

**Synthesis Agent** (Always Final):
- `context-synthesizer`: Generate final documentation

### Phase 3: Parallel Execution

Agents execute in intelligent parallel groups:

```mermaid
Group 1 (Foundation):
  structure-analyst ──┐
  integration-mapper ─┤ Run in parallel
  ui-specialist ──────┘

Group 2 (Analysis) - Depends on Group 1:
  domain-expert ──────┐
  pattern-detective ──┤ Run in parallel
  test-strategist ────┤
  database-analyst ───┘

Group 3 (Architecture) - Depends on Groups 1 & 2:
  messaging-architect ─┐
  api-design-analyst ──┤ Run in parallel
  quality-auditor ─────┘

Group 4 (Synthesis) - Depends on all:
  context-synthesizer (sequential)
```

**Time Savings**: Parallel execution is 55% faster than sequential!

### Phase 4: Output Generation

Each agent contributes to final documents:

```
structure-analyst    →  ARCHITECTURE.md (structure section)
domain-expert        →  DOMAIN_CONTEXT.md (complete)
pattern-detective    →  ARCHITECTURE.md (patterns section)
ui-specialist        →  UI_DESIGN_SYSTEM.md (complete)
test-strategist      →  TESTING_GUIDE.md (complete)
database-analyst     →  DATABASE_CONTEXT.md (complete)
messaging-architect  →  MESSAGING_GUIDE.md (complete)
api-design-analyst   →  API_DESIGN_GUIDE.md (complete)
quality-auditor      →  QUALITY_REPORT.md (complete)
context-synthesizer  →  AI_CONTEXT.md, CODEBASE_GUIDE.md
```

## Execution Workflow

The system uses the Task tool to invoke agents in parallel:

### Step 1: Initialize Session

```bash
# Create session ID for tracking
SESSION_ID="gen_$(date +%Y%m%d_%H%M%S)"

# Initialize execution state
cat > .claude/memory/orchestration/current_session.json << EOF
{
  "session_id": "$SESSION_ID",
  "started": "$(date -Iseconds)",
  "status": "running",
  "phase": "detection"
}
EOF
```

### Step 2: Detect and Assess

Analyze project characteristics:

```markdown
Detecting project type...
  ✓ Tech Stack: Node.js/TypeScript
  ✓ Framework: Next.js 14 (App Router)
  ✓ Package Manager: pnpm (monorepo detected)
  ✓ Database: Prisma + PostgreSQL
  ✓ Testing: Vitest + Playwright

Assessing complexity...
  Files: 387
  Directories: 45 (max depth: 6)
  Dependencies: 73
  Estimated LOC: ~25,000

  Complexity: Moderate
  Estimated Time: 45 minutes
  Workflow: Standard (3 parallel phases)
```

### Step 3: Execute Foundation Agents (Group 1)

Use the Task tool to run agents in parallel:

**Critical**: Execute ALL agents in Group 1 in a SINGLE message with multiple Task tool calls.

```markdown
Invoke three Task tools simultaneously:

Task 1 - structure-analyst:
  Analyze file system, create STRUCTURE_MAP.md
  Store in: .claude/memory/structure/

Task 2 - integration-mapper:
  Map external integrations, create INTEGRATION_MAP.md
  Store in: .claude/memory/integrations/

Task 3 - ui-specialist (if frontend):
  Extract UI components, create UI_DESIGN_SYSTEM.md
  Store in: .claude/memory/ui/
```

Wait for all three to complete before proceeding.

### Step 4: Execute Analysis Agents (Group 2)

**Depends on**: Group 1 outputs (STRUCTURE_MAP.md)

```markdown
Invoke four Task tools simultaneously:

Task 1 - domain-expert:
  Extract business logic using STRUCTURE_MAP.md
  Create DOMAIN_MODEL.md
  Store in: .claude/memory/domain/

Task 2 - pattern-detective:
  Identify patterns using STRUCTURE_MAP.md
  Create PATTERNS_CATALOG.md
  Store in: .claude/memory/patterns/

Task 3 - test-strategist (if tests found):
  Analyze test patterns
  Create TESTING_GUIDE.md
  Store in: .claude/memory/testing/

Task 4 - database-analyst (if database):
  Analyze schema and DAL
  Create DATABASE_CONTEXT.md
  Store in: .claude/memory/database/
```

### Step 5: Execute Architecture Agents (Group 3)

**Depends on**: Groups 1 & 2 outputs

```markdown
Invoke three Task tools simultaneously:

Task 1 - messaging-architect (if messaging):
  Analyze events and queues
  Create MESSAGING_GUIDE.md
  Store in: .claude/memory/messaging/

Task 2 - api-design-analyst (if APIs):
  Analyze API design
  Create API_DESIGN_GUIDE.md
  Store in: .claude/memory/api-design/

Task 3 - quality-auditor:
  Perform security and quality audit using all previous outputs
  Create QUALITY_REPORT.md
  Store in: .claude/memory/quality/
```

### Step 6: Final Synthesis (Group 4)

**Depends on**: All previous outputs

```markdown
Invoke single Task tool:

Task - context-synthesizer:
  Load ALL memory outputs from:
    - .claude/memory/structure/
    - .claude/memory/domain/
    - .claude/memory/patterns/
    - .claude/memory/integrations/
    - .claude/memory/ui/
    - .claude/memory/testing/
    - .claude/memory/database/
    - .claude/memory/messaging/
    - .claude/memory/api-design/
    - .claude/memory/quality/

  Generate final documents:
    - ARCHITECTURE.md (comprehensive system architecture)
    - AI_CONTEXT.md (optimized for AI agents)
    - CODEBASE_GUIDE.md (developer onboarding)

  Store in: .claude/steering/
```

### Step 7: Validation and Completion

```bash
# Validate generated files
bash scripts/validate.sh

# Update session state
cat > .claude/memory/orchestration/current_session.json << EOF
{
  "session_id": "$SESSION_ID",
  "started": "$(date -Iseconds)",
  "completed": "$(date -Iseconds)",
  "status": "complete",
  "outputs": [
    ".claude/steering/ARCHITECTURE.md",
    ".claude/steering/AI_CONTEXT.md",
    ".claude/steering/CODEBASE_GUIDE.md",
    ".claude/steering/DOMAIN_CONTEXT.md",
    ".claude/steering/QUALITY_REPORT.md",
    ".claude/steering/UI_DESIGN_SYSTEM.md",
    ".claude/steering/TESTING_GUIDE.md",
    ".claude/steering/DATABASE_CONTEXT.md",
    ".claude/steering/MESSAGING_GUIDE.md",
    ".claude/steering/API_DESIGN_GUIDE.md"
  ]
}
EOF

# Display summary
echo "✅ Steering context generation complete!"
echo ""
echo "Generated Files (.claude/steering/):"
ls -lh .claude/steering/*.md | awk '{print "  ✓", $9, "(" $5 ")"}'
echo ""
echo "Next Steps:"
echo "  1. Review: /steering-status"
echo "  2. Load context: Reference .claude/steering/*.md in prompts"
echo "  3. Update later: /steering-update (incremental)"
```

## Progress Monitoring

During execution, you'll see:

```
📊 Progress: [████████████░░░░░░░░] 60% - 27 minutes elapsed

Phase 2/3: Deep Analysis
  ✓ domain-expert: DOMAIN_MODEL.md (189 KB)
  ✓ pattern-detective: PATTERNS_CATALOG.md (98 KB)
  ⏳ test-strategist: Analyzing test patterns... (45% complete)
  ⏳ database-analyst: Extracting schemas... (60% complete)
```

## Configuration Options

### Focus Areas

Prioritize specific analysis areas in `.claude/steering/config.json`:

```json
{
  "focus_areas": ["architecture", "security", "performance"]
}
```

### Excluded Patterns

Skip certain files/directories:

```json
{
  "excluded_patterns": [
    "node_modules/**",
    ".git/**",
    "dist/**",
    "*.test.ts"
  ]
}
```

### Parallel Execution

Disable parallel execution if needed:

```json
{
  "parallel_execution": false  // Slower but uses less resources
}
```

## Expected Output

After successful completion:

```
✅ Steering context generation complete! (44 minutes)

Generated Files (.claude/steering/):
  ✓ ARCHITECTURE.md (342 KB) - System architecture
  ✓ AI_CONTEXT.md (156 KB) - AI agent bootstrap
  ✓ CODEBASE_GUIDE.md (278 KB) - Developer guide
  ✓ DOMAIN_CONTEXT.md (189 KB) - Business logic
  ✓ QUALITY_REPORT.md (134 KB) - Quality analysis
  ✓ UI_DESIGN_SYSTEM.md (203 KB) - Component library
  ✓ TESTING_GUIDE.md (167 KB) - Test patterns
  ✓ DATABASE_CONTEXT.md (145 KB) - Schema documentation
  ✓ MESSAGING_GUIDE.md (123 KB) - Event catalog
  ✓ API_DESIGN_GUIDE.md (156 KB) - API standards

Total: 1.9 MB of context documentation

Performance:
  Total tokens: ~145,000
  Agents executed: 10
  Parallel efficiency: 52% time saved

Next Steps:
  1. Review: /steering-status
  2. Load context: Reference .claude/steering/*.md in prompts
  3. Update later: /steering-update (incremental)
  4. Export: /steering-export --format json
```

## Troubleshooting

### Generation Interrupted

If generation is interrupted:

```bash
# Check for checkpoint
ls .claude/memory/orchestration/current_session.json

# Resume from checkpoint
/steering-resume
```

### Agents Not Found

Ensure plugin is properly installed:

```bash
/plugin list
# Should show "steering-context-generator"

# Reinstall if needed
/plugin uninstall steering-context-generator@aditi.code
/plugin install steering-context-generator@aditi.code
```

### Out of Memory

For very large codebases:

1. Disable parallel execution
2. Run selective analysis
3. Increase excluded patterns
4. Use incremental approach

### Poor Quality Output

Try:

1. Run with Opus model for better quality
2. Check excluded patterns aren't too broad
3. Ensure agents have proper tool access
4. Review generated memory files for completeness

## Advanced Usage

### Selective Analysis

Analyze only specific areas:

```json
// .claude/steering/config.json
{
  "focus_areas": ["security"],
  "agents": ["quality-auditor", "security-engineer"]
}
```

### Custom Templates

Provide custom output templates:

```bash
mkdir -p .claude/steering/templates/
# Add custom markdown templates
```

### Multi-Project Analysis

Analyze multiple projects:

```bash
# Project A
cd /path/to/project-a
/steering-generate

# Project B
cd /path/to/project-b
/steering-generate

# Compare
diff .claude/steering/ARCHITECTURE.md ../project-a/.claude/steering/ARCHITECTURE.md
```

## Performance Tips

**Faster Generation**:
- ✅ Use parallel execution (enabled by default)
- ✅ Exclude large generated directories
- ✅ Use Haiku model for simple projects
- ✅ Enable incremental updates

**Better Quality**:
- ✅ Use Sonnet model (default)
- ✅ Use Opus model for complex analysis
- ✅ Provide clear focus areas
- ✅ Review and refine outputs

## Success Metrics

Your generation is successful when:

- ✅ All expected files generated
- ✅ Files are valid markdown
- ✅ File sizes are reasonable (not empty, not too large)
- ✅ Validation passes
- ✅ Content is relevant and accurate

## Next Steps

After generation:

1. **Review Output**: `/steering-status`
2. **Load Context**: Reference `.claude/steering/*.md` in AI prompts
3. **Incremental Updates**: `/steering-update` when code changes
4. **Export**: `/steering-export` for different formats
5. **Clean Up**: `/steering-clean` to remove old archives

---

**Ready to generate?** Just run: `/steering-generate`

The system handles everything automatically!
