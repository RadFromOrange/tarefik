c = get_config()

# Use KubeSpawner
c.JupyterHub.spawner_class = 'kubespawner.KubeSpawner'
c.KubeSpawner.image = 'gitpod/openvscode-server:latest'
c.KubeSpawner.cmd = ["/openvscode-server/bin/openvscode-server", "--host=0.0.0.0", "--without-connection-token"]

# Traefik-Redis-Proxy configuration
c.JupyterHub.proxy_class = 'jupyterhub_traefik_proxy.redis.TraefikRedisProxy'
c.TraefikRedisProxy.traefik_api_url = 'http://traefik-proxy:8080'
c.TraefikRedisProxy.traefik_api_password = 'your-traefik-api-password'
c.TraefikRedisProxy.redis_url = 'redis://:your-redis-password@redis:6379'

# Use DummyAuthenticator for testing
c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'
c.DummyAuthenticator.password = 'testpass'

# Other JupyterHub settings
c.JupyterHub.hub_connect_ip = '0.0.0.0'
c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.hub_port = 8081
c.JupyterHub.allow_named_servers = True
c.JupyterHub.admin_access = True

# Example: set admin users
c.Authenticator.admin_users = {'adminuser'}
