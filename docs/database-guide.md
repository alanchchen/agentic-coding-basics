# Database Guide

## Overview
This project uses Prisma as the ORM with PostgreSQL.

## Migration Workflow
1. Edit `prisma/schema.prisma` to define changes
2. Run `pnpm prisma migrate dev --name <description>` to create migration
3. Run `pnpm prisma generate` to update the client
4. NEVER edit migration SQL files directly

## Conventions
- All tables use `snake_case` naming
- Always include `createdAt` and `updatedAt` timestamps
- Use `@relation` decorators for all foreign keys
- Soft delete: use `deletedAt` field, never hard delete

## Query Patterns
- Always use Prisma transactions for multi-table operations
- Use `select` to limit returned fields (avoid `SELECT *`)
- Paginate all list queries with `take` and `skip`

## Example
```typescript
const users = await prisma.user.findMany({
  select: { id: true, name: true, email: true },
  where: { deletedAt: null },
  take: 20,
  skip: page * 20,
  orderBy: { createdAt: 'desc' },
});
```
