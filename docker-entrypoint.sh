#!/bin/sh
set -e

echo "Running Prisma migrations..."
npx prisma migrate deploy --schema=packages/database/prisma/schema.prisma

echo "Starting application..."
exec node apps/web/server.js
