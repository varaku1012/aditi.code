# Quasars Tools - Troubleshooting Guide

**Solutions for common issues with Quasars Tools plugins**

---

## 📊 Quick Reference

| Issue | Section | Solution Time |
|-------|---------|---|
| Marketplace won't install | Installation Issues | 5 min |
| Commands not found | Plugin Discovery | 5 min |
| Plugin not working | Plugin Activation | 10 min |
| Team setup problems | Team Configuration | 10 min |
| Command errors | Command-Specific | 5-15 min |

---

## 🔴 Installation Issues

### Issue: "Cannot add marketplace"

**Error Message**:
```
Error: Cannot add marketplace 'quasars-dev/quasars.tools'
Error: Network error or marketplace not found
```

**Causes**:
- Network connectivity issue
- GitHub access blocked
- Invalid marketplace format
- Firewall/proxy issues

**Solutions**:

1. **Check Network Connection**:
```bash
# Verify internet connectivity
ping github.com
curl -I https://github.com
```

2. **Verify Git Access**:
```bash
# Can you clone the repository?
git clone https://github.com/quasars-dev/quasars.tools.git
cd quasars.tools
git status
cd ..
rm -rf quasars.tools
```

3. **Try Full URL**:
```bash
/plugin marketplace add https://github.com/quasars-dev/quasars.tools.git
```

4. **Check marketplace.json**:
```bash
# Direct URL to marketplace file
curl https://raw.githubusercontent.com/quasars-dev/quasars.tools/main/.claude-plugin/marketplace.json | jq .
```

5. **Verify JSON Format**:
```bash
# Should be valid JSON
curl -s https://raw.githubusercontent.com/quasars-dev/quasars.tools/main/.claude-plugin/marketplace.json | python3 -m json.tool
```

6. **Proxy/Firewall Issues**:
```bash
# If behind corporate proxy, configure git
git config --global http.proxy [proxy-url]
git config --global https.proxy [proxy-url]
```

**Still Not Working?**:
- Check firewall/proxy rules
- Try from different network
- Report issue: https://github.com/quasars-dev/quasars.tools/issues

---

### Issue: "Marketplace installation hangs"

**Symptoms**:
- Command hangs indefinitely
- No error message
- Claude Code seems frozen

**Solutions**:

1. **Check Git Progress**:
```bash
# In another terminal
ps aux | grep git
# Should see git clone happening

# If no git process, kill and try again
killall git
/plugin marketplace add quasars-dev/quasars.tools
```

2. **Increase Timeout**:
```bash
# Give it more time
# Wait 60+ seconds before canceling
```

3. **Try from CLI**:
```bash
cd your-project
claude
/plugin marketplace add quasars-dev/quasars.tools
# Wait 30-60 seconds
```

4. **Check Network Connectivity**:
```bash
# Monitor network activity
# On Linux/Mac: open network monitor
# Check if GitHub is reachable

# Force IPv4 (if IPv6 issues)
git config --global url."https://".insteadOf "git://"
```

5. **Restart Claude Code**:
```bash
# Exit current session
exit
# Wait 5 seconds
# Restart
claude
```

---

## 🟡 Plugin Discovery Issues

### Issue: "Plugin marketplace not found"

**Error Message**:
```
Error: Marketplace 'quasars-dev/quasars.tools' not found
Cannot install plugin
```

**Solutions**:

1. **Verify Marketplace Added**:
```bash
/plugin marketplace list
# Should show 'quasars-tools' or 'quasars-dev/quasars.tools'
```

2. **Check .claude/settings.json**:
```bash
cat .claude/settings.json
# Should contain:
# "extraKnownMarketplaces": [
#   {
#     "name": "quasars-tools",
#     "source": "github",
#     "repo": "quasars-dev/quasars.tools"
#   }
# ]
```

3. **Add Marketplace Again**:
```bash
/plugin marketplace add quasars-dev/quasars.tools
/plugin marketplace list  # Verify it shows
```

4. **Invalid JSON in .claude/settings.json**:
```bash
# Validate JSON
cat .claude/settings.json | python3 -m json.tool
# Should show pretty-printed JSON without errors
```

---

### Issue: "Plugin not showing in /plugin browser"

**Symptoms**:
- Marketplace added
- `/plugin` shows other plugins
- Quasars plugins don't appear

**Solutions**:

1. **Clear Plugin Cache**:
```bash
# Cache location depends on OS
# macOS: ~/Library/Application Support/Claude Code
# Linux: ~/.config/claude-code or ~/.local/share/claude-code
# Windows: %APPDATA%/Claude Code

# Delete cache (will rebuild automatically)
rm -rf ~/.config/claude-code/cache  # Linux example
```

2. **Restart Claude Code**:
```bash
exit
wait 5 seconds
claude
/plugin
# Should now show Quasars plugins
```

3. **Check Marketplace Health**:
```bash
# In Claude Code
/plugin marketplace list
# Should show quasars-tools as active
```

---

## 🟠 Plugin Activation Issues

### Issue: "Command not found after installation"

**Error Message**:
```
/feature-dev: command not found
Error: Unknown command 'feature-dev'
```

