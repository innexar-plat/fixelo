#!/bin/sh
set -e

echo "Running Prisma migrations..."
node ./node_modules/prisma/build/index.js migrate deploy --schema=packages/database/prisma/schema.prisma

if [ "${RUN_DB_PUSH:-true}" = "true" ]; then
	echo "Synchronizing Prisma schema (db push)..."
	node ./node_modules/prisma/build/index.js db push --schema=packages/database/prisma/schema.prisma --skip-generate
fi

if [ "${RUN_DB_SEED:-true}" = "true" ]; then
	echo "Running database seed..."
	node /app/seed-runtime.js
fi

echo "Starting application..."
exec node apps/web/server.js
