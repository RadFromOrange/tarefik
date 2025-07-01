import os

c = get_config()

# Use KubeSpawner for creating user servers
c.JupyterHub.spawner_class = 'kubespawner.KubeSpawner'
c.KubeSpawner.image = 'kodeserver:toufika'
c.KubeSpawner.cmd = ["/openvscode-server/bin/openvscode-server", "--host=0.0.0.0", "--without-connection-token"]

# Configure Traefik-Redis-Proxy - this is the key piece that connects JupyterHub to Traefik
c.JupyterHub.proxy_class = 'jupyterhub_traefik_proxy.redis.TraefikRedisProxy'

# Traefik API settings - JupyterHub needs to communicate with Traefik's API
c.TraefikProxy.traefik_api_url = 'http://traefik:8080'
c.TraefikProxy.should_start = False  # We're managing Traefik separately

# Redis connection settings - must match what we configured in Traefik
c.TraefikProxy.redis_url = 'redis://TOUFIK:another-secret@docker.host.internal:6379/0'

# This is crucial - tells TraefikProxy which Traefik entrypoint to use for routing
c.TraefikProxy.traefik_entrypoint = 'web'

# Public URL that users will access - this should match your external setup
c.JupyterHub.bind_url = 'http://localhost:8022'

# Internal JupyterHub hub settings
c.JupyterHub.hub_ip = '0.0.0.0'  # Listen on all interfaces within container
c.JupyterHub.hub_port = 8081     # Port where hub runs inside container
c.JupyterHub.hub_connect_ip = 'jupyterhub'  # How other containers reach the hub
c.JupyterHub.hub_connect_port = 8081

# Use DummyAuthenticator for testing - allows any username with fixed password
c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'
c.DummyAuthenticator.password = 'testpass'

# Admin configuration
c.Authenticator.admin_users = {'admin'}
c.JupyterHub.admin_access = True

# Server management
c.JupyterHub.allow_named_servers = False

# Debugging - helpful for troubleshooting
c.JupyterHub.log_level = 'DEBUG'
