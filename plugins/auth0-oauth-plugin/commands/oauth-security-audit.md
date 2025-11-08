---
description: Security audit checklist for Auth0 OAuth implementation
---

# OAuth Security Audit

Run a comprehensive security audit on your Auth0 implementation.

## Quick Start

```bash
/oauth-security-audit
```

This will check:
- Token security (storage, expiration, rotation)
- OAuth flow security (PKCE, state parameter, CSRF)
- Compliance (GDPR, HIPAA, SOC2)
- Configuration hardening
- Common vulnerabilities

---

## Security Checklist

### Frontend Security

- [ ] **Token Storage**: In-memory or HTTP-only cookies only (NO localStorage)
  - Check: `grep -r "localStorage.*token" src/`
  - Should be empty

- [ ] **PKCE Enabled**: For SPAs (Authorization Code + PKCE)
  - Check: Auth0 React SDK handles automatically ✅
  - Or verify custom code includes `code_verifier`

- [ ] **State Parameter**: CSRF protection
  - Check: Auth0 SDKs handle automatically ✅
  - Or verify `state` parameter in custom auth flow

- [ ] **HTTPS Enforced**: All auth requests over HTTPS
  - Check: No `http://` in production callback URLs
  - Production callback URLs use `https://`

- [ ] **Token Expiration Short**: Access tokens < 15 minutes
  - Check: Auth0 Dashboard → Applications → Settings → Token Expiration
  - Should be: 300-900 seconds (5-15 minutes)

- [ ] **Refresh Token Rotation**: Enabled for token refresh
  - Check: Auth0 Dashboard → Applications → Settings → Refresh Token Rotation
  - Should be: Enabled ✅

- [ ] **Content Security Policy (CSP)**: Restrict script sources
  - Check: HTTP header `Content-Security-Policy`
  - Should include: `default-src 'self'`

---

### Backend Security

- [ ] **JWT Signature Validation**: Verify token signature
  - Check: Code uses `jwt.verify()` with public key
  - Should NOT use: `jwt.decode()` (no verification)

- [ ] **Audience Validation**: Check `aud` claim matches API
  - Check: `jwt.verify(token, key, { audience: 'https://api.example.com' })`
  - Token `aud` must match expected audience

- [ ] **Issuer Validation**: Check `iss` claim matches Auth0 domain
  - Check: `jwt.verify(token, key, { issuer: 'https://YOUR_DOMAIN/' })`
  - Token `iss` must match Auth0 domain

- [ ] **Algorithm Validation**: Only RS256 (asymmetric)
  - Check: `jwt.verify(token, key, { algorithms: ['RS256'] })`
  - Should NOT allow: `HS256` (symmetric, security risk)

- [ ] **Scope Validation**: Check scopes for authorization
  - Check: Code validates `token.scope` includes required scope
  - Example: `if (!scopes.includes('delete:items')) return 403`

- [ ] **No Token in Logs**: Sensitive tokens not logged
  - Check: `grep -r "token\|password\|secret" logs/`
  - Should be: Sanitized or empty

- [ ] **CORS Configured Properly**: Only allow trusted origins
  - Check: `app.use(cors({ origin: ['https://myapp.com'] }))`
  - Should NOT be: `origin: '*'` (allows any origin)

---

### Auth0 Configuration Security

- [ ] **MFA Enabled**: Multi-factor authentication required
  - Check: Auth0 Dashboard → Connections → Authenticators
  - Should have: Google Authenticator, SMS, or Email OTP enabled

- [ ] **Password Policy**: Strong passwords required
  - Check: Auth0 Dashboard → Connections → Database → Password Policy
  - Should be: "Good" or "Excellent"

- [ ] **Suspicious Activity Detection**: Enabled
  - Check: Auth0 Dashboard → Security → Attack Protection
  - Should have: Brute force, suspicious IP protection enabled

- [ ] **Logout Clears Session**: User properly logged out
  - Check: `/api/auth/logout` clears all session data
  - Should have: `logoutParams: { returnTo: safe_url }`

- [ ] **No Overpermissioned Scopes**: Only request necessary scopes
  - Check: Auth0 Dashboard → Applications → Settings → Default Audience
  - Should be: Minimal (e.g., `openid profile email`)

- [ ] **API Keys Secure**: Secrets not in version control
  - Check: `.env` is in `.gitignore` ✅
  - Should NOT be in: `git log`, `public files`, `comments`

- [ ] **Rules/Actions Audited**: Custom logic secure
  - Check: Auth0 Dashboard → Rules → [Review each rule]
  - Should NOT: Grant extra permissions, log passwords, call untrusted APIs

---

### Data Protection & Compliance

- [ ] **GDPR Compliant**: User consent, deletion, portability
  - [ ] Consent shown before social login
  - [ ] User can request data deletion (via API or form)
  - [ ] Data deletion implemented (removes from Auth0 + your DB)
  - [ ] Privacy policy links from login page

