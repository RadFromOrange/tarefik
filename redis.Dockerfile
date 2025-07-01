# Simple Dockerfile for Redis with password protection
FROM redis:7.2-alpine

# Set the Redis password (change as needed)
ENV REDIS_PASSWORD=your-redis-password

# Start Redis with password requirement
CMD ["redis-server", "--requirepass", "${REDIS_PASSWORD}"]
