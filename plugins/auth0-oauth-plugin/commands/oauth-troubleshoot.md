---
description: Troubleshooting guide for common Auth0 OAuth issues
---

# OAuth Troubleshooting Guide

Solutions for common Auth0 OAuth problems.

## Quick Start

```bash
/oauth-troubleshoot [issue]
```

Common issues:
- `callback-mismatch` - Callback URL doesn't match
- `token-expired` - Access token expired
- `cors-error` - CORS error when calling API
- `silent-auth` - Silent authentication not working
- `scope-error` - Scope not in token
- `mfa-required` - MFA login failing
- `logout-not-clearing` - Session not cleared on logout
- `social-login-fails` - Social login buttons not working

---

## Issue: Callback URL Mismatch

**Error**: "Unable to process redirect request" or "Invalid redirect_uri"

**Cause**: Redirect URL in Auth0 doesn't match your app's callback URL

**Solution**:

1. **Check your app's callback URL**:
   ```typescript
   // React
   <Auth0Provider
     authorizationParams={{
       redirect_uri: window.location.origin + '/callback'
     }}
   >

   // Next.js
   AUTH0_CALLBACK_URL=http://localhost:3000/api/auth/callback
   ```

2. **Update Auth0 Dashboard**:
   ```
   Auth0 Dashboard → Applications → Your App → Settings

   Allowed Callback URLs:
   http://localhost:3000/callback
   OR
   http://localhost:3000/api/auth/callback

   (Must EXACTLY match your app!)
   ```

3. **Common mistakes**:
   - Including query params: `/callback?foo=bar` (wrong!)
   - Using `http://` vs `https://`
   - Port number mismatch: `:3000` vs `:3001`
   - Missing trailing slash inconsistency

4. **Test**:
   ```bash
   # Verify URL matches exactly
   echo "App uses: window.location.origin + '/callback'"
   echo "Current: $CALLBACK_URL"
   ```

---

## Issue: Access Token Expired

**Error**: API returns 401 Unauthorized

**Cause**: Access token expired (default 10 minutes)

**Solution**:

1. **Use Auth0 SDK (auto-refresh)**:
   ```typescript
   // React
   const { getAccessTokenSilently } = useAuth0()
   const token = await getAccessTokenSilently()  // Auto-refreshes if expired

   // Next.js
   const session = await getSession()  // SDK handles refresh
   const token = session.accessToken
   ```

2. **Verify token expiration**:
   ```
   Auth0 Dashboard → Applications → Settings → Token Expiration

   Should be: 600 (10 minutes)
   Refresh Token Expiration: 2592000 (30 days)
   Refresh Token Rotation: Enabled ✅
   ```

3. **Manual refresh (if needed)**:
   ```typescript
   async function getRefreshToken() {
     const response = await fetch(`https://${AUTH0_DOMAIN}/oauth/token`, {
       method: 'POST',
       headers: { 'Content-Type': 'application/json' },
       body: JSON.stringify({
         client_id: CLIENT_ID,
         client_secret: CLIENT_SECRET,
         refresh_token: refreshToken,
         grant_type: 'refresh_token'
       })
     })

     const { access_token } = await response.json()
     return access_token
   }
   ```

4. **Test**:
   ```bash
   # Decode token to check expiration
   # Visit https://jwt.io and paste your access token
   # Look at "exp" claim (Unix timestamp)
   ```

---

## Issue: CORS Error Calling API

**Error**: "Access to XMLHttpRequest blocked by CORS policy"

**Cause 1**: Backend CORS not configured for frontend origin

**Solution 1** (Express/Node.js):

```typescript
import cors from 'cors'

// Allow specific origins
app.use(cors({
  origin: ['http://localhost:3000', 'https://myapp.com'],
  credentials: true  // Important for cookies
}))

