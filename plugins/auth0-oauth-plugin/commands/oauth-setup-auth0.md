---
description: Interactive Auth0 setup wizard for configuring OAuth applications, connections, and tenant settings
---

# Auth0 OAuth Setup Wizard

Interactive guided setup for Auth0 authentication from scratch.

## Quick Start

```bash
/oauth-setup-auth0
```

This will walk you through:
1. **Auth0 Tenant Creation** - Create new Auth0 account/tenant
2. **Application Configuration** - Set up app (SPA, Web, Mobile, M2M)
3. **Connection Setup** - Configure database, social, enterprise login
4. **Callback URL Configuration** - Set up redirect URIs
5. **Basic Security** - Enable MFA, set token expiration
6. **Environment Variables** - Generate .env file template

## Step-by-Step Wizard

### Step 1: Auth0 Tenant Setup

If you don't have an Auth0 account:

1. **Visit**: https://auth0.com/signup
2. **Create account** with:
   - Email: Your business email
   - Password: Strong password
   - Company: Your company name
3. **Choose region**: US, EU, or AU
4. **Create tenant** - Auth0 generates unique domain:
   - Example: `mycompany.auth0.com`

**What you'll get**:
- Auth0 Dashboard access
- Domain: `YOUR_DOMAIN.auth0.com`
- Client ID & Secret for dashboard

---

### Step 2: Select Application Type

**Choose based on your tech stack**:

#### Option 1: Single Page Application (SPA)
**For**: React, Vue, Angular, Svelte, Next.js (client-side)

**Characteristics**:
- Code runs in browser
- Public client (no secret needed)
- OAuth Flow: Authorization Code + PKCE
- Token Storage: In-memory (secure)

**Setup**:
```
Auth0 Dashboard → Applications → Create Application
Name: My React App
Type: Single Page Application

Settings:
- Allowed Callback URLs: http://localhost:3000/callback
- Allowed Logout URLs: http://localhost:3000
- Allowed Web Origins: http://localhost:3000
- Token Endpoint Authentication: None
```

#### Option 2: Web Application (Server-Side)
**For**: Next.js, Express, Django, Rails (with server)

**Characteristics**:
- Code runs on server
- Confidential client (has secret)
- OAuth Flow: Authorization Code (no PKCE needed)
- Token Storage: HTTP-only cookies

**Setup**:
```
Auth0 Dashboard → Applications → Create Application
Name: My Next.js App
Type: Regular Web Applications

Settings:
- Allowed Callback URLs: http://localhost:3000/api/auth/callback
- Allowed Logout URLs: http://localhost:3000
- Token Endpoint Authentication: Post
- Secret: [Auto-generated, copy to .env]
```

#### Option 3: Machine-to-Machine (M2M)
**For**: Backend services, scheduled jobs, CLI tools

**Characteristics**:
- No user interaction
- Confidential client
- OAuth Flow: Client Credentials
- Use Case: Calling Auth0 Management API

**Setup**:
```
Auth0 Dashboard → Applications → Create Application
Name: My Backend Service
Type: Machine-to-Machine Applications

Settings:
- Grant Types: client_credentials
- Audience: https://YOUR_DOMAIN/api/v2/
- Secret: [Auto-generated, copy to .env]
```

#### Option 4: Native Application
**For**: iOS, Android, React Native apps

**Characteristics**:
- Runs on device
- Public client (no secret)
- OAuth Flow: Authorization Code + PKCE
- Callback: Custom URL scheme or App Link

**Setup**:
```
Auth0 Dashboard → Applications → Create Application
Name: My Mobile App
Type: Native

Settings:
- Allowed Callback URLs: com.myapp://callback
- Allowed Logout URLs: com.myapp://logout
- Token Endpoint Authentication: None
```

---

### Step 3: Configure Connections

Choose how users authenticate:

#### Option 1: Username/Password Database
**Built-in Auth0 database**

**Enable**:
```
Auth0 Dashboard → Connections → Database → Username-Password-Authentication

Settings:
- Allow Signup: Yes (if you want user self-registration)
- Require Email Verification: Yes
- Password Policy: Good (mixed case, numbers, symbols)
- Disable signup for: [Your application]
```

**Usage**:
```
Users can sign up at: YOUR_DOMAIN/signup
Or you create users via API
```

---

#### Option 2: Social Connections
**Let users login with Google, GitHub, etc.**

##### Google OAuth Setup

1. **Create Google Cloud project**:
   - Visit: https://console.cloud.google.com
   - Create new project: "My App Auth"
   - Enable Google+ API

2. **Create OAuth credentials**:
   - APIs & Services → Credentials → Create OAuth 2.0 Client ID
   - Authorized redirect URIs:
     - `https://YOUR_DOMAIN/login/callback`
     - `https://YOUR_DOMAIN/login/callback?connection=google-oauth2`
   - Copy: Client ID and Client Secret

3. **Add to Auth0**:
   ```
   Auth0 Dashboard → Connections → Social → Google

   Client ID: [Paste from Google Cloud]
   Client Secret: [Paste from Google Cloud]

   Enable for: [Your application]
   ```

##### GitHub OAuth Setup

1. **Create GitHub OAuth App**:
   - Visit: https://github.com/settings/developers
   - Register new OAuth application
   - Authorization callback URL:
     - `https://YOUR_DOMAIN/login/callback`
   - Copy: Client ID and Client Secret

2. **Add to Auth0**:
   ```
   Auth0 Dashboard → Connections → Social → GitHub

   Client ID: [Paste from GitHub]
   Client Secret: [Paste from GitHub]

   Enable for: [Your application]
   ```

---

#### Option 3: Enterprise Connections (Active Directory/LDAP)
**For company employees using company email**

