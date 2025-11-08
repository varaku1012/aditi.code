# Auth0 OAuth Plugin

Comprehensive Auth0 OAuth 2.0 implementation plugin for Claude Code. Provides setup wizards, implementation guides, security audits, and troubleshooting for Auth0 authentication across web and mobile applications.

## Features

### ✨ 4 Specialized Agents

1. **Auth0 Architect** (`auth0-architect`)
   - Design secure OAuth flows
   - Configure Auth0 tenants
   - Select appropriate flow (PKCE, Client Credentials, etc.)
   - Document authentication architecture

2. **OAuth Implementation Expert** (`oauth-implementation-expert`)
   - Framework-specific code patterns (React, Next.js, Node.js, FastAPI, Django, Flutter, React Native)
   - SDK setup and configuration
   - Login/logout flows
   - Protected routes and API integration
   - Testing patterns

3. **Auth0 Security Specialist** (`auth0-security-specialist`)
   - Identify OAuth vulnerabilities (token leakage, PKCE bypass, CSRF)
   - Security best practices
   - Compliance requirements (GDPR, HIPAA, SOC2)
   - Security hardening recommendations
   - Audit checklists

4. **OAuth Integration Mapper** (`oauth-integration-mapper`)
   - Map Auth0 integrations with external services
   - Document data flows (user directories, webhooks, third-party APIs)
   - Salesforce, HubSpot, and other service integrations
   - Complete system architecture diagrams

### 🚀 5 Slash Commands

1. **`/oauth-setup-auth0`**
   - Interactive Auth0 tenant setup
   - Application configuration (SPA, Web, M2M, Native)
   - Connection setup (database, social, enterprise)
   - Environment variables generation
   - Security hardening checklist

2. **`/oauth-implement [framework]`**
   - Step-by-step implementation for:
     - React (Vite, Create React App)
     - Next.js (App & Pages Router)
     - Node.js/Express
     - Python/FastAPI
     - Python/Django
     - Vue.js, Svelte
     - Flutter, React Native
   - Code examples for each framework
   - Testing patterns
   - Common issues and solutions

3. **`/oauth-security-audit`**
   - 45-point security checklist
   - Vulnerability identification
   - Compliance verification (GDPR, HIPAA, SOC2)
   - Risk scoring
   - Remediation priorities

4. **`/oauth-troubleshoot [issue]`**
   - Solutions for common problems:
     - Callback URL mismatch
     - Token expiration
     - CORS errors
     - Silent authentication
     - Missing scopes
     - MFA issues
     - Social login failures
   - Debugging techniques
   - Testing strategies

5. **`/oauth-migrate [provider]`**
   - Migration guides from:
     - Firebase Authentication
     - AWS Cognito
     - Okta
     - Keycloak
     - Custom implementations
   - Phase-by-phase migration plan
   - User data migration strategies
   - Rollback procedures
   - Zero-downtime migration approach

## Installation

The plugin is included in this repository at:
```
plugins/auth0-oauth-plugin/
```

To use in Claude Code:

```bash
# Navigate to your project
cd your-project

# The plugin is available via commands
/oauth-setup-auth0
/oauth-implement react
/oauth-security-audit
/oauth-troubleshoot callback-mismatch
/oauth-migrate firebase
```

Or install from the plugin marketplace:
```bash
/plugin install auth0-oauth
```

## Quick Start

### For New Auth0 Implementation

1. **Start setup wizard**:
   ```bash
   /oauth-setup-auth0
   ```

2. **Implement in your framework**:
   ```bash
   /oauth-implement [react|nextjs|nodejs|fastapi|django]
   ```

3. **Run security audit**:
   ```bash
   /oauth-security-audit
   ```

4. **Deploy and troubleshoot**:
   ```bash
   /oauth-troubleshoot [issue]
   ```

### For Migrating to Auth0

1. **Get migration guide**:
   ```bash
   /oauth-migrate [firebase|cognito|okta|keycloak|custom]
   ```

2. **Set up new Auth0 tenant**:
   ```bash
   /oauth-setup-auth0
   ```

3. **Implement new auth code**:
   ```bash
   /oauth-implement [framework]
   ```

