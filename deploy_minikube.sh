#!/usr/bin/env bash
set -Eeuo pipefail

export MINIKUBE_PROFILE="${MINIKUBE_PROFILE:=hw}"
export NAMESPACE="${NAMESPACE:=homework}"

# Start minikube if needed
if ! minikube status > /dev/null; then
  minikube start #--nodes 2
  minikube addons enable metrics-server
fi

# Apply kubernetes manifests
kubectl apply -k ./kubernetes

# Wait for MySQL deployment to be ready
ROLLOUT_WAIT="${ROLLOUT_WAIT:=1200s}"
if kubectl rollout status deployment/hw-mysql --namespace "$NAMESPACE" --timeout "$ROLLOUT_WAIT"; then
  echo "MySQL deployment has been successful"
else
  echo
  echo "MySQL deployment failed."
  kubectl logs --namespace "$NAMESPACE" --selector "app=hw-mysql" --all-containers --prefix --timestamps --tail=-1
  exit 1
fi

# Wait for WordPress deployment to be ready
if kubectl rollout status deployment/hw-wordpress --namespace "$NAMESPACE" --timeout "$ROLLOUT_WAIT"; then
  echo "WordPress deployment has been successful"
else
  echo
  echo "WordPress deployment failed."
  kubectl logs --namespace "$NAMESPACE" --selector "app=hw-wordpress" --all-containers --prefix --timestamps --tail=-1
  exit 1
fi

# Get the URL of the service
minikube service --url --namespace "$NAMESPACE" hw-wordpress-service
