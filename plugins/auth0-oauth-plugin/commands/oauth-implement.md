---
description: Framework-specific implementation guide for adding Auth0 OAuth to your application
---

# OAuth Implementation Guide

Detailed code walkthrough for implementing Auth0 authentication in your framework.

## Quick Start

```bash
/oauth-implement [framework]
```

Supported frameworks:
- `react` - React with Create React App or Vite
- `nextjs` - Next.js (13+ with App Router recommended)
- `nodejs` - Node.js/Express backend
- `fastapi` - Python FastAPI
- `django` - Python Django
- `vue` - Vue.js
- `svelte` - Svelte
- `flutter` - Flutter mobile
- `react-native` - React Native mobile

## Implementation Steps by Framework

### React (SPA)

#### 1. Install Auth0 React SDK

```bash
npm install @auth0/auth0-react
```

#### 2. Wrap App with Auth0Provider

```typescript
// src/main.tsx
import { Auth0Provider } from '@auth0/auth0-react'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Auth0Provider
    domain={import.meta.env.VITE_AUTH0_DOMAIN}
    clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
    authorizationParams={{
      redirect_uri: window.location.origin,
      scope: 'openid profile email read:items',
      audience: `https://${import.meta.env.VITE_AUTH0_DOMAIN}/api/v2/`
    }}
    cacheLocation="memory"
  >
    <App />
  </Auth0Provider>
)
```

#### 3. Create Login/Logout Components

```typescript
// src/components/Auth.tsx
import { useAuth0 } from '@auth0/auth0-react'

export function LoginButton() {
  const { loginWithRedirect, isAuthenticated } = useAuth0()
  if (isAuthenticated) return null
  return <button onClick={() => loginWithRedirect()}>Login</button>
}

export function LogoutButton() {
  const { logout, isAuthenticated } = useAuth0()
  if (!isAuthenticated) return null
  return <button onClick={() => logout({ logoutParams: { returnTo: window.location.origin } })}>Logout</button>
}

export function Profile() {
  const { user, isAuthenticated } = useAuth0()
  if (!isAuthenticated) return <p>Not logged in</p>
  return (
    <div>
      <img src={user?.picture} alt={user?.name} />
      <h2>{user?.name}</h2>
      <p>{user?.email}</p>
    </div>
  )
}
```

#### 4. Protected Routes

```typescript
// src/components/ProtectedRoute.tsx
import { useAuth0 } from '@auth0/auth0-react'

export function ProtectedRoute({ children }: any) {
  const { isAuthenticated, isLoading } = useAuth0()

  if (isLoading) return <div>Loading...</div>
  if (!isAuthenticated) return <div>Please log in</div>

  return children
}

// In App.tsx
<Routes>
  <Route path="/dashboard" element={<ProtectedRoute><Dashboard /></ProtectedRoute>} />
</Routes>
```

#### 5. Call Protected API

```typescript
// src/hooks/useApi.ts
import { useAuth0 } from '@auth0/auth0-react'
import { useEffect, useState } from 'react'

export function useApi<T>(url: string) {
  const { getAccessTokenSilently } = useAuth0()
  const [data, setData] = useState<T | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    let isMounted = true

    const fetchData = async () => {
      try {
        const token = await getAccessTokenSilently()
        const response = await fetch(url, {
          headers: { Authorization: `Bearer ${token}` }
        })
        if (!response.ok) throw new Error('API error')
        const result = await response.json()
        if (isMounted) setData(result)
      } catch (err) {
        if (isMounted) setError(err instanceof Error ? err : new Error('Unknown error'))
      } finally {
        if (isMounted) setLoading(false)
      }
    }

    fetchData()
    return () => { isMounted = false }
  }, [url, getAccessTokenSilently])

  return { data, error, loading }
}
```

#### 6. Environment Variables

```env
VITE_AUTH0_DOMAIN=YOUR_DOMAIN.auth0.com
VITE_AUTH0_CLIENT_ID=YOUR_CLIENT_ID
```

---

### Next.js (Full-Stack)

#### 1. Install SDK

```bash
npm install @auth0/nextjs-auth0
```

#### 2. Create Auth Routes

**App Router** (Recommended):
```typescript
// app/api/auth/[auth0]/route.ts
import { handleAuth } from '@auth0/nextjs-auth0'

export const GET = handleAuth()
```

**Pages Router**:
```typescript
// pages/api/auth/[auth0].ts
import { handleAuth } from '@auth0/nextjs-auth0'

export default handleAuth()
```

#### 3. Access User in Components

**App Router**:
```typescript
// app/profile/page.tsx
import { getSession } from '@auth0/nextjs-auth0'
import { redirect } from 'next/navigation'

