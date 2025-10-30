# Quasars Tools - Installation & Team Setup Guide

**Complete guide for individuals and teams to use Quasars Tools plugins**

---

## 🚀 Quick Start (5 minutes)

### For Individual Developers

1. **Open Claude Code in your project**:
```bash
cd your-project
claude
```

2. **Add the marketplace**:
```bash
/plugin marketplace add quasars-dev/quasars.tools
```

3. **Install plugins**:
```bash
/plugin  # Interactive browser
# OR
/plugin install feature-dev@quasars-tools
/plugin install code-review@quasars-tools
/plugin install commit-commands@quasars-tools
```

4. **Start using**:
```bash
/feature-dev "Your feature description"
/commit "Your message"
/code-review
```

**Done!** You can now use all plugins.

---

## 👥 Team-Wide Setup (15 minutes)

### Prerequisites
- Each team member has Claude Code v2.0.20+
- Project with `.git` repository
- GitHub access (for pulling marketplace)

### Step 1: Create .claude/settings.json

In your project root, create `.claude/settings.json`:

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
    "security-guidance@quasars-tools": true,
    "pr-review-toolkit@quasars-tools": true
  }
}
```

### Step 2: Commit Configuration

```bash
git add .claude/settings.json
git commit -m "chore: Configure Quasars Tools marketplace for team"
git push origin main
```

### Step 3: Team Members Setup

Each team member:

1. **Pull latest code**:
```bash
git pull origin main
```

2. **Trust the project**:
   - First time Claude Code runs in project
   - Prompt appears: "Trust this folder?"
   - Click "Yes" or approve when asked

3. **Plugins install automatically**:
   - Claude Code detects `extraKnownMarketplaces`
   - Prompts to install marketplace
   - Installs specified plugins

4. **Verify installation**:
```bash
/help
# Should show /feature-dev, /commit, /code-review, etc.
```

### Step 4: Team Kickoff (Optional)

Share with team:

```bash
# Feature development workflow
/feature-dev "Example: Add authentication"

# Code review process
/code-review

# Git workflow
/commit "Update authentication"

# Clean up branches
/clean_gone
```

---

## 📋 Installation Methods

### Method 1: Interactive Plugin Browser

```bash
/plugin
# Browse available plugins
# Click "Install" on desired plugins
```

### Method 2: Direct Installation

```bash
# Install specific plugins
/plugin install feature-dev@quasars-tools
/plugin install code-review@quasars-tools
/plugin install pr-review-toolkit@quasars-tools
/plugin install agent-sdk-dev@quasars-tools
/plugin install commit-commands@quasars-tools
/plugin install security-guidance@quasars-tools
/plugin install explanatory-output-style@quasars-tools
```

### Method 3: Settings.json Configuration

Edit `~/.claude/settings.json` for personal setup:

```json
{
  "enabledPlugins": {
    "feature-dev@quasars-tools": true,
    "code-review@quasars-tools": true,
    "commit-commands@quasars-tools": true,
    "security-guidance@quasars-tools": true
  }
}
```

### Method 4: Project-Level Configuration

Create `.claude/settings.json` in project:

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

---

## 🎯 Plugin Selection Guide

### Recommended for All Projects

- ✅ **commit-commands** - Essential git workflow
- ✅ **security-guidance** - Prevent vulnerabilities
- ✅ **code-review** - Catch issues early

### Recommended for Teams

- ✅ All above, plus:
- ✅ **feature-dev** - Structured development
- ✅ **pr-review-toolkit** - Detailed reviews

### Recommended for SDK Development

- ✅ **agent-sdk-dev** - Scaffold and verify SDK apps

### Recommended for Learning

- ✅ **explanatory-output-style** - Understand patterns

---

## ✅ Verification Checklist

After installation, verify everything works:

### Individual Developer

- [ ] Marketplace installed: `/plugin marketplace list`
- [ ] Plugins show: `/plugin`
- [ ] Help works: `/help feature-dev`
- [ ] Commands available: `/feature-dev`, `/commit`, `/code-review`

### Team Setup

- [ ] `.claude/settings.json` committed to repo
- [ ] Team members can clone and trust folder
- [ ] Plugins install automatically
- [ ] All commands available after trust
- [ ] Shared workflow established

### Plugin Verification

Run these to verify each plugin:

```bash
# feature-dev
/help feature-dev

# code-review
/help code-review

# commit-commands
/help commit

# security-guidance
# (Runs automatically when editing files)

# Other plugins
/help  # Lists all available commands
```

---

## 🔧 Configuration Customization

### Custom Plugin Selection per Project

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
    "code-review@quasars-tools": false,
    "commit-commands@quasars-tools": true,
    "security-guidance@quasars-tools": true,
    "pr-review-toolkit@quasars-tools": false,
    "agent-sdk-dev@quasars-tools": false,
    "explanatory-output-style@quasars-tools": true
  }
}
```

### Personal Marketplace Settings

