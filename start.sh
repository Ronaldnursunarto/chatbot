#!/bin/sh

echo "🔄 Waiting for PostgreSQL..."

until nc -z postgres 5432; do
  echo "⏳ Still waiting for DB..."
  sleep 2
done

echo "✅ Running prisma migrate deploy..."
npx prisma migrate deploy

echo "🚀 Starting the server..."
node src/app.js
