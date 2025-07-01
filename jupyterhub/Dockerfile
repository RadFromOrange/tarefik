FROM jupyterhub/jupyterhub:4.1.5

USER root

# Install KubeSpawner and Traefik-Redis-Proxy
RUN pip install \
    jupyterhub-kubespawner \
    jupyterhub-traefik-proxy[redis]

USER jovyan
