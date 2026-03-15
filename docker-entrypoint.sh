#!/bin/sh
set -e

echo "Running Prisma migrations..."
node ./node_modules/prisma/build/index.js migrate deploy --schema=packages/database/prisma/schema.prisma

echo "Starting application..."
exec node apps/web/server.js
