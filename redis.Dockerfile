FROM redis:latest

COPY redis.conf /etc/redis/redis.conf
COPY users.acl /etc/redis/users.acl

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf","--notify-keyspace-events","KEA"]