- [ ] **HIPAA Compliant**: (if handling health data)
  - [ ] Business Associate Agreement (BAA) signed with Auth0
  - [ ] MFA enforced
  - [ ] Audit logging enabled
  - [ ] Data encrypted in transit (HTTPS) and at rest

- [ ] **SOC2 Compliant**: If required for compliance
  - [ ] Change logs available (Auth0 Logs)
  - [ ] Access controls documented
  - [ ] Incident response plan in place
  - [ ] Regular security assessments done

- [ ] **Data Residency**: Data stored in correct region
  - Check: Auth0 Dashboard → Tenants → Region
  - EU apps: Select "Europe" region
  - US apps: Select "United States" region

---

### Error Handling & Logging

- [ ] **Errors Don't Leak Info**: Auth errors are generic
  - Check: Error messages in UI
  - Should be: "Login failed" (NOT "Email doesn't exist" or "Invalid password")

- [ ] **Webhook Errors Handled**: Failures don't break auth flow
  - Check: Webhook error handler has try/catch
  - Should have: Retry logic with exponential backoff

- [ ] **Audit Logs Enabled**: All auth events logged
  - Check: Auth0 Dashboard → Logs (shows all login events)
  - Should have: 100+ entries with timestamps

- [ ] **Sensitive Data Redacted**: Logs don't contain secrets
  - Check: grep -r "password\|token\|secret" logs/
  - Should be: Redacted or not logged

---

### Testing

- [ ] **Unit Tests**: Auth components tested
  - Check: `npm test` includes auth tests
  - Should have: Mock Auth0, test protected routes

- [ ] **Integration Tests**: Auth flow tested end-to-end
  - Check: Test login → callback → API call
  - Should verify: Token exchange, API access

- [ ] **Security Tests**: Vulnerabilities tested
  - [ ] Test expired token handling
  - [ ] Test invalid token rejection
  - [ ] Test missing scope error (403)
  - [ ] Test logout clears session

---

## Security Scoring

**Count your checkmarks**:

- 40+ checked: ✅ **Excellent** (Production ready)
- 30-39 checked: ⚠️ **Good** (Address medium priority items)
- 20-29 checked: ❌ **Fair** (Address high priority items)
- <20 checked: 🚨 **Critical** (Major issues, don't deploy)

---

## Common Vulnerabilities to Fix

### 1. Token Leakage (Critical)

```javascript
// WRONG ❌
localStorage.setItem('token', accessToken)
sessionStorage.setItem('token', accessToken)

// RIGHT ✅
// Use Auth0 SDK (in-memory storage)
// Or for Next.js (HTTP-only cookies)
```

### 2. Missing PKCE (High)

```javascript
// WRONG ❌
// No code_verifier or code_challenge

// RIGHT ✅
// Use Auth0 React SDK (automatic PKCE)
// Or custom: include code_verifier in token exchange
```

### 3. Wrong Token Type (High)

```javascript
// WRONG ❌
const idToken = getIDToken()
fetch('/api/items', {
  headers: { Authorization: `Bearer ${idToken}` }
})

// RIGHT ✅
const accessToken = getAccessToken()
fetch('/api/items', {
  headers: { Authorization: `Bearer ${accessToken}` }
})
```

### 4. No Audience Validation (High)

```typescript
// WRONG ❌
jwt.verify(token, publicKey)  // No audience check

// RIGHT ✅
jwt.verify(token, publicKey, {
  audience: 'https://api.myapp.com'
})
```

### 5. Scope Not Checked (Medium)

```typescript
// WRONG ❌
app.delete('/items/:id', checkJwt, (req, res) => {
  // Delete without scope check
  res.json({ deleted: true })
})

// RIGHT ✅
app.delete('/items/:id', checkJwt, (req, res) => {
  const scopes = req.auth.scope?.split(' ') || []
  if (!scopes.includes('delete:items')) {
    return res.status(403).json({ error: 'Insufficient permissions' })
  }
  res.json({ deleted: true })
})
```

---

## Remediation Priority

### Priority 1 (Fix immediately - before production)
- [ ] Token storage (localStorage → in-memory)
- [ ] JWT signature validation
- [ ] Audience validation
- [ ] HTTPS enforced

### Priority 2 (Fix within 1 week)
- [ ] Scope validation in API
- [ ] MFA enabled
- [ ] Audit logging
- [ ] CSRF protection (state parameter)

### Priority 3 (Fix within 1 month)
- [ ] Compliance (GDPR, HIPAA)
- [ ] Webhook error handling
- [ ] Security testing
- [ ] Incident response plan

---

## Next Steps

1. **Review this checklist** with your team
2. **Fix high-priority items** (Priority 1)
3. **Run again**: `/oauth-security-audit`
4. **If issues remain**: `/oauth-troubleshoot` for help

---

**Score**: [X] / 45 items checked