4. **Verify security**:
   ```bash
   /oauth-security-audit
   ```

## Supported Frameworks

### Frontend
- ✅ React (Vite, Create React App)
- ✅ Next.js (App Router & Pages Router)
- ✅ Vue.js
- ✅ Svelte
- ✅ Angular (via Angular auth library)
- ✅ Plain JavaScript/HTML

### Backend
- ✅ Node.js/Express
- ✅ Next.js API routes
- ✅ Python/FastAPI
- ✅ Python/Django
- ✅ Go
- ✅ Java/Spring

### Mobile
- ✅ React Native
- ✅ Flutter
- ✅ iOS (native)
- ✅ Android (native)

## OAuth Flows Covered

- ✅ **Authorization Code + PKCE** - For SPAs and mobile apps
- ✅ **Authorization Code** - For server-side applications
- ✅ **Client Credentials** - For machine-to-machine communication
- ✅ **Device Code** - For CLI tools and IoT devices
- ✅ **Refresh Token Rotation** - For secure token refresh
- ✅ **Implicit Flow** (not recommended) - Legacy support

## Security Features

### Vulnerability Prevention
- PKCE implementation for authorization code interception
- Token leakage prevention (in-memory storage)
- CSRF protection (state parameter validation)
- ID token vs Access token distinction
- Scope validation and enforcement
- Token expiration and rotation

### Compliance Support
- ✅ **GDPR** - User consent, data deletion, portability
- ✅ **HIPAA** - MFA, audit logging, encryption
- ✅ **SOC2** - Access controls, change logs, incident response
- ✅ **PCI-DSS** - No raw card storage, token handling

### Best Practices
- HTTP-only cookies for server-side apps
- In-memory token storage for SPAs
- Automatic token refresh
- JWT signature validation
- Audience and issuer validation
- Scope-based authorization

## Integration Examples

### Included Integrations
- ✅ **Salesforce** - Sync users and contacts
- ✅ **HubSpot** - Contact management integration
- ✅ **Active Directory/LDAP** - Enterprise SSO
- ✅ **Webhooks** - Custom user sync workflows
- ✅ **Auth0 Management API** - Programmatic user management
- ✅ **Database Migrations** - Import users from other providers

## Plugin Structure

```
auth0-oauth-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── agents/
│   ├── auth0-architect.md       # OAuth flow design (3,500+ lines)
│   ├── oauth-implementation-expert.md    # Code patterns (4,000+ lines)
│   ├── auth0-security-specialist.md      # Security & compliance (3,500+ lines)
│   └── oauth-integration-mapper.md       # Integration patterns (2,500+ lines)
├── commands/
│   ├── oauth-setup-auth0.md     # Setup wizard
│   ├── oauth-implement.md        # Implementation guide
│   ├── oauth-security-audit.md   # Security checklist
│   ├── oauth-troubleshoot.md     # Troubleshooting guide
│   └── oauth-migrate.md          # Migration guide
└── README.md                     # This file
```

## Generated Documentation

Running the agents creates comprehensive context documents:

- **AUTH0_ARCHITECTURE.md** - OAuth flow diagrams and configuration
- **AUTH0_IMPLEMENTATION.md** - Framework-specific implementation guide
- **AUTH0_SECURITY_AUDIT.md** - Security assessment report
- **AUTH0_INTEGRATIONS.md** - Third-party service integration map

These files are saved to `.claude/steering/` for reference in future development.

## Common Use Cases

### Use Case 1: Add Auth0 to React App
```bash
/oauth-setup-auth0           # Configure Auth0 tenant
/oauth-implement react       # Get React implementation code
/oauth-security-audit        # Verify security
```

### Use Case 2: Implement Full-Stack Auth
```bash
/oauth-setup-auth0              # Configure Auth0
/oauth-implement nextjs          # Frontend + backend setup
/oauth-implement nodejs          # Additional backend API protection
/oauth-security-audit            # Verify security
```

