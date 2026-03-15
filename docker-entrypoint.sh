#!/bin/sh
set -e

echo "Running Prisma migrations..."
./node_modules/.bin/prisma migrate deploy --schema=packages/database/prisma/schema.prisma

echo "Starting application..."
exec node apps/web/server.js
