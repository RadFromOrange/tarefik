#!/usr/bin/env bash
# Build and deploy JupyterHub, user image, and apply configs to local Kubernetes (Linux version)

set -e

JH_IMAGE="jupyterhub-custom:latest"
USER_IMAGE="user-image-custom:latest"
JH_DIR="./jupyterhub"
USER_DIR="./user-image"
K8S_DIR="./k8s"

# Build Docker images
echo "Building JupyterHub image..."
docker build -t "$JH_IMAGE" "$JH_DIR"

echo "Building user image..."
docker build -t "$USER_IMAGE" "$USER_DIR"

# Load images into local Kubernetes (kind or minikube)
if kind get clusters &>/dev/null; then
    echo "Loading images into kind..."
    kind load docker-image "$JH_IMAGE"
    kind load docker-image "$USER_IMAGE"
elif minikube status &>/dev/null; then
    echo "Loading images into minikube..."
    minikube image load "$JH_IMAGE"
    minikube image load "$USER_IMAGE"
else
    echo "No supported local Kubernetes cluster detected (kind or minikube)."
fi

# Apply Kubernetes configs
echo "Applying Kubernetes configs..."
kubectl apply -f "$K8S_DIR/redis-values.yaml"
kubectl apply -f "$K8S_DIR/traefik-values.yaml"
kubectl apply -f "$K8S_DIR/jupyterhub-configmap.yaml"
kubectl apply -f "$K8S_DIR/redis-deployment.yaml"

echo "Deployment script complete."