// Or check origin dynamically
app.use(cors({
  origin: function(origin, callback) {
    if (ALLOWED_ORIGINS.includes(origin)) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  }
}))
```

**Cause 2**: Auth0 domain not in allowed origins

**Solution 2** (Auth0 Dashboard):

```
Auth0 Dashboard → Applications → Settings

Allowed Web Origins:
http://localhost:3000    (for development)
https://myapp.com        (for production)

(Allows Auth0 calls from these origins)
```

**Cause 3**: Missing credentials in request

**Solution 3**:

```typescript
// Make sure credentials are included
fetch('/api/items', {
  headers: { Authorization: `Bearer ${token}` },
  credentials: 'include'  // Important for cookies
})
```

**Test**:
```bash
# Test CORS
curl -H "Origin: http://localhost:3000" \
  -H "Access-Control-Request-Method: GET" \
  http://localhost:3001/api/items

# Should include Access-Control-Allow-Origin header
```

---

## Issue: Silent Authentication Fails

**Error**: Silent auth not working, user must login again

**Cause 1**: Cache location wrong

**Solution 1**:

```typescript
// WRONG ❌
new Auth0Provider({
  cacheLocation: 'localStorage'  // Can't do silent auth in localStorage
})

// RIGHT ✅
new Auth0Provider({
  cacheLocation: 'memory'  // For SPAs
})
```

**Cause 2**: Refresh token not rotated

**Solution 2**:

```
Auth0 Dashboard → Applications → Settings

Refresh Token Rotation: Enabled ✅
Refresh Token Expiration Absolute: 2592000 (30 days)
```

**Cause 3**: Third-party cookies blocked

**Solution 3** (for local development):

```
Browser → Settings → Privacy → Cookies
Allow cookies (at least for localhost)
```

**Test**:
```typescript
// Test silent auth
async function testSilentAuth() {
  const token = await getAccessTokenSilently()
  console.log('Silent auth worked:', token)
}
```

---

## Issue: Scope Not in Token

**Error**: Token doesn't include required scope

**Cause 1**: Scope not requested during login

**Solution 1**:

```typescript
// WRONG ❌
Auth0Provider({
  // No scope specified
})

// RIGHT ✅
Auth0Provider({
  authorizationParams: {
    scope: 'openid profile email read:items write:items'
  }
})
```

**Cause 2**: Scope not configured in Auth0

**Solution 2**:

```
Auth0 Dashboard → APIs → Your API → Scopes

Add:
+ read:items (Read access)
+ write:items (Write access)
+ delete:items (Delete access)
```

**Cause 3**: User not consented to scope

**Solution 3**:

```
Auth0 Dashboard → Connections → Settings

Require consent: Off (for internal apps)
Or allow user to accept scopes during login
```

**Test**:
```javascript
// Decode token to check scopes
const decoded = jwt_decode(token)
console.log('Scopes:', decoded.scope)
```

---

## Issue: MFA Login Failing

**Error**: "MFA is required" but MFA setup failed

**Cause 1**: MFA not configured

**Solution 1**:

```
Auth0 Dashboard → Connections → Authenticators

Enable:
✓ Google Authenticator
✓ SMS (optional)
✓ Email OTP

Require MFA: Off/On (depending on policy)
```

**Cause 2**: User hasn't set up MFA method

**Solution 2**:

```
Users must register MFA before login:
1. First login (without MFA)
2. Prompted to set up authenticator
3. Scan QR code or enter backup codes
4. Subsequent logins require MFA
```

**Cause 3**: Recovery codes not working

**Solution 3**:

```
If user loses authenticator:
1. User clicks "Can't scan?"
2. Gets backup codes
3. Use one code to login
4. Setup new authenticator

Or admin can reset MFA:
Auth0 Dashboard → Users → Select user → Actions → Reset authenticators
```

**Test**:
```bash
# Test MFA flow
# 1. Enable MFA in Auth0
# 2. Create test user
# 3. Login → should prompt for authenticator setup
```

---

## Issue: Logout Not Clearing Session

**Error**: User clicks logout but remains logged in

**Cause 1**: Wrong logout URL

**Solution 1** (React):

```typescript
// WRONG ❌
logout()  // Doesn't redirect or clear Auth0 session

