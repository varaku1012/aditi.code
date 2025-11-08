---
description: Migration guide for moving from other auth providers to Auth0
---

# OAuth Migration Guide

Migrate from other authentication providers to Auth0.

## Quick Start

```bash
/oauth-migrate [provider]
```

Supported providers:
- `firebase` - Firebase Authentication
- `okta` - Okta
- `cognito` - AWS Cognito
- `keycloak` - Keycloak
- `custom` - Custom JWT/OAuth implementation
- `social-only` - Only social logins (no user DB)

---

## Migration: Firebase → Auth0

### Phase 1: Planning (1-2 hours)

**Assess current setup**:
- How many users? (1k, 100k, 1M+)
- Authentication methods? (email/password, social, custom)
- Custom claims? (roles, metadata)
- Token usage? (access tokens, ID tokens)

**Timeline**:
- Small (1k users): 1 day
- Medium (10k users): 3-5 days
- Large (100k+ users): 1-2 weeks

**Parallel running** (recommended):
- Keep Firebase running while testing Auth0
- Gradual migration: 10% → 25% → 50% → 100%
- Rollback plan: If Auth0 issues, fall back to Firebase

---

### Phase 2: Set Up Auth0 (1-2 hours)

```bash
# Step 1: Create Auth0 account
# https://auth0.com/signup

# Step 2: Create application
/oauth-setup-auth0

# Step 3: Configure connections
# - Enable database connection
# - Enable same social connections as Firebase
# - Copy social app credentials from Firebase
```

---

### Phase 3: User Migration (1-3 days)

#### Option A: Automatic Migration (Recommended)

Use Auth0 extensibility to migrate users on first login:

```javascript
// Auth0 Rule: Migrate users from Firebase
module.exports = function(user, context, callback) {
  // Check if user already in Auth0
  if (user.identities && user.identities.length > 0) {
    return callback(null, user, context)
  }

  // Try to authenticate against Firebase
  const firebase = require('firebase')

  firebase.initializeApp({
    apiKey: process.env.FIREBASE_API_KEY,
    authDomain: process.env.FIREBASE_AUTH_DOMAIN,
    databaseURL: process.env.FIREBASE_DATABASE_URL
  })

  firebase.auth().signInWithEmailAndPassword(user.email, context.request.query.password)
    .then(function(firebaseUser) {
      // Get Firebase custom claims
      firebaseUser.getIdTokenResult()
        .then(function(idTokenResult) {
          // Copy Firebase claims to Auth0
          user.app_metadata = user.app_metadata || {}
          user.app_metadata.firebase_id = firebaseUser.uid
          user.app_metadata.roles = idTokenResult.claims.roles || []

          // Create Auth0 user
          context.clientMetadata = {
            firebase_migrated: 'true'
          }

          callback(null, user, context)
        })
    })
    .catch(function(error) {
      callback(new Error('Firebase auth failed: ' + error.message))
    })
}
```

**Benefits**:
- ✅ No downtime
- ✅ Users migrate automatically on first login
- ✅ Can run parallel with Firebase
- ✅ Easy rollback

**Timeline**: 2-3 weeks (let users naturally migrate)

---

#### Option B: Bulk Migration

Export Firebase users and import to Auth0:

```bash
# Step 1: Export users from Firebase
firebase auth:export users.json --format json

# Step 2: Transform to Auth0 format
node transform-firebase-to-auth0.js

# Step 3: Import to Auth0
# Auth0 Dashboard → Users → Import (drag CSV)
# Or use Management API
```

**transform-firebase-to-auth0.js**:
```javascript
const fs = require('fs')

const firebaseUsers = JSON.parse(fs.readFileSync('users.json', 'utf8'))

const auth0Users = firebaseUsers.users.map(user => ({
  email: user.email,
  email_verified: user.emailVerified,
  user_id: user.localId,
  identities: [{
    connection: 'Username-Password-Authentication',
    user_id: user.localId,
    provider: 'auth0',
    isSocial: false
  }],
  user_metadata: user.customClaims || {},
  app_metadata: {
    roles: user.customClaims?.roles || [],
    firebase_id: user.localId
  },
  blocked: !user.emailVerified,
  created_at: new Date(parseInt(user.createdAt)).toISOString(),
  updated_at: new Date(parseInt(user.lastLoginAt)).toISOString()
}))

fs.writeFileSync('auth0-users.json', JSON.stringify(auth0Users, null, 2))
console.log(`Converted ${auth0Users.length} users`)
```

**Timeline**: 1-2 hours (bulk import) + verification

---

### Phase 4: Update Application Code (2-4 hours)

#### Frontend Migration (React)

```typescript
// BEFORE (Firebase)
import { initializeApp } from 'firebase/app'
import { getAuth, signInWithEmailAndPassword } from 'firebase/auth'

const app = initializeApp(firebaseConfig)
const auth = getAuth(app)

async function login(email, password) {
  const userCredential = await signInWithEmailAndPassword(auth, email, password)
  const token = await userCredential.user.getIdToken()
  return token
}

// AFTER (Auth0)
import { useAuth0 } from '@auth0/auth0-react'

function LoginPage() {
  const { loginWithRedirect } = useAuth0()

  return (
    <button onClick={() => loginWithRedirect()}>
      Login with Auth0
    </button>
  )
}

export default function App() {
  const { getAccessTokenSilently } = useAuth0()

  async function getToken() {
    return await getAccessTokenSilently()
  }
}
```

#### Backend Migration (Node.js)