export default async function ProfilePage() {
  const session = await getSession()

  if (!session) {
    redirect('/api/auth/login')
  }

  return (
    <div>
      <h1>Welcome, {session.user.name}</h1>
      <img src={session.user.picture} alt={session.user.name} />
    </div>
  )
}
```

#### 4. Login/Logout Links

```typescript
// app/components/Nav.tsx
import { getSession } from '@auth0/nextjs-auth0'

export async function Nav() {
  const session = await getSession()

  return (
    <nav>
      {session ? (
        <>
          <span>{session.user.name}</span>
          <a href="/api/auth/logout">Logout</a>
        </>
      ) : (
        <a href="/api/auth/login">Login</a>
      )}
    </nav>
  )
}
```

#### 5. Call API with Token

```typescript
// app/api/items/route.ts
import { getSession } from '@auth0/nextjs-auth0'
import { NextResponse } from 'next/server'

export async function GET() {
  const session = await getSession()

  if (!session) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const response = await fetch('http://localhost:3001/items', {
    headers: { Authorization: `Bearer ${session.accessToken}` }
  })

  return NextResponse.json(await response.json())
}
```

#### 6. Environment Variables

```env
AUTH0_SECRET='[generated secret]'
AUTH0_BASE_URL='http://localhost:3000'
AUTH0_ISSUER_BASE_URL='https://YOUR_DOMAIN.auth0.com'
AUTH0_CLIENT_ID='YOUR_CLIENT_ID'
AUTH0_CLIENT_SECRET='YOUR_CLIENT_SECRET'
```

---

### Node.js/Express Backend

#### 1. Install Dependencies

```bash
npm install express-jwt jwks-rsa
```

#### 2. Create JWT Middleware

```typescript
// middleware/auth.ts
import { expressjwt as jwt } from 'express-jwt'
import jwksRsa from 'jwks-rsa'

const checkJwt = jwt({
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`
  }),
  audience: `https://${process.env.AUTH0_DOMAIN}/api/v2/`,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256']
})

export default checkJwt
```

#### 3. Protect Routes

```typescript
// routes/items.ts
import express from 'express'
import checkJwt from '../middleware/auth'

const router = express.Router()

router.get('/public', (req, res) => {
  res.json({ message: 'Public' })
})

router.get('/items', checkJwt, (req, res) => {
  // req.auth contains decoded JWT
  res.json({ userId: req.auth.sub, items: [] })
})

// Scope validation
router.delete('/items/:id', checkJwt, (req, res) => {
  const scope = req.auth.scope?.split(' ') || []

  if (!scope.includes('delete:items')) {
    return res.status(403).json({ error: 'Insufficient permissions' })
  }

  res.json({ message: 'Item deleted' })
})

export default router
```

---

### FastAPI (Python)

```python
# main.py
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthCredentials
import jwt
from jwt import algorithms

app = FastAPI()
security = HTTPBearer()

DOMAIN = "YOUR_DOMAIN.auth0.com"

async def verify_token(credentials: HTTPAuthCredentials = Depends(security)):
    token = credentials.credentials

    try:
        # Get public key
        jwks_client = jwt.PyJWKClient(f"https://{DOMAIN}/.well-known/jwks.json")
        signing_key = jwks_client.get_signing_key_from_jwt(token)

        # Verify token
        payload = jwt.decode(
            token,
            signing_key.key,
            algorithms=["RS256"],
            audience=f"https://{DOMAIN}/api/v2/",
            issuer=f"https://{DOMAIN}/"
        )

        return payload
    except Exception as e:
        raise HTTPException(status_code=401, detail="Invalid token")

@app.get("/items")
async def get_items(user: dict = Depends(verify_token)):
    return { "user_id": user["sub"], "items": [] }
```

---

## Testing Implementation

### Test Login Flow

```bash
# 1. Visit login page
open http://localhost:3000/api/auth/login

# 2. Complete auth flow in Auth0
# 3. Check if callback works

# 4. Test API
curl -H "Authorization: Bearer <ACCESS_TOKEN>" \
  http://localhost:3001/api/items
```

### Inspect Token (React)

```javascript
// In browser console
const token = await auth0.getAccessTokenSilently()
console.log(token)

// Decode at jwt.io
```

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Token expired | SDK auto-refreshes, check refresh token rotation enabled |
| CORS error | Configure CORS in backend, check Auth0 allowed origins |
| Silent auth fails | Check `cacheLocation: "memory"`, try explicit login |
| Scope not in token | Add to Auth0 rule or API scopes config |
| Token validation fails | Verify audience, issuer, algorithms match |

---

## Next Steps

1. Test implementation with `/oauth-security-audit`
2. Run `/oauth-troubleshoot` for any issues
3. Deploy and update callback URLs to production domain

**Status**: Implementation guide ready!
