# Authentication Guide

## Architecture
- JWT-based authentication with httpOnly cookies
- Role-based access control (RBAC) with `ADMIN`, `USER`, `VIEWER` roles
- All admin routes must use `authMiddleware` + `requireRole('ADMIN')`

## Auth Helpers (src/lib/auth/)

### authMiddleware
Validates JWT token and attaches user to request context.

```typescript
import { authMiddleware } from '@/lib/auth';

export async function GET(request: Request) {
  const user = await authMiddleware(request);
  // user is now available
}
```

### requireRole
Checks if the authenticated user has the required role.

```typescript
import { authMiddleware, requireRole } from '@/lib/auth';

export async function GET(request: Request) {
  const user = await authMiddleware(request);
  requireRole(user, 'ADMIN');
  // only ADMIN users reach here
}
```

## Security Rules
- NEVER store tokens in localStorage
- NEVER log tokens or credentials
- Always validate input before database operations
- Use parameterized queries (Prisma handles this)