**Solutions**:

1. **Verify Plugin Installation**:
```bash
/plugin
# Check if 'feature-dev' shows as installed
# Look for: ✓ feature-dev@quasars-tools
```

2. **Enable Plugin if Disabled**:
```bash
/plugin enable feature-dev@quasars-tools
```

3. **Reinstall Plugin**:
```bash
/plugin uninstall feature-dev@quasars-tools
/plugin install feature-dev@quasars-tools
```

4. **Verify Help**:
```bash
/help feature-dev
# Should show command documentation
# If not, plugin not properly installed
```

5. **Check Claude Code Version**:
```bash
# In Claude Code
/help
# Look for version: Claude Code v2.0.20+
# Feature-dev requires v2.0.20 or later
```

6. **Restart Required**:
```bash
exit
claude
/feature-dev  # Should now work
```

---

### Issue: "Skill not activating"

**Symptoms**:
- Plugin installed
- Command works
- Skill/agent doesn't activate automatically

**Solutions**:

1. **Verify Skill Exists**:
```bash
# Check plugin has skills
ls plugins/feature-dev/agents/
# Should show: code-architect.md, code-explorer.md, code-reviewer.md
```

2. **Use Command Instead**:
```bash
# Some plugins use commands, not skills
/feature-dev "Your request"
# Agent activates when command is used
```

3. **Be Explicit**:
```bash
# Try mentioning what you need
"I want to develop a new feature: Add authentication"
# Should trigger /feature-dev workflow
```

4. **Check Plugin Type**:
- Some plugins are commands (user-invoked)
- Some plugins are agents (auto-activated)
- See README for plugin type

---

## 🔵 Plugin Functionality Issues

### Issue: "Command executes but fails"

**Symptoms**:
- Command recognized
- Execution starts
- Then error or unexpected behavior

**Solutions**:

1. **Feature-Dev Fails**:
```bash
# This command needs codebase access
# Make sure you're in project root

# Try in project directory
cd your-project
/feature-dev "Add user authentication"

# Check if codebase readable
ls -la  # Should show project files
```

2. **Code-Review Fails**:
```bash
# Need to be in a repository with git
# Need to have a pull request open

# Verify git repo
git status

# Verify PR context (if using GitHub)
gh pr status
```

3. **Commit Commands Fail**:
```bash
# Verify git config
git config --list

# Verify git access
git status

# Make sure there are changes
git status  # Should show modified files
```

4. **Check Credentials**:
```bash
# For GitHub PR operations
gh auth status

# If not authenticated
gh auth login
```

5. **Read Command Error Message**:
```
The error message usually explains the issue
Look for:
- File not found
- Permission denied
- Network error
- Authentication needed
```

---

## 🟣 Team Configuration Issues

### Issue: "Team members can't auto-install plugins"

**Symptoms**:
- `.claude/settings.json` committed
- Team member doesn't get prompt
- Plugins not installed automatically

**Solutions**:

1. **Verify Settings File**:
```bash
cat .claude/settings.json
# Should have valid JSON:
# {
#   "extraKnownMarketplaces": [
#     {
#       "name": "quasars-tools",
#       "source": "github",
#       "repo": "quasars-dev/quasars.tools"
#     }
#   ],
#   "enabledPlugins": {
#     "feature-dev@quasars-tools": true
#   }
# }
```

2. **Validate JSON**:
```bash
python3 -c "import json; json.load(open('.claude/settings.json'))"
# If no output, JSON is valid
# If error, fix JSON syntax
```

3. **Ensure File Is Committed**:
```bash
git ls-files | grep ".claude/settings.json"
# Should show the file is tracked

# If not tracked
git add .claude/settings.json
git commit -m "Add Claude Code configuration"
git push
```

4. **Team Member Must Trust Project**:
```
First time opening project in Claude Code:
1. Prompt appears: "Trust this folder?"
2. Click "Yes" or approve when asked
3. Then plugins install automatically
```

5. **Manual Fallback**:
```bash
# If auto-install doesn't work
/plugin marketplace add quasars-dev/quasars.tools
/plugin install feature-dev@quasars-tools
```

---

### Issue: "Inconsistent plugins across team"

**Symptoms**:
- Different team members have different plugins
- Some features don't work for everyone
- Workflow inconsistent

**Solutions**:

1. **Standardize .claude/settings.json**:
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

2. **Commit and Push**:
```bash
git add .claude/settings.json
git commit -m "Standardize Quasars Tools configuration"
git push origin main
```

3. **Team Update**:
```bash
git pull origin main
# Claude Code will detect and install missing plugins
```

4. **Verify Everyone Has Same Setup**:
```bash
/plugin marketplace list
/plugin
# Compare across team members
```

---

## 🟢 Command-Specific Issues

### `/feature-dev` Issues

**Problem**: Command starts but doesn't complete

**Solutions**:
```bash
# Make sure codebase is accessible
cd your-project
git status  # Repository initialized
ls -la      # Files visible

# Try again
/feature-dev "Add user authentication"

# If still fails, check:
# - Are there files in the project?
# - Is Git repository initialized?
# - Do you have read permissions?
```