// RIGHT ✅
logout({
  logoutParams: {
    returnTo: window.location.origin  // Redirect after logout
  }
})
```

**Cause 2**: Logout URL not in Auth0 allowlist

**Solution 2**:

```
Auth0 Dashboard → Applications → Settings

Allowed Logout URLs:
http://localhost:3000
https://myapp.com

(Must match where user is redirected after logout)
```

**Cause 3**: Session still active server-side

**Solution 3** (Next.js):

```typescript
// API route for logout
export default async function handler(req, res) {
  await clearSession(res)  // Auth0 SDK clears session
  res.redirect('/')
}

// Or explicitly
import { getSession } from '@auth0/nextjs-auth0'

export const GET = async (req) => {
  const session = await getSession()
  if (session) {
    await logout(req)  // Clears Auth0 session
  }
}
```

**Test**:
```bash
# Test logout
# 1. Login successfully
# 2. Click logout
# 3. Check:
#    - Redirected to home
#    - Cookies cleared
#    - New login required
```

---

## Issue: Social Login Not Working

**Error**: Social login button doesn't work or redirects to error

**Cause 1**: Social connection not enabled for app

**Solution 1**:

```
Auth0 Dashboard → Connections → Social → Google

Under "Select Applications":
Toggle: Your App → Enable ✅

(Same for Facebook, GitHub, etc.)
```

**Cause 2**: Social app credentials wrong

**Solution 2** (Google example):

```
Auth0 Dashboard → Connections → Social → Google

Google OAuth2 settings:
Client ID: __________ (from Google Cloud Console)
Client Secret: __________ (from Google Cloud Console)

Get credentials:
1. Google Cloud Console: https://console.cloud.google.com
2. Create new project
3. Enable Google+ API
4. Create OAuth 2.0 Client ID
5. Copy Client ID and Secret to Auth0
```

**Cause 3**: Redirect URI not configured in social app

**Solution 3**:

```
Google Cloud Console:
Authorized redirect URIs:
https://YOUR_DOMAIN/login/callback

Facebook App Settings:
Valid OAuth Redirect URIs:
https://YOUR_DOMAIN/login/callback

GitHub:
Authorization callback URL:
https://YOUR_DOMAIN/login/callback
```

**Test**:
```bash
# Test social login
# 1. Visit login page
# 2. Click "Login with Google"
# 3. Should redirect to Google
# 4. After signin, should return to app
```

---

## General Debugging Techniques

### 1. Check Auth0 Logs

```
Auth0 Dashboard → Logs

Shows all auth events with:
- User email
- Event type (login, logout, error)
- Timestamp
- Error details
```

### 2. Inspect Token

```javascript
// In browser console
const token = await auth0.getAccessTokenSilently()

// Decode at jwt.io
// Or programmatically
import jwt_decode from 'jwt-decode'
const decoded = jwt_decode(token)
console.log(decoded)
```

### 3. Check Request Headers

```bash
# In browser DevTools → Network tab
# Select API request
# Check headers:
#   Authorization: Bearer {token}
#   Content-Type: application/json
```

### 4. Enable Debug Mode

```typescript
// React
<Auth0Provider
  domain={domain}
  clientId={clientId}
  logoutParams={{ returnTo: 'http://localhost:3000' }}
  onError={(error) => console.error('Auth0 Error:', error)}
>
```

---

## Still Having Issues?

1. **Check Auth0 Logs**: Auth0 Dashboard → Logs (shows actual errors)
2. **Run security audit**: `/oauth-security-audit`
3. **Review implementation**: `/oauth-implement [framework]`
4. **Check Auth0 docs**: https://auth0.com/docs
5. **Contact support**: https://support.auth0.com

---

**Status**: Troubleshooting guide ready!