### Use Case 3: Migrate from Firebase
```bash
/oauth-migrate firebase          # Get migration plan
/oauth-setup-auth0               # Set up Auth0 tenant
/oauth-implement react           # Update frontend code
/oauth-implement nodejs          # Update backend validation
/oauth-security-audit            # Verify security post-migration
```

### Use Case 4: Debug Auth Issues
```bash
/oauth-troubleshoot callback-mismatch  # Common issue
/oauth-troubleshoot token-expired      # Token problems
/oauth-troubleshoot cors-error         # API integration issues
```

## Configuration

### Environment Variables

The plugin guides you to set up:

```env
# Auth0 Configuration
AUTH0_DOMAIN=YOUR_DOMAIN.auth0.com
AUTH0_CLIENT_ID=YOUR_CLIENT_ID
AUTH0_CLIENT_SECRET=YOUR_CLIENT_SECRET

# Application URLs
AUTH0_CALLBACK_URL=http://localhost:3000/callback
AUTH0_BASE_URL=http://localhost:3000
AUTH0_AUDIENCE=https://api.myapp.com

# Scopes
AUTH0_SCOPE=openid profile email read:items write:items
```

### Auth0 Configuration

Guide walks through:
- Creating Auth0 tenant
- Configuring applications (SPA, Web, M2M, Native)
- Setting up connections (database, social, enterprise)
- Defining APIs and scopes
- Configuring rules for custom logic
- Setting up roles and permissions

## API Reference

### Agents

Each agent can be invoked with:
```bash
/task auth0-architect
/task oauth-implementation-expert
/task auth0-security-specialist
/task oauth-integration-mapper
```

### Commands

```bash
/oauth-setup-auth0 [--region us|eu|au]
/oauth-implement [react|nextjs|nodejs|fastapi|django|vue|svelte|flutter|react-native]
/oauth-security-audit [--fix]
/oauth-troubleshoot [issue]
/oauth-migrate [firebase|cognito|okta|keycloak|custom]
```

## Troubleshooting

### Common Issues

**Q: Callback URL mismatch error?**
A: Run `/oauth-troubleshoot callback-mismatch`

**Q: Token expired?**
A: Run `/oauth-troubleshoot token-expired`

**Q: CORS errors when calling API?**
A: Run `/oauth-troubleshoot cors-error`

**Q: Security vulnerabilities found?**
A: Review `/oauth-security-audit` report

**Q: Migrating from another provider?**
A: Run `/oauth-migrate [provider]`

## Best Practices

1. **Always use PKCE** for SPAs and mobile apps
2. **Store tokens in memory** for SPAs (never localStorage)
3. **Use HTTP-only cookies** for server-side apps
4. **Validate tokens** in every API call
5. **Check scopes** for authorization
6. **Rotate refresh tokens** automatically
7. **Keep access tokens short-lived** (5-15 minutes)
8. **Run security audit** before production
9. **Monitor Auth0 logs** regularly
10. **Have rollback plan** ready

## Performance Tips

- Use Auth0 SDK (automatic optimizations)
- Enable token caching (Auth0 handles)
- Use silent authentication for better UX
- Implement exponential backoff for retries
- Monitor token refresh performance

## Support

### Resources
- **Auth0 Documentation**: https://auth0.com/docs
- **Auth0 Community**: https://community.auth0.com
- **Auth0 Support**: https://support.auth0.com
- **RFC 6749 (OAuth 2.0)**: https://tools.ietf.org/html/rfc6749
- **RFC 7636 (PKCE)**: https://tools.ietf.org/html/rfc7636

### Getting Help

1. Run `/oauth-troubleshoot [issue]` for common problems
2. Check Auth0 Dashboard → Logs for error details
3. Review `/oauth-security-audit` for vulnerability guidance
4. Contact Auth0 support for account/service issues

## License

MIT

## Author

**Varaku**
- Email: contact@varaku.com
- GitHub: https://github.com/varaku1012
- Website: https://varaku.com

## Version

**Plugin Version**: 1.0.0
**Auth0 API Support**: v2
**OAuth 2.0 Compliance**: RFC 6749 + RFC 7636 (PKCE)

---

**Status**: ✅ Ready to use
**Next step**: Run `/oauth-setup-auth0` to get started!