**Setup Active Directory**:
```
Auth0 Dashboard → Connections → Enterprise → Active Directory/LDAP

Name: Company AD
LDAP URL: ldap://ad.company.com:389
Bind DN: admin@company.com
Bind Password: [AD admin password]
Base DN: cn=users,dc=company,dc=com

Mapping:
- Email: mail
- Name: displayName
- Username: sAMAccountName

Enable for: [Your application]
```

**Result**: Users can login with company credentials, no password duplication

---

### Step 4: Create API

If your frontend needs to call protected APIs:

```
Auth0 Dashboard → APIs → Create API

Name: My API
Identifier: https://api.myapp.com
Signing Algorithm: RS256

Scopes:
+ read:items (Read access to items)
+ write:items (Write access to items)
+ delete:items (Delete items)
+ admin (Full admin access)
```

**Usage in App**:
```typescript
// Request these scopes during login
Auth0Provider({
  authorizationParams: {
    scope: 'openid profile email read:items write:items'
  }
})

// Access token will include these scopes
// Backend validates scopes before allowing access
```

---

### Step 5: Basic Security Configuration

#### Enable Multi-Factor Authentication (MFA)

```
Auth0 Dashboard → Connections → Authenticators

Enable:
- Google Authenticator ✅
- SMS (optional)
- Email OTP

For application:
- Require MFA: Yes / No / Per-user rule
```

**Optional**: Require MFA for certain users:
```javascript
// Auth0 Rule: Enforce MFA for admin users
module.exports = function(user, context, callback) {
  if (user.email.endsWith('@admin.company.com')) {
    context.multifactor = {
      provider: 'google-authenticator',
      allowRememberBrowser: false
    }
  }
  callback(null, user, context)
}
```

---

#### Set Token Expiration

```
Auth0 Dashboard → Applications → Settings → Advanced

Token Settings:
- ID Token Expiration: 36000 (10 hours)
- Access Token Expiration: 600 (10 minutes) ← IMPORTANT
- Refresh Token Expiration: 2592000 (30 days)
- Refresh Token Rotation: Enabled ✅
```

**Why short access token?**
- If leaked, attacker has limited time window
- Refresh tokens can be rotated automatically
- Best practice: 5-15 minutes

---

#### Enable HTTPS for Callback URLs

```
Auth0 Dashboard → Applications → Settings

Allowed Callback URLs:
- Production: https://myapp.com/callback ✅
- Staging: https://staging.myapp.com/callback ✅
- Local dev: http://localhost:3000/callback (only for dev)

Allowed Logout URLs:
- Production: https://myapp.com ✅
- Staging: https://staging.myapp.com ✅
- Local dev: http://localhost:3000 (only for dev)
```

---

### Step 6: Generate Environment Variables

Based on your setup, create `.env.local`:

```env
# Auth0 Configuration
AUTH0_DOMAIN=YOUR_DOMAIN.auth0.com
AUTH0_CLIENT_ID=YOUR_CLIENT_ID
AUTH0_CLIENT_SECRET=YOUR_CLIENT_SECRET
AUTH0_CALLBACK_URL=http://localhost:3000/callback

# For Next.js
AUTH0_BASE_URL=http://localhost:3000
AUTH0_SECRET=use [node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"]

# For APIs
AUTH0_AUDIENCE=https://api.myapp.com
AUTH0_SCOPE=openid profile email read:items

# API Configuration
API_URL=http://localhost:3001
```

---

## Quick Reference

### URLs to Save

- **Auth0 Dashboard**: https://manage.auth0.com
- **Your Tenant**: https://YOUR_DOMAIN.auth0.com
- **Login Page**: https://YOUR_DOMAIN.auth0.com/login

### Common Task Commands

**View users**:
```
Auth0 Dashboard → User Management → Users
```

**View logs**:
```
Auth0 Dashboard → Logs (Real-time logs of auth events)
```

**View rules**:
```
Auth0 Dashboard → Rules (Custom logic for auth flow)
```

**Reset user password**:
```
Auth0 Dashboard → Users → Select user → Actions → Reset password
```

---

## Verification Checklist

- [ ] Auth0 tenant created
- [ ] Application configured (SPA/Web/M2M/Native)
- [ ] Callback URLs set (http://localhost:3000/callback)
- [ ] Logout URLs set (http://localhost:3000)
- [ ] Connection enabled (Database/Google/GitHub/AD)
- [ ] API created with scopes
- [ ] MFA configured
- [ ] Token expiration set (10 min for access tokens)
- [ ] Environment variables generated
- [ ] Test login from Auth0 dashboard works

---

## Next Steps

After setup completes:

1. **Install SDK for your framework**:
   - React: `/oauth-implement react`
   - Next.js: `/oauth-implement nextjs`
   - Node.js: `/oauth-implement nodejs`

2. **Run security audit**:
   - `/oauth-security-audit`

3. **Test your implementation**:
   - Try login flow
   - Check token in browser dev tools
   - Verify API access

4. **Deploy to production**:
   - Update callback URLs to production domain
   - Update environment variables
   - Enable HTTPS everywhere
   - Consider Auth0 compliance (GDPR, HIPAA, SOC2)

---

## Troubleshooting

**Q: Callback URL mismatch error?**
A: Ensure your callback URL in Auth0 exactly matches redirect_uri in your app (including http/https and port)

**Q: Connection not showing in login?**
A: Check that connection is enabled for your application (Connections → Select connection → Applications toggle)

**Q: Can't create users via signup?**
A: Ensure "Allow Signup" is enabled in Database connection settings

**Q: Users can't login with social connection?**
A: Verify social connection is enabled for your application

---

**Status**: Setup wizard complete!
**Next command**: `/oauth-implement [framework]` to add auth to your app
