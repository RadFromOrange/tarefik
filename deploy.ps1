#!/usr/bin/env pwsh
# Build and deploy JupyterHub, user image, and apply configs to local Kubernetes

# Variables
$JH_IMAGE = "jupyterhub-custom:latest"
$USER_IMAGE = "user-image-custom:latest"
$JH_DIR = "./jupyterhub"
$USER_DIR = "./user-image"
$K8S_DIR = "./k8s"

# Build Docker images
Write-Host "Building JupyterHub image..."
docker build -t $JH_IMAGE $JH_DIR

Write-Host "Building user image..."
docker build -t $USER_IMAGE $USER_DIR

# Load images into local Kubernetes (kind or minikube)
if (kind get clusters 2>$null) {
    Write-Host "Loading images into kind..."
    kind load docker-image $JH_IMAGE
    kind load docker-image $USER_IMAGE
} elseif (minikube status 2>$null) {
    Write-Host "Loading images into minikube..."
    minikube image load $JH_IMAGE
    minikube image load $USER_IMAGE
} else {
    Write-Host "No supported local Kubernetes cluster detected (kind or minikube)."
}

# Apply Kubernetes configs
Write-Host "Applying Kubernetes configs..."
kubectl apply -f "$K8S_DIR/redis-values.yaml"
kubectl apply -f "$K8S_DIR/traefik-values.yaml"
kubectl apply -f "$K8S_DIR/jupyterhub-configmap.yaml"
kubectl apply -f "$K8S_DIR/redis-deployment.yaml"

Write-Host "Deployment script complete."