```typescript
// BEFORE (Firebase)
import * as admin from 'firebase-admin'

const app = admin.initializeApp()

function verifyToken(token) {
  return admin.auth().verifyIdToken(token)
}

// AFTER (Auth0)
import { expressjwt } from 'express-jwt'
import jwksRsa from 'jwks-rsa'

const checkJwt = expressjwt({
  secret: jwksRsa.expressJwtSecret({
    jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`
  }),
  audience: `https://${process.env.AUTH0_DOMAIN}/api/v2/`,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256']
})

app.get('/api/protected', checkJwt, (req, res) => {
  res.json({ user: req.auth.sub })
})
```

---

### Phase 5: Testing (1-2 days)

```typescript
// Test list
- [ ] User login (email/password)
- [ ] User signup
- [ ] Social login (Google, GitHub, etc)
- [ ] Password reset
- [ ] Token refresh
- [ ] API access with token
- [ ] MFA (if enabled)
- [ ] Logout clears session
- [ ] Session persistence
- [ ] Error handling (invalid password, etc)
```

**Test script**:
```bash
# Test login flow
curl -X POST https://YOUR_DOMAIN/oauth/token \
  -H "Content-Type: application/json" \
  -d '{
    "client_id": "YOUR_CLIENT_ID",
    "client_secret": "YOUR_CLIENT_SECRET",
    "audience": "https://YOUR_DOMAIN/api/v2/",
    "grant_type": "client_credentials"
  }'

# Test protected API
curl -H "Authorization: Bearer ACCESS_TOKEN" \
  http://localhost:3001/api/protected
```

---

### Phase 6: Deployment (2-4 hours)

**Deployment checklist**:
- [ ] Update environment variables
- [ ] Deploy frontend to staging
- [ ] Deploy backend to staging
- [ ] Run full test suite
- [ ] Smoke test in production-like environment
- [ ] Deploy to production
- [ ] Monitor Auth0 logs for errors
- [ ] Monitor application errors
- [ ] Have rollback plan ready

**Gradual rollout**:
1. Deploy to 10% of users
2. Monitor for 2-4 hours
3. If OK, deploy to 50%
4. Monitor for 2-4 hours
5. Deploy to 100%

---

## Migration: Cognito → Auth0

### Key Differences

| Feature | Cognito | Auth0 |
|---------|---------|-------|
| Setup | AWS Dashboard (complex) | Auth0 Dashboard (simple) |
| Scopes | Fixed scopes | Custom scopes |
| Rules | Limited | Powerful (JavaScript) |
| User management | Via AWS API | Via UI or API |
| Custom claims | userAttributes | app_metadata, user_metadata |
| MFA | Built-in | Multiple options |
| Cost | Pay per user | Fixed tier |

### Migration Steps

1. **Export Cognito users**:
   ```bash
   aws cognito-idp list-users --user-pool-id us-east-1_xxx > cognito-users.json
   ```

2. **Transform to Auth0 format**:
   ```javascript
   // Similar to Firebase migration
   // Map Cognito attributes to Auth0 metadata
   ```

3. **Update token validation**:
   ```typescript
   // Change from Cognito to Auth0 jwks URI
   jwksUri: `https://${AUTH0_DOMAIN}/.well-known/jwks.json`
   ```

4. **Update frontend SDK**:
   ```typescript
   // Replace Amplify with Auth0 SDK
   import { useAuth0 } from '@auth0/auth0-react'
   ```

---

## Rollback Plan

### If issues occur:

1. **Immediately revert** to previous provider
2. **Keep both systems running** during migration
3. **Have database backup** before migration
4. **Monitor error rates** during rollout

```bash
# Revert frontend
git revert <commit>  # Go back to old SDK
npm install         # Reinstall old packages
npm run deploy       # Deploy rollback

# Check status
Auth0 Dashboard → Logs (verify no new logins via Auth0)
Firebase Console → Logs (verify resumed usage)
```

---

## Post-Migration

### Cleanup
- [ ] Decommission old auth system
- [ ] Delete old user data (after retention period)
- [ ] Update documentation
- [ ] Train team on new system
- [ ] Close old auth provider account

### Optimization
- [ ] Review Auth0 rules for performance
- [ ] Optimize token expiration
- [ ] Set up audit logging
- [ ] Monitor costs
- [ ] Plan security hardening

---

## Common Migration Issues

| Issue | Solution |
|-------|----------|
| User exists error on import | Deduplicate by email before import |
| Scopes missing | Manually add to Auth0 API config |
| Custom claims lost | Map to user_metadata in Auth0 |
| Password reset broken | Reconfigure email templates in Auth0 |
| Social login not working | Re-add social app credentials |

---

## Timeline Summary

| Provider | Automatic | Bulk | Total |
|----------|-----------|------|-------|
| Firebase (1k users) | 2-3 weeks | 3-5 days | 1 week |
| Firebase (100k users) | 3-4 weeks | 2-3 weeks | 4-5 weeks |
| Cognito (any size) | 2-3 weeks | Similar to Firebase | 3-5 weeks |
| Custom OAuth (simple) | 1 week | 2-3 days | 1 week |
| Custom OAuth (complex) | 2-3 weeks | 1-2 weeks | 3-4 weeks |

---

## Next Steps

1. **Choose migration strategy** (automatic vs bulk)
2. **Set up Auth0 tenant** (`/oauth-setup-auth0`)
3. **Test integration** (`/oauth-implement [framework]`)
4. **Run security audit** (`/oauth-security-audit`)
5. **Execute migration** (follow phase-by-phase plan)
6. **Monitor closely** during first week

---

**Status**: Migration guide ready!
**Need help?** `/oauth-troubleshoot` or contact Auth0 support
