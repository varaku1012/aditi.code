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
| `STRIPE_PAYMENT_CONTEXT.md` | Stripe integration found | Payment flows, webhook handlers, PCI compliance |
| `AUTH0_OAUTH_CONTEXT.md` | Auth0 integration found | OAuth flows, configuration, security assessment |
| `PAYLOAD_CMS_CONTEXT.md` | Payload CMS detected | CMS architecture, content models, API configuration |
| `PAYLOAD_CMS_CONFIG.md` | Payload CMS detected | Configuration analysis, security audit, compliance |

## How It Works

### Phase 1: Project Detection

The system automatically detects:

**Tech Stack**:
- Package managers (npm, pnpm, pip, cargo, go, maven, gradle)
- Frameworks (Next.js, React, Django, FastAPI, etc.)
- Databases (Prisma, Drizzle, TypeORM, MongoDB, etc.)
- Testing frameworks (Jest, Vitest, pytest, etc.)
- **Auth0 OAuth integration** (if @auth0 SDK detected)
- **Payload CMS integration** (if @payloadcms packages detected)

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
- **`auth0-detector`**: If Auth0 SDK imports or configuration found
- **`oauth-security-auditor`**: If Auth0 integration found (runs after auth0-detector)
- **`payload-cms-detector`**: If Payload CMS packages detected
- **`payload-cms-config-analyzer`**: If Payload CMS detected (runs after payload-cms-detector)

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
  messaging-architect ────┐
  api-design-analyst ─────┤
  stripe-payment-expert ──├ Run in parallel
  auth0-detector ─────────┤
  payload-cms-detector ───┤
  quality-auditor ────────┘

Group 3B (Security Audits) - Depends on Group 3:
  oauth-security-auditor (sequential, after auth0-detector, if Auth0 detected)
  payload-cms-config-analyzer (sequential, after payload-cms-detector, if Payload CMS detected)

Group 4 (Synthesis) - Depends on all:
  context-synthesizer (sequential)
```

**Time Savings**: Parallel execution is 55% faster than sequential!
**Note**: Auth0 security audit runs automatically after Auth0 detection, adding ~10 minutes if Auth0 is present.
**Note**: Payload CMS config analysis runs automatically after CMS detection, adding ~10 minutes if Payload CMS is present.

### Phase 4: Output Generation

Each agent contributes to final documents:

```
structure-analyst           →  ARCHITECTURE.md (structure section)
domain-expert               →  DOMAIN_CONTEXT.md (complete)
pattern-detective           →  ARCHITECTURE.md (patterns section)
ui-specialist               →  UI_DESIGN_SYSTEM.md (complete)
test-strategist             →  TESTING_GUIDE.md (complete)
database-analyst            →  DATABASE_CONTEXT.md (complete)
messaging-architect         →  MESSAGING_GUIDE.md (complete)
api-design-analyst          →  API_DESIGN_GUIDE.md (complete)
stripe-payment-expert       →  STRIPE_PAYMENT_CONTEXT.md (complete, if Stripe found)
auth0-detector              →  AUTH0_OAUTH_CONTEXT.md (complete, if Auth0 found)
oauth-security-auditor      →  AUTH0_SECURITY_AUDIT.md (complete, if Auth0 found)
payload-cms-detector        →  PAYLOAD_CMS_CONTEXT.md (complete, if Payload CMS found)
payload-cms-config-analyzer →  PAYLOAD_CMS_CONFIG.md (complete, if Payload CMS found)
quality-auditor             →  QUALITY_REPORT.md (complete)
context-synthesizer         →  AI_CONTEXT.md, CODEBASE_GUIDE.md
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
  ✓ CMS: Payload CMS v2.x detected

Assessing complexity...
  Files: 387
  Directories: 45 (max depth: 6)
  Dependencies: 73
  Estimated LOC: ~25,000

  Complexity: Moderate
  Estimated Time: 55 minutes (includes Payload CMS analysis)
  Workflow: Standard (3 parallel phases + security audits)
```

### Step 3: Execute Foundation Agents (Group 1)

Use the Task tool to run agents in parallel:

**Critical**: Execute ALL agents in Group 1 in a SINGLE message with multiple Task tool calls.

### Step 4: Execute Analysis Agents (Group 2)

**Depends on**: Group 1 outputs

### Step 5: Execute Architecture Agents (Group 3)

**Depends on**: Groups 1 & 2 outputs

### Step 5B: Execute Security Audits (Group 3B, Sequential)

**Depends on**: Group 3 outputs

Automatically executes after:
- Auth0 detection (if Auth0 found)
- Payload CMS detection (if Payload CMS found)

### Step 6: Final Synthesis (Group 4)

**Depends on**: All previous outputs

### Step 7: Validation and Completion

```bash
# Validate generated files
bash scripts/validate.sh

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
  "parallel_execution": false
}
```

## Expected Output

After successful completion:

```
✅ Steering context generation complete! (55 minutes)

Generated Files (.claude/steering/):
  ✓ ARCHITECTURE.md (342 KB) - System architecture
  ✓ AI_CONTEXT.md (156 KB) - AI agent bootstrap
  ✓ CODEBASE_GUIDE.md (278 KB) - Developer guide
  ✓ DOMAIN_CONTEXT.md (189 KB) - Business logic
  ✓ QUALITY_REPORT.md (134 KB) - Quality analysis
  ✓ PAYLOAD_CMS_CONTEXT.md (203 KB) - CMS architecture
  ✓ PAYLOAD_CMS_CONFIG.md (187 KB) - CMS configuration

Total: 2.1 MB of context documentation

Performance:
  Total tokens: ~165,000
  Agents executed: 16
  Parallel efficiency: 52% time saved

Next Steps:
  1. Review: /steering-status
  2. Load context: Reference .claude/steering/*.md in prompts
  3. Update later: /steering-update (incremental)
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

## Advanced Usage

### Selective Analysis

Analyze only specific areas:

```json
{
  "focus_areas": ["cms", "api"],
  "agents": ["payload-cms-detector", "api-design-analyst"]
}
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
