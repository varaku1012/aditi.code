# Contributing to Quasars Tools

**Thank you for your interest in contributing to Quasars Tools!**

This guide helps you contribute plugins, improvements, and bug fixes to the marketplace.

---

## 🎯 How to Contribute

### Report a Bug

1. **Check existing issues**: https://github.com/quasars-dev/quasars.tools/issues
2. **Create new issue** with:
   - Clear title
   - Description of the bug
   - Steps to reproduce
   - Expected vs actual behavior
   - Your environment (OS, Claude Code version)

### Suggest a Feature

1. **Open a discussion**: https://github.com/quasars-dev/quasars.tools/discussions
2. **Describe**:
   - What problem would it solve?
   - Who would benefit?
   - How would it work?

### Contribute a Plugin

See [Plugin Development Guide](#plugin-development-guide) below.

### Improve Documentation

1. **Fork the repository**
2. **Edit markdown files**
3. **Submit pull request**

---

## 📦 Plugin Development Guide

### Before You Start

1. **Understand Plugin Structure**:
   - Read [PLUGIN-DEVELOPMENT-STEERING.md](../PLUGIN-DEVELOPMENT-STEERING.md)
   - Review existing plugins in `plugins/` directory

2. **Follow Standards**:
   - Semantic versioning (MAJOR.MINOR.PATCH)
   - MIT or compatible license
   - Comprehensive documentation
   - Cross-model testing (Haiku, Sonnet, Opus)
   - Cross-platform testing (macOS, Linux, Windows)

### Development Workflow

#### Step 1: Set Up Development Environment

```bash
# Fork repository
git clone https://github.com/your-username/quasars.tools.git
cd quasars.tools

# Create feature branch
git checkout -b feature/new-plugin-name
```

#### Step 2: Create Plugin Structure

```bash
mkdir -p plugins/your-plugin-name/.claude-plugin
mkdir -p plugins/your-plugin-name/commands
mkdir -p plugins/your-plugin-name/agents
mkdir -p plugins/your-plugin-name/skills
```

#### Step 3: Develop Plugin Components

**Create `.claude-plugin/plugin.json`**:
```json
{
  "name": "your-plugin-name",
  "version": "1.0.0",
  "description": "Clear description of what plugin does",
  "author": {
    "name": "Your Name",
    "email": "your.email@example.com"
  },
  "license": "MIT"
}
```

**Create components** (commands, agents, skills):
- Commands in `commands/*.md`
- Agents in `agents/*.md`
- Skills in `skills/skill-name/SKILL.md`

**Create README**:
```bash
cat > plugins/your-plugin-name/README.md <<'EOF'
# Plugin Name

Brief description.

## Overview

What problem does it solve?

## Components

List all commands, agents, skills.

## Installation

/plugin install your-plugin-name@quasars-tools

## Usage

Examples and how to use.

## Contributing

Guidelines for this plugin.
EOF
```

#### Step 4: Testing

**Local Testing**:
```bash
# Set up local marketplace
cd quasars.tools
/plugin marketplace add ./
/plugin install your-plugin-name@local

# Test each command/agent
/your-command
```

**Cross-Model Testing**:
```bash
# Test with all three models
- Haiku (required)
- Sonnet (required)
- Opus (recommended)

# Each model must work correctly
```

**Cross-Platform Testing**:
```bash
# Test on:
- macOS
- Linux
- Windows

# Check:
- All paths use forward slashes (/)
- No platform-specific commands
- Works consistently across platforms
```

**Quality Checklist**:
- [ ] Plugin metadata complete
- [ ] All components documented
- [ ] Commands have examples
- [ ] Agents have clear instructions
- [ ] Skills have trigger descriptions
- [ ] README comprehensive
- [ ] Tested with Haiku, Sonnet, Opus
- [ ] Tested on macOS, Linux, Windows
- [ ] No hardcoded secrets
- [ ] Error handling implemented

#### Step 5: Update Marketplace

Update `.claude-plugin/marketplace.json`:

```json
{
  "name": "your-plugin-name",
  "version": "1.0.0",
  "description": "Your plugin description",
  "category": "development",
  "author": {
    "name": "Your Name",
    "email": "your.email@example.com"
  },
  "source": "./plugins/your-plugin-name",
  "homepage": "https://github.com/quasars-dev/quasars.tools/tree/main/plugins/your-plugin-name",
  "keywords": ["keyword1", "keyword2"],
  "commands": ["command-name"],
  "agents": ["agent-name"],
  "skills": ["skill-name"]
}
```

#### Step 6: Documentation

Update `README.md`:
- Add plugin to plugin list
- Include usage examples
- Mention new features

Create `docs/plugin-name.md` (optional):
```bash
# Plugin Name

Detailed documentation for plugin.
```

#### Step 7: Submit Pull Request

```bash
# Commit changes
git add .
git commit -m "feat: Add plugin-name plugin

- Adds [features]
- Includes [components]
- Tested across models and platforms"

# Push and create PR
git push origin feature/new-plugin-name
```

**PR Checklist**:
- [ ] Clear PR title and description
- [ ] References issue if applicable
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Follows contribution guidelines

---

## 🎨 Plugin Development Standards

### Code Quality

- **Clarity**: Clear, understandable code and documentation
- **Conciseness**: Avoid unnecessary complexity
- **Comments**: Explain non-obvious decisions
- **Errors**: Explicit error handling

### Documentation Quality

- **Complete**: Covers all features
- **Clear**: Easy to understand
- **Examples**: Real-world usage
- **Organized**: Logical structure

### Testing Requirements

- **Cross-Model**: Haiku, Sonnet, Opus (all required)
- **Cross-Platform**: macOS, Linux, Windows (all required)
- **Real Scenarios**: Test with actual use cases
- **Error Handling**: Test edge cases

### Security Standards

- ✅ No hardcoded credentials
- ✅ Use environment variables for secrets
- ✅ Validate user inputs
- ✅ No command injection vulnerabilities
- ✅ No XSS vulnerabilities
- ✅ Follow security best practices

### Performance Standards

- **Context Efficiency**: Minimize token consumption
- **Skill Size**: SKILL.md under 500 lines (use progressive disclosure)
- **Response Time**: Reasonable execution time
- **Resource Usage**: Don't consume excessive resources

---

## 📋 Plugin Categories

Choose appropriate category:

- **development** - Feature development, scaffolding, testing
- **productivity** - Workflow automation, git operations
- **quality** - Code review, testing, analysis
- **security** - Security checks, vulnerability detection
- **learning** - Documentation, explanations, examples

---

## 🔄 Review Process

### What We Look For

✅ **Quality**:
- Well-written code
- Clear documentation
- Proper testing
- Error handling

✅ **Standards**:
- Follows marketplace standards
- Semantic versioning
- MIT or compatible license
- Cross-platform compatible

✅ **Value**:
- Solves a real problem
- Useful for teams/developers
- Clear use cases
- Good documentation

❌ **We Don't Accept**:
- Malware or security risks
- Incomplete plugins
- Poor documentation
- Platform-specific code
- Hardcoded credentials

### Review Feedback

We'll provide feedback on:
- Code quality
- Documentation
- Testing
- Standards compliance
- Suggested improvements

Address feedback, then resubmit.

---

## 💬 Communication

### Get Help

- **Questions**: GitHub Discussions
- **Design Review**: Open issue before developing
- **Progress**: Comments on PR for ongoing feedback
- **Discord**: [Claude Developers Discord](https://anthropic.com/discord)

### Code Review

- Be respectful and constructive
- Focus on code, not person
- Explain reasoning
- Suggest improvements
- Accept corrections gracefully

---

## 📝 Commit Message Guidelines

Use clear, descriptive commits:

```
feat: Add feature-x plugin

- Implements [feature description]
- Includes [components]
- Tested across models and platforms

Fixes #123
```

**Commit Types**:
- `feat:` - New feature/plugin
- `fix:` - Bug fix
- `docs:` - Documentation
- `refactor:` - Code reorganization
- `test:` - Testing improvements
- `chore:` - Maintenance

---

## 🚀 Release Process

### Version Updates

We use semantic versioning:

```bash
# PATCH (1.0.0 → 1.0.1): Bug fixes
# MINOR (1.0.0 → 1.1.0): New features
# MAJOR (1.0.0 → 2.0.0): Breaking changes
```

### Release Checklist

Before releasing:
- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG updated
- [ ] Version number incremented
- [ ] Git tag created

---

## 📚 Resources

### For Plugin Development

- [Plugin Development Steering](../PLUGIN-DEVELOPMENT-STEERING.md) - Complete guide
- [Plugin Templates](../PLUGIN-TEMPLATE.md) - Ready-to-use templates
- [Quick Reference](../PLUGIN-QUICK-REFERENCE.md) - Fast lookup
- [Official Examples](https://github.com/anthropics/claude-code/tree/main/plugins)

### For Claude Code

- [Documentation](https://docs.claude.com/en/docs/claude-code/)
- [Plugins Guide](https://docs.claude.com/en/docs/claude-code/plugins)
- [Skills Guide](https://docs.claude.com/en/docs/claude-code/skills)

---

## ❓ FAQ

### Q: Can I contribute a plugin for [domain]?

A: Yes! As long as it:
- Solves a real problem
- Works across models/platforms
- Is well-documented
- Follows standards

### Q: Do I need to be a Quasars team member?

A: No! We welcome external contributions. You don't need to be affiliated with Quasars.

### Q: What license should I use?

A: MIT License (recommended) or other permissive licenses. Proprietary licenses not accepted.

### Q: Can I monetize my plugin?

A: Plugins are open-source and free. Commercial use is welcome within MIT terms.

### Q: How do I get feedback before submitting?

A: Open a GitHub Discussion to discuss your idea before starting development.

### Q: What's the timeline for review?

A: We aim to review PRs within 5-7 days. Complex plugins may take longer.

---

## 🏆 Recognition

### Contributors

All contributors are recognized in:
- GitHub contributors list
- [CONTRIBUTORS.md](./CONTRIBUTORS.md)
- Marketplace documentation

### High-Quality Contributions

Exceptional contributions may be featured in:
- README highlights
- Release announcements
- Community showcase

---

## 💝 Code of Conduct

We're committed to providing a welcoming and respectful community.

### Our Values

- **Respect**: Treat everyone with respect
- **Inclusive**: Welcome all backgrounds
- **Constructive**: Focus on ideas, not individuals
- **Collaborative**: Work together toward common goals

### Expected Behavior

- Be respectful in all interactions
- Provide constructive feedback
- Accept different viewpoints
- Help others learn and grow

### Unacceptable Behavior

- Harassment or discrimination
- Disrespectful language
- Attacks on individuals
- Unprofessional conduct

**Report Issues**: contact@quasars.dev

---

## 🙏 Thank You

Thank you for considering contributing to Quasars Tools! Your efforts help make development better for everyone.

---

**Happy Contributing! 🎉**

**Questions?**
- 📖 Read documentation
- 💬 Open discussion
- 📧 Email: contact@quasars.dev
- 🐛 Report issues: GitHub Issues

**Last Updated**: 2025-10-29
**Version**: 1.0.0
