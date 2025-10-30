# Quasars Tools - Claude Code Plugin Marketplace

**Professional Claude Code plugins for team productivity, code quality, and development automation**

![Version](https://img.shields.io/badge/marketplace-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Plugins](https://img.shields.io/badge/plugins-7-brightgreen)

## 🎯 Overview

**Quasars Tools** is a comprehensive Claude Code plugin marketplace providing professional-grade tools and workflows for individual developers and teams. Built on Anthropic's official plugins, this marketplace extends Claude Code with specialized agents, commands, and automation for:

- ✅ **Feature Development** - Structured 7-phase workflow with codebase analysis
- ✅ **Code Review** - Automated PR review with confidence-based scoring
- ✅ **Git Workflows** - Streamlined commit, push, and PR creation
- ✅ **Code Quality** - Specialized review agents for tests, errors, types, and simplification
- ✅ **Security** - Proactive security warnings and best practices
- ✅ **Agent Development** - SDK scaffolding and verification
- ✅ **Learning** - Explanatory insights into code patterns

---

## 📦 Available Plugins

### 1. **feature-dev** ⭐ Core Feature Development
**7-phase structured workflow with specialized agents**

```bash
/plugin install feature-dev@quasars-tools
/feature-dev "Add user authentication with OAuth"
```

**Components**:
- **Command**: `/feature-dev` - Orchestrates complete feature development
- **Agents**:
  - `code-explorer` - Analyzes codebase for relevant patterns
  - `code-architect` - Designs feature architecture
  - `code-reviewer` - Reviews for quality and consistency

**Workflow**:
1. **Discovery** - Clarify requirements
2. **Exploration** - Understand existing patterns
3. **Design** - Plan architecture
4. **Implementation** - Build feature
5. **Testing** - Validate quality
6. **Integration** - Ensure seamless fit
7. **Documentation** - Write necessary docs

**Best For**: Building new features with systematic codebase understanding

---

### 2. **code-review** ⭐ Automated PR Review
**Multiple agents with confidence-based scoring (≥80% threshold)**

```bash
/plugin install code-review@quasars-tools
/code-review  # Reviews current pull request
```

**Components**:
- **Command**: `/code-review` - Automated PR review workflow
- **Features**:
  - Multiple specialized agents running in parallel
  - Confidence-based scoring filters false positives
  - Focus on high-impact issues
  - Integration with PR workflow

**Best For**: Catching issues early, maintaining code quality, reducing review burden

---

### 3. **commit-commands**
**Git workflow automation - commit, push, PR creation**

```bash
/plugin install commit-commands@quasars-tools
/commit "Add authentication feature"
/commit-push-pr
/clean_gone  # Clean up deleted branches
```

**Commands**:
- `/commit [message]` - Create git commit with appropriate message
- `/commit-push-pr` - Commit, push, and create PR in one command
- `/clean_gone` - Clean up stale local branches

**Best For**: Faster git workflows, less context switching

---

### 4. **pr-review-toolkit**
**Comprehensive specialized PR review agents**

```bash
/plugin install pr-review-toolkit@quasars-tools
# Agents activate automatically for PR reviews
```

**Specialized Agents** (6 agents):
- **comment-analyzer** - Analyzes code comments for clarity
- **test-coverage-expert** - Evaluates test coverage
- **error-handling-specialist** - Checks error handling patterns
- **type-design-expert** - Reviews type design and safety
- **code-quality-expert** - Evaluates code quality metrics
- **code-simplifier** - Suggests simplifications

**Best For**: Comprehensive PR quality assurance from multiple perspectives

---

### 5. **agent-sdk-dev**
**Claude Agent SDK development scaffolding**

```bash
/plugin install agent-sdk-dev@quasars-tools
/new-sdk-app  # Interactive setup for new Agent SDK projects
```

**Components**:
- **Command**: `/new-sdk-app` - Bootstrap new SDK applications
- **Agents**:
  - `agent-sdk-verifier-py` - Validates Python SDK apps
  - `agent-sdk-verifier-ts` - Validates TypeScript SDK apps

**Best For**: Building Claude Agent SDK applications in Python or TypeScript

---

### 6. **security-guidance**
**Proactive security warnings**

```bash
/plugin install security-guidance@quasars-tools
# Automatically warns about security issues
```

**Security Checks**:
- Command injection vulnerabilities
- Cross-site scripting (XSS) patterns
- SQL injection risks
- Unsafe code patterns
- Credential exposure

**Best For**: Preventing security issues before they reach production

---

### 7. **explanatory-output-style**
**Educational insights into code patterns**

```bash
/plugin install explanatory-output-style@quasars-tools
# Adds detailed explanations to Claude's responses
```

**Features**:
- Implementation choice explanations
- Codebase pattern insights
- Learning opportunities
- Design decision rationale

**Best For**: Understanding why code is written a certain way, learning patterns

---

## 🚀 Quick Start

### Installation

#### Option 1: Add Marketplace to Claude Code

```bash
# In your project directory
claude
/plugin marketplace add quasars-dev/quasars.tools
/plugin  # Browse and install plugins
```

#### Option 2: GitHub Shorthand

```bash
/plugin marketplace add quasars-dev/quasars.tools
```

#### Option 3: Full URL

```bash
/plugin marketplace add https://github.com/quasars-dev/quasars.tools.git
```

### Team-Wide Installation

Add to `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": [
    {
      "name": "quasars-tools",
      "source": "github",
      "repo": "quasars-dev/quasars.tools"
    }
  ],
  "enabledPlugins": {
    "feature-dev@quasars-tools": true,
    "code-review@quasars-tools": true,
    "commit-commands@quasars-tools": true
  }
}
```

When team members trust the folder, Claude Code will:
1. Prompt to install the marketplace
2. Automatically enable specified plugins
3. Ensure consistent tooling across the team

### Quick Usage

```bash
# Feature development workflow
/feature-dev Add user dashboard

# Automated code review on PR
/code-review

# Git operations
/commit "Feature: Add dashboard"
/commit-push-pr

# Clean up old branches
/clean_gone

# Create new Agent SDK app
/new-sdk-app

# Security checks (automatic)
# (Runs when you edit files)
```

---

## 📋 Plugin Categories

| Category | Plugins | Purpose |
|----------|---------|---------|
| **Development** | feature-dev, agent-sdk-dev, explanatory-output-style | Building and learning |
| **Quality** | code-review, pr-review-toolkit | Code quality assurance |
| **Productivity** | commit-commands | Developer workflow efficiency |
| **Security** | security-guidance | Preventing vulnerabilities |

---

## 🎯 Use Cases

### For Individual Developers

- ✅ Build features systematically with `feature-dev`
- ✅ Automate code reviews with `code-review`
- ✅ Streamline git with `commit-commands`
- ✅ Catch security issues with `security-guidance`

### For Teams

- ✅ Standardize development workflow via marketplace
- ✅ Ensure code quality with automated reviews
- ✅ Maintain security with proactive warnings
- ✅ Share knowledge with explanatory output style
- ✅ Verify SDK apps across Python and TypeScript

### For Projects

- ✅ Ensure consistent code quality
- ✅ Reduce review burden
- ✅ Accelerate feature development
- ✅ Prevent security issues
- ✅ Document architecture decisions

---

## 📚 Documentation

Each plugin includes comprehensive documentation:

- **Plugin README** - Installation and usage guide
- **Command Help** - Type `/help command-name` in Claude Code
- **Agent Descriptions** - Understand each agent's specialization
- **Examples** - Real-world usage scenarios

### Marketplace Documentation Structure

```
quasars.tools/
├── README.md (this file)
├── SETUP.md - Team setup instructions
├── TROUBLESHOOTING.md - Common issues
├── .claude-plugin/
│   └── marketplace.json - Plugin catalog
├── plugins/
│   ├── feature-dev/
│   ├── code-review/
│   ├── commit-commands/
│   ├── pr-review-toolkit/
│   ├── agent-sdk-dev/
│   ├── security-guidance/
│   └── explanatory-output-style/
├── docs/
│   ├── INSTALLATION.md
│   ├── TEAM-SETUP.md
│   └── BEST-PRACTICES.md
└── .github/
    └── workflows/ (GitHub Actions)
```

---

## 🔧 Configuration

### Per-Project Configuration

Create `.claude/settings.json` in your project:

```json
{
  "extraKnownMarketplaces": [
    {
      "name": "quasars-tools",
      "source": "github",
      "repo": "quasars-dev/quasars.tools"
    }
  ],
  "enabledPlugins": {
    "feature-dev@quasars-tools": true,
    "code-review@quasars-tools": true,
    "commit-commands@quasars-tools": true,
    "security-guidance@quasars-tools": true
  }
}
```

### Personal Configuration

Edit `~/.claude/settings.json` for user-wide settings:

```json
{
  "enabledPlugins": {
    "feature-dev@quasars-tools": true,
    "explanatory-output-style@quasars-tools": true
  }
}
```

---

## 🔄 Version Management

This marketplace follows [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0) - Breaking changes
- **MINOR** (1.X.0) - New features, non-breaking
- **PATCH** (1.0.X) - Bug fixes

### Current Version

- **Marketplace**: 1.0.0
- **All Plugins**: 1.0.0

---

## 📊 Plugin Statistics

| Plugin | Components | Type |
|--------|-----------|------|
| feature-dev | 1 command + 3 agents | Development |
| code-review | 1 command | Quality |
| commit-commands | 3 commands | Productivity |
| pr-review-toolkit | 6 agents | Quality |
| agent-sdk-dev | 1 command + 2 agents | Development |
| security-guidance | Hooks | Security |
| explanatory-output-style | Output style | Learning |

**Total**: 7 plugins, 11+ commands, 15+ agents

---

## 🛠️ Troubleshooting

### Plugin Installation Issues

**Problem**: Marketplace installation hangs

**Solution**:
```bash
# Verify Git access
git clone https://github.com/quasars-dev/quasars.tools.git

# Try direct URL
/plugin marketplace add https://github.com/quasars-dev/quasars.tools.git

# Check marketplace validity
curl https://raw.githubusercontent.com/quasars-dev/quasars.tools/main/.claude-plugin/marketplace.json
```

### Command Not Found

**Problem**: Installed plugin but commands don't appear

**Solution**:
```bash
# Reinstall plugin
/plugin uninstall feature-dev@quasars-tools
/plugin install feature-dev@quasars-tools

# Restart Claude Code
# Verify in help
/help
```

### Marketplace Not Discoverable

**Problem**: Can't find plugins in marketplace

**Solution**:
```bash
# List known marketplaces
/plugin marketplace list

# Check .claude/settings.json for extraKnownMarketplaces
cat .claude/settings.json
```

See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for more issues.

---

## 🤝 Contributing

We welcome contributions! To contribute:

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly (cross-model, cross-platform)
5. **Submit** a pull request

### Contribution Guidelines

- Follow [PLUGIN-DEVELOPMENT-STEERING.md](../PLUGIN-DEVELOPMENT-STEERING.md) standards
- Update marketplace.json if adding plugins
- Include comprehensive README
- Test with Haiku, Sonnet, and Opus
- Test on macOS, Linux, and Windows
- Add your plugin to this README

---

## 📄 License

All plugins in this marketplace are licensed under the **MIT License**. See [LICENSE](./LICENSE) for details.

---

## 🔗 Links

### Official Resources
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code/)
- [Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins)
- [Agent Skills Documentation](https://docs.claude.com/en/docs/claude-code/skills)
- [Marketplace Documentation](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)

### Community
- [Claude Developers Discord](https://anthropic.com/discord)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)
- [Official Plugin Examples](https://github.com/anthropics/claude-code/tree/main/plugins)

---

## 📞 Support

### Getting Help

1. **Check documentation** - Most questions answered in plugin READMEs
2. **See troubleshooting** - [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
3. **Review examples** - Each plugin includes usage examples
4. **Ask in Discord** - [Claude Developers Discord](https://anthropic.com/discord)

### Reporting Issues

Found a bug? Have a suggestion? Open an issue on [GitHub](https://github.com/quasars-dev/quasars.tools/issues)

Include:
- Which plugin/command affected
- Steps to reproduce
- Expected vs actual behavior
- Environment (OS, Claude Code version, plugin version)

---

## 🎓 Learning Path

### Beginner

1. Install `commit-commands` for basic workflow
2. Enable `security-guidance` for code protection
3. Learn with `explanatory-output-style`

### Intermediate

1. Start using `feature-dev` for new features
2. Enable `code-review` for PR automation
3. Add `pr-review-toolkit` for detailed reviews

### Advanced

1. Use all plugins for comprehensive workflow
2. Customize `.claude/settings.json` for team
3. Combine plugins for powerful automation

---

## 📈 Marketplace Growth

| Phase | Target |
|-------|--------|
| v1.0 | 7 plugins (complete) |
| v1.1 | 10+ plugins (community contributions) |
| v1.2 | 15+ plugins (specialized tools) |
| v2.0 | 20+ plugins (full ecosystem) |

---

## 🎉 Acknowledgments

This marketplace builds on work by:
- **Anthropic** - Official Claude Code and plugins
- **Community** - Contributors and feedback
- **Teams** - Early adopters and use cases

---

## 📝 Changelog

### v1.0.0 (2025-10-29)

**Initial Release**
- 7 professional plugins
- Complete documentation
- Team configuration support
- GitHub-based distribution
- MIT License

---

**Made with ❤️ by the Quasars Development Team**

**Ready to enhance your development workflow?**

```bash
/plugin marketplace add quasars-dev/quasars.tools
```

---

**Last Updated**: 2025-10-29
**Marketplace Status**: ✅ Production Ready
**License**: MIT
