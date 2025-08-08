#!/bin/sh

echo "⏳ Waiting for DB to be reachable..."
until nc -z postgres 5432; do
  echo "Database not up yet... waiting"
  sleep 2
done

echo "✅ DB is up. Running migrations..."
npx prisma migrate deploy

echo "🚀 Starting app..."
node src/app.js