Edit `~/.claude/settings.json`:

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
    "explanatory-output-style@quasars-tools": true
  }
}
```

---

## 🐛 Troubleshooting

### Issue: Marketplace Installation Fails

**Symptoms**: `Cannot add marketplace` error

**Solutions**:

1. **Check Git Access**:
```bash
git clone https://github.com/quasars-dev/quasars.tools.git
rm -rf quasars.tools
```

2. **Try Direct URL**:
```bash
/plugin marketplace add https://github.com/quasars-dev/quasars.tools.git
```

3. **Check Network**:
```bash
curl https://raw.githubusercontent.com/quasars-dev/quasars.tools/main/.claude-plugin/marketplace.json
```

### Issue: Commands Not Available After Installation

**Symptoms**: `/feature-dev` not found

**Solutions**:

1. **Verify Installation**:
```bash
/plugin  # Check if plugins show
/plugin marketplace list  # Check marketplace added
```

2. **Reinstall Plugin**:
```bash
/plugin uninstall feature-dev@quasars-tools
/plugin install feature-dev@quasars-tools
```

3. **Restart Claude Code**:
```bash
# Exit and restart Claude in the directory
exit
claude
/help
```

### Issue: Team Members Can't Install Automatically

**Symptoms**: `.claude/settings.json` doesn't trigger installation

**Solutions**:

1. **Verify Configuration**:
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
    "feature-dev@quasars-tools": true
  }
}
```

2. **Check JSON Validity**:
```bash
# Validate JSON syntax
cat .claude/settings.json | jq .
```

3. **Trust Project**:
   - First time opening project in Claude Code
   - Should prompt "Trust this folder?"
   - Select "Yes"

4. **Manual Installation**:
```bash
/plugin marketplace add quasars-dev/quasars.tools
/plugin install feature-dev@quasars-tools
```

### Issue: Plugin Doesn't Activate or Work

**Symptoms**: Command installed but doesn't work

**Solutions**:

1. **Check Claude Code Version**:
```
Required: v2.0.20+
Check in Claude Code: /help
```

2. **Verify Plugin Installation**:
```bash
/plugin  # Check if plugin listed
/plugin enable feature-dev@quasars-tools
```

3. **Check for Errors**:
```bash
/help feature-dev  # Shows command help and any errors
```

4. **Reinstall**:
```bash
/plugin uninstall feature-dev@quasars-tools
/plugin install feature-dev@quasars-tools
```

See [../TROUBLESHOOTING.md](../TROUBLESHOOTING.md) for more issues.

---

## 🎓 Learning Path

### Day 1: Get Started
- [ ] Install marketplace
- [ ] Install basic plugins
- [ ] Try `/commit` command
- [ ] Try `/code-review` on a PR

### Day 2: Workflow Integration
- [ ] Use `/feature-dev` for new feature
- [ ] Use `/code-review` in PR
- [ ] Set up team configuration
- [ ] Share with team

### Day 3: Team Adoption
- [ ] Team members set up
- [ ] Everyone uses `/feature-dev`
- [ ] Establish workflow standards
- [ ] Track improvement

---

## 📊 Team Adoption Checklist

- [ ] Marketplace added to project
- [ ] `.claude/settings.json` created and committed
- [ ] All team members can install plugins
- [ ] Plugins appear in `/help`
- [ ] `/feature-dev` works
- [ ] `/code-review` works
- [ ] `/commit` commands work
- [ ] Team trained on workflows
- [ ] Plugins enabled in team settings
- [ ] Issues documented and resolved

---

## 🔄 Regular Maintenance

### Check for Updates

```bash
# Keep marketplace updated
git clone https://github.com/quasars-dev/quasars.tools.git
cd quasars.tools
git pull origin main

# Reinstall plugins if new versions available
/plugin uninstall feature-dev@quasars-tools
/plugin install feature-dev@quasars-tools
```

### Team Settings Review

Quarterly, review `.claude/settings.json`:
- Are all enabled plugins being used?
- Are there new plugins to try?
- Do team members need different selections?

---

## 💡 Pro Tips

### Tip 1: Custom Team Workflow

Create custom `.claude/settings.json` per project type:

```bash
# React projects
.claude/settings.json.react

# Backend projects
.claude/settings.json.backend
```

Then switch based on project:

```bash
cp .claude/settings.json.react .claude/settings.json
```

### Tip 2: Team Onboarding Script

Create `setup-claude-tools.sh`:

```bash
#!/bin/bash
echo "Setting up Quasars Tools for your project..."
mkdir -p .claude
cp .claude.example/settings.json .claude/settings.json
echo "✅ Configuration created"
echo "📝 Trust the project when prompted"
echo "🚀 Run: /plugin marketplace add quasars-dev/quasars.tools"
```

### Tip 3: Share Team Standards

Document in project README:

```markdown
## Claude Code Workflow

This project uses Quasars Tools plugins for development:

- **Feature Development**: `/feature-dev "description"`
- **Code Review**: `/code-review` on PR
- **Git Workflow**: `/commit`, `/commit-push-pr`
- **Security**: Automatic via `security-guidance`

Setup: See [SETUP.md](.claude/SETUP.md)
```

---

## 🎯 Next Steps

1. **Install**: Follow Quick Start above
2. **Configure**: Set up `.claude/settings.json` for team
3. **Learn**: Read individual plugin documentation
4. **Adopt**: Integrate into team workflow
5. **Share**: Spread benefits to broader team

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/quasars-dev/quasars.tools/issues)
- **Questions**: [Claude Developers Discord](https://anthropic.com/discord)
- **Docs**: [Main README](./README.md)

---

**Happy Plugin Setup! 🎉**

**Last Updated**: 2025-10-29
**Version**: 1.0.0
