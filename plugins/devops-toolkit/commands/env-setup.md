---
description: Setup and manage environment variables and configuration
argument-hint: [environment] [--list|--set|--copy]
allowed-tools: Read, Write, Edit, Bash
---

# Environment Setup

Manage environment variables and configuration.

## Usage

```
/env-setup development              # Setup dev environment
/env-setup --list                   # List all env vars
/env-setup --set KEY=value          # Set a variable
/env-setup --copy staging production # Copy between envs
```

## Environment Files

```
.env                    # Local development (git-ignored)
.env.example            # Template with placeholders
.env.staging            # Staging environment
.env.production         # Production environment
```

## Required Variables

### API Keys
```bash
# LLM Provider
OPENROUTER_API_KEY=sk-or-...

# Image Generation
GOOGLE_API_KEY=AIza...

# Video Generation
YUNWU_API_KEY=...
```

### Application
```bash
# Environment
APP_ENV=development
DEBUG=true
LOG_LEVEL=INFO

# Paths
WORKING_DIR=./output
CONFIG_PATH=./configs
```

### Database (if applicable)
```bash
DATABASE_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://localhost:6379
```

## Setup Wizard

Interactive setup for new developers:

```
/env-setup development

? OPENROUTER_API_KEY: sk-or-v1-...
? GOOGLE_API_KEY: AIza...
? WORKING_DIR: ./output
? LOG_LEVEL: [INFO]

✓ Created .env with 12 variables
✓ Validated API keys
✓ Created working directory
```

## Validation

Check environment is properly configured:

```bash
# Validate all required variables
/env-setup --validate

Checking environment...
✓ OPENROUTER_API_KEY: Set
✓ GOOGLE_API_KEY: Set
✓ WORKING_DIR: ./output (exists)
✗ YUNWU_API_KEY: Not set (optional)

Status: Ready (3/4 required vars set)
```

## Security

### Never Commit
```gitignore
# .gitignore
.env
.env.local
.env.*.local
*.key
*.pem
```

### Secrets Management
```bash
# Use environment variables
export API_KEY=$(vault read -field=key secret/api)

# Or secrets manager
/env-setup --from-vault staging
/env-setup --from-aws-secrets production
```

## Copy Between Environments

```
/env-setup --copy staging production

Copying staging → production...
? Copy OPENROUTER_API_KEY? [y/n]: n (use production key)
? Copy GOOGLE_API_KEY? [y/n]: y
? Copy LOG_LEVEL? [y/n]: n (production uses WARNING)

Created .env.production with 8 variables
Review before deploying!
```

## Template Generation

```
/env-setup --generate-example

Generated .env.example:
# API Keys
OPENROUTER_API_KEY=your_openrouter_key_here
GOOGLE_API_KEY=your_google_api_key_here

# Application
APP_ENV=development
DEBUG=false
LOG_LEVEL=INFO

# Paths
WORKING_DIR=./output
```
