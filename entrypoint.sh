#!/bin/sh

# Start Redis in the background
redis-server --requirepass "$REDIS_PASSWORD" --notify-keyspace-events KEA &
REDIS_PID=$!

# Wait until Redis is ready
echo "Waiting for Redis to start..."
until redis-cli -a "$REDIS_PASSWORD" PING | grep -q PONG; do
    sleep 0.5
done

# Set ACL user
echo "Setting Redis ACL user..."
redis-cli -a "$REDIS_PASSWORD" ACL SETUSER "$ACL_USERNAME" on ">$ACL_PASSWORD" ~* +@all

# Stop the Redis background process
kill "$REDIS_PID"
wait "$REDIS_PID"

# Start Redis in foreground for Docker
exec redis-server --requirepass "$REDIS_PASSWORD" --notify-keyspace-events KEA
