# Steering Context Generator

**Comprehensive codebase analysis and AI-ready documentation generation for Claude Code**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/varaku1012/aditi.code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Plugin-purple.svg)](https://claude.ai/code)

## Overview

The Steering Context Generator is a production-ready Claude Code plugin that automatically analyzes your codebase and generates comprehensive documentation optimized for AI-assisted development. It uses specialized AI agents to understand your project's architecture, patterns, dependencies, and design decisions—creating "steering context" that helps AI assistants work more effectively with your code.

### What is Steering Context?

Steering context is AI-readable documentation that provides:
- **Architecture overview** - System design, patterns, and component relationships
- **Domain knowledge** - Business logic, rules, and terminology
- **Quality insights** - Code health, technical debt, and improvement opportunities
- **Development guide** - Setup instructions, workflows, and best practices

This context enables AI assistants like Claude to provide more accurate suggestions, follow existing patterns, and make informed architectural decisions.

## Features

- **🤖 12 Specialized AI Agents** - Each focused on specific aspects (structure, patterns, quality, testing, etc.)
- **⚡ Parallel Execution** - 55% faster than sequential processing
- **🎯 Project-Agnostic** - Works with any tech stack (Next.js, React, Python, Go, Rust, etc.)
- **🔄 Incremental Updates** - Only re-analyzes changed code (80% time savings)
- **📊 Progress Monitoring** - Real-time status updates during generation
- **🎛️ Zero Configuration** - Automatic project type and complexity detection
- **💾 Memory System** - Persistent knowledge across analysis runs
- **📤 Multiple Export Formats** - Markdown, JSON, plain text (HTML/PDF coming soon)

## Quick Start

### Installation

Install from the Aditi Code marketplace:

```bash
# In Claude Code CLI
/plugin install https://github.com/varaku1012/aditi.code

# Verify installation
/steering-status
```

### First-Time Setup

Navigate to your project and run setup:

```bash
cd /path/to/your/project
/steering-setup
```

This creates the necessary directory structure and configuration:
```
.claude/
├── steering/          # Generated documentation
├── memory/            # Agent knowledge database
└── logs/              # Session and performance logs
```

### Generate Documentation

Run the main generation command:

```bash
/steering-generate
```

**What happens:**
1. **Detection Phase** - Auto-detects tech stack and complexity
2. **Agent Selection** - Chooses relevant agents for your project
3. **Parallel Analysis** - 12 agents analyze your codebase concurrently
4. **Synthesis** - Combines findings into comprehensive documents

**Expected output** (3-8 minutes depending on project size):
```
.claude/steering/
├── ARCHITECTURE.md      # System design and patterns
├── AI_CONTEXT.md        # AI assistant guidance
├── CODEBASE_GUIDE.md    # Developer onboarding
├── QUALITY_REPORT.md    # Code health analysis
└── PATTERNS.md          # Identified design patterns
```

### Incremental Updates

After making code changes, update selectively:

```bash
/steering-update
```

This only re-analyzes modified areas—much faster than full regeneration.

## Commands

### Core Workflow

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/steering-setup` | Initialize plugin in project | Once per project |
| `/steering-generate` | Full codebase analysis | First time, major changes |
| `/steering-update` | Incremental update | After code changes |
| `/steering-status` | View generation status | Check progress, history |

### Maintenance

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/steering-clean` | Archive old files | Disk space management |
| `/steering-config` | View/edit configuration | Customize behavior |
| `/steering-resume` | Continue interrupted run | After timeout/crash |
| `/steering-export` | Export to other formats | Sharing, CI/CD integration |

## Usage Examples

### Example 1: New Project Analysis

```bash
# Clone a repository
git clone https://github.com/example/react-app.git
cd react-app

# Initialize and generate
/steering-setup
/steering-generate

# Review generated documentation
cat .claude/steering/ARCHITECTURE.md
```

### Example 2: Incremental Development

```bash
# Make code changes
vim src/components/UserProfile.tsx

# Update documentation
/steering-update

# Check what changed
/steering-status --history
```

### Example 3: Team Onboarding

```bash
# Generate comprehensive docs
/steering-generate

# Export for sharing
/steering-export --format json

# Compress for distribution
tar -czf onboarding-docs.tar.gz .claude/steering/
```

### Example 4: CI/CD Integration

```bash
# In your CI pipeline
/steering-generate
/steering-export --format json

# Extract quality metrics
cat .claude/steering/export/context.json | jq '.quality.overall_score'

# Fail build if quality drops below threshold
```

## Configuration

Default configuration is in `.claude/steering/config.json`:

```json
{
  "version": "1.0.0",
  "excluded_patterns": [
    "node_modules/**",
    ".git/**",
    "dist/**",
    "build/**"
  ],
  "focus_areas": [
    "architecture",
    "security",
    "performance",
    "testing"
  ],
  "parallel_execution": true,
  "incremental_updates": true
}
```

### Common Customizations

**For Large Monorepos:**
```json
{
  "excluded_patterns": [
    "packages/*/node_modules/**",
    "apps/*/dist/**"
  ],
  "parallel_execution": true
}
```

**For Security-Focused Analysis:**
```json
{
  "focus_areas": ["security", "quality"],
  "deep_scan_enabled": true
}
```

**For Fast Iterations:**
```json
{
  "excluded_patterns": [
    "**/*.test.ts",
    "**/*.spec.ts"
  ]
}
```

## Agents

The plugin includes 12 specialized agents:

### Foundational Agents (Group 1)
- **structure-analyst** - Maps directory structure, entry points, dependencies
- **integration-mapper** - Traces API endpoints, service connections, data flows
- **ui-specialist** - Analyzes UI components, state management, routing

### Deep Analysis Agents (Group 2)
- **domain-expert** - Extracts business logic, rules, and terminology
- **pattern-detective** - Identifies design patterns and architectural styles
- **test-strategist** - Evaluates test coverage and quality
- **database-analyst** - Documents schema, queries, and migrations

### Quality & Synthesis Agents (Group 3)
- **quality-auditor** - Assesses code health, technical debt, vulnerabilities
- **messaging-architect** - Analyzes event systems, queues, and async patterns
- **api-design-analyst** - Reviews API design and contracts
- **context-synthesizer** - Combines all findings into coherent documentation
- **memory-coordinator** - Manages persistent knowledge and checkpoints

## Supported Tech Stacks

The plugin auto-detects and works with:

### JavaScript/TypeScript
- Next.js, React, Vue, Angular, Svelte
- Node.js, Express, NestJS, Fastify
- Jest, Vitest, Playwright

### Python
- Django, FastAPI, Flask
- SQLAlchemy, Django ORM
- pytest, unittest

### Other Languages
- Go (Gin, Echo, Fiber)
- Rust (Actix, Rocket)
- Java (Spring Boot)
- Ruby (Rails)

### Databases
- PostgreSQL, MySQL, SQLite
- MongoDB, Redis
- Prisma, Drizzle, TypeORM

## Performance

**Benchmark Results** (React app, 15K LOC):

| Operation | Time | Notes |
|-----------|------|-------|
| Full generation | 4m 30s | First-time analysis |
| Incremental update | 55s | After 200 LOC change |
| Parallel speedup | 55% | vs sequential execution |
| Memory usage | ~150MB | Peak during analysis |

**Scalability:**
- Small projects (<5K LOC): 2-3 minutes
- Medium projects (5-20K LOC): 4-6 minutes
- Large projects (20-50K LOC): 6-10 minutes
- Monorepos (50K+ LOC): 10-15 minutes

## Troubleshooting

### Issue: "Setup failed - permission denied"

**Solution:**
```bash
# Ensure scripts are executable
chmod +x plugins/steering-context-generator/scripts/*.sh

# Re-run setup
/steering-setup
```

### Issue: "Generation hangs at 60%"

**Cause:** Large codebase causing timeout

**Solution:**
```bash
# Increase timeout in config
echo '{"agent_timeout_minutes": 10}' >> .claude/steering/config.json

# Resume from checkpoint
/steering-resume
```

### Issue: "Agent not found"

**Cause:** Plugin not fully installed

**Solution:**
```bash
# Verify all agents present
ls plugins/steering-context-generator/agents/

# Should see 12 .md files
# If missing, reinstall plugin
```

### Issue: "Incremental update not detecting changes"

**Cause:** Not a git repository or unstaged changes

**Solution:**
```bash
# Initialize git if needed
git init
git add .
git commit -m "Initial commit"

# Now update will use git diff
/steering-update
```

## FAQ

### Q: How often should I regenerate documentation?

**A:** Use incremental updates (`/steering-update`) after each feature or significant change. Full regeneration (`/steering-generate`) is only needed for major refactors or new team members joining.

### Q: Can I use this with proprietary codebases?

**A:** Yes. All analysis happens locally. No code is sent externally unless you explicitly share generated documentation.

### Q: Does this work with monorepos?

**A:** Yes. The plugin handles monorepos well. Configure `excluded_patterns` to skip irrelevant packages.

### Q: What's the difference between this and code documentation generators?

**A:** Traditional tools generate API docs from code comments. This plugin analyzes architecture, patterns, and design decisions—creating context that helps AI understand *why* code is structured a certain way.

### Q: Can I customize which agents run?

**A:** Not yet in v1.0. Agent selection is automatic based on project type. Manual selection is planned for v1.1.

### Q: How does this compare to Claude's built-in codebase understanding?

**A:** Claude can read your code directly, but steering context provides pre-analyzed insights about architecture and patterns—like giving Claude a "map" before exploring terrain.

### Q: Is there a cost to using this plugin?

**A:** The plugin is free and open-source (MIT license). However, agent execution uses Claude API tokens, which may incur costs depending on your Anthropic plan.

## Contributing

Contributions are welcome! Areas where we'd love help:

- **New export formats** - HTML, PDF, Confluence, Notion
- **Framework-specific agents** - Django, Rails, Spring Boot specialists
- **Quality metrics** - More sophisticated code health scoring
- **Visualization** - Interactive architecture diagrams
- **CI/CD integrations** - GitHub Actions, GitLab CI templates

**To contribute:**

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Submit a pull request

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for detailed guidelines.

## Roadmap

### v1.1 (Q2 2025)
- [ ] HTML/PDF export formats
- [ ] Manual agent selection
- [ ] Custom agent creation wizard
- [ ] Integration with popular IDEs

### v1.2 (Q3 2025)
- [ ] Visual architecture diagrams
- [ ] Real-time collaboration features
- [ ] Cloud storage integration
- [ ] Advanced quality metrics

### v2.0 (Q4 2025)
- [ ] Interactive documentation browser
- [ ] Time-travel through codebase history
- [ ] AI-powered refactoring suggestions
- [ ] Team analytics dashboard

## Support

- **Documentation**: [Full guide](https://github.com/varaku1012/aditi.code/blob/main/plugins/steering-context-generator/README.md)
- **Issues**: [GitHub Issues](https://github.com/varaku1012/aditi.code/issues)
- **Discussions**: [GitHub Discussions](https://github.com/varaku1012/aditi.code/discussions)
- **Email**: contact@varaku.com

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Acknowledgments

- Built on [Claude Code](https://claude.ai/code) by Anthropic
- Inspired by the steering context engineering principles from the Claude community
- Special thanks to all contributors and early adopters

---

**Transform your codebase into AI-ready documentation:** Install with `/plugin install https://github.com/varaku1012/aditi.code`
