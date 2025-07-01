FROM jupyterhub/jupyterhub:4.1.5

USER root

# Install KubeSpawner, Traefik-Redis-Proxy, and DummyAuthenticator
RUN pip install \
    jupyterhub-kubespawner \
    jupyterhub-traefik-proxy[redis] \
    jupyterhub-dummyauthenticator