**Problem**: Wrong suggestions or analysis

**Solutions**:
```bash
# Provide more specific description
/feature-dev "Add OAuth2 authentication to login flow, integrate with existing user service"

# Give context about similar features
# Agent will search codebase better with hints
```

---

### `/code-review` Issues

**Problem**: Not finding issues

**Solutions**:
```bash
# Code-review needs PR context
# Use it when reviewing a pull request:
# 1. Have PR open on GitHub
# 2. Be in the PR's branch
# 3. Run /code-review

# Or explicitly provide context
/code-review  # Reviews current PR
```

**Problem**: Too many false positives

**Solutions**:
```bash
# Code-review uses 80% confidence threshold
# Lower confidence issues are filtered out

# Look for issues marked with ✓ or high confidence
# Ignore low-confidence suggestions

# If specific issue is wrong, you can:
# - Mark as resolved in GitHub
# - Add comment explaining decision
```

---

### `/commit` Issues

**Problem**: Commit message formatting wrong

**Solutions**:
```bash
# Claude suggests message format
# You can edit before committing
/commit "Your message"

# If message not right:
git reset --soft HEAD~1  # Undo commit
/commit "Better message"
```

**Problem**: Commits included unintended files

**Solutions**:
```bash
# Stage only intended files
git add specific-file.js
/commit "Message about specific file"

# Or use interactive
git add -p  # Interactive staging
/commit "Message"
```

---

## 🔍 Debugging Steps

### General Troubleshooting Process

1. **Identify the Problem**:
   - Which plugin?
   - What command?
   - What exactly goes wrong?
   - Error message?

2. **Check Prerequisites**:
   ```bash
   # Claude Code version
   /help

   # Git setup
   git status
   git config --list

   # Marketplace
   /plugin marketplace list
   ```

3. **Verify Installation**:
   ```bash
   # Plugin installed?
   /plugin

   # Plugin enabled?
   /plugin enable feature-dev@quasars-tools
   ```

4. **Try Basic Troubleshooting**:
   ```bash
   # Restart Claude
   exit
   claude

   # Reinstall plugin
   /plugin uninstall feature-dev@quasars-tools
   /plugin install feature-dev@quasars-tools
   ```

5. **Check Documentation**:
   - Plugin README
   - Command help `/help command`
   - Setup guide [SETUP.md](./SETUP.md)

6. **Report Issue**:
   - If still not working
   - https://github.com/quasars-dev/quasars.tools/issues
   - Include all troubleshooting steps tried

---

## 📞 Getting Help

### Where to Find Help

1. **This Guide**: Check sections above
2. **Plugin README**: Each plugin has documentation
3. **Setup Guide**: [SETUP.md](./SETUP.md)
4. **GitHub Issues**: [Report bugs](https://github.com/quasars-dev/quasars.tools/issues)
5. **Discord**: [Claude Developers Discord](https://anthropic.com/discord)

### When Reporting Issues

Include:
- [ ] Which plugin?
- [ ] Which command?
- [ ] What's the error message?
- [ ] What were you trying to do?
- [ ] Your environment (OS, Claude Code version)
- [ ] Steps to reproduce
- [ ] Troubleshooting steps you tried

---

## 📋 Issue Checklist

Before reporting an issue, check:

- [ ] Claude Code is v2.0.20+
- [ ] Marketplace is installed: `/plugin marketplace list`
- [ ] Plugin is installed: `/plugin`
- [ ] Plugin is enabled: `/plugin enable plugin-name@quasars-tools`
- [ ] You're in correct directory (project root)
- [ ] Git repository is initialized: `git status`
- [ ] You tried restarting Claude Code
- [ ] You read the plugin README
- [ ] You tried reinstalling the plugin
- [ ] Network/internet connectivity works

---

## ✅ Quick Fixes

| Issue | Quick Fix | Time |
|-------|-----------|------|
| Marketplace hangs | Wait 60s or restart | 1 min |
| Command not found | `/plugin enable plugin-name@quasars-tools` | 1 min |
| Plugin not showing | Clear cache, restart | 2 min |
| Team sync issue | Commit `.claude/settings.json` | 2 min |
| Command fails | Check you're in project directory | 1 min |

---

## 🎯 Common Mistakes

**❌ Mistake 1**: Using old version of Claude Code
- **✅ Fix**: Update to v2.0.20+

**❌ Mistake 2**: Running command outside project
- **✅ Fix**: `cd your-project` first

**❌ Mistake 3**: Not committing `.claude/settings.json`
- **✅ Fix**: `git add .claude/settings.json && git commit`

**❌ Mistake 4**: Invalid JSON in settings file
- **✅ Fix**: Use JSON validator or IDE

**❌ Mistake 5**: Not trusting project on first open
- **✅ Fix**: Click "Yes" when prompted

---

**Last Updated**: 2025-10-29
**Version**: 1.0.0

**Still need help?**
- 🐛 Report issue: https://github.com/quasars-dev/quasars.tools/issues
- 💬 Ask community: [Claude Developers Discord](https://anthropic.com/discord)
- 📖 Read setup guide: [SETUP.md](./SETUP.md)
