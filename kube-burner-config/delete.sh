#!/bin/bash

# Deleting 200 namespaces
echo "Deleting namespaces..."
for i in {0..100}; do
  ns_name="argocd-test-$i"
  kubectl delete ns "$ns_name" &
done

# Wait for all namespace deletions to complete
wait

# Deleting 200 ArgoCD applications
echo "Deleting ArgoCD applications..."
for i in {0..100}; do
  app_name="app-$i"
  kubectl delete applications.argoproj.io "$app_name" -n openshift-gitops &
done

# Wait for all application deletions to complete
wait

echo "Deletion process completed."
