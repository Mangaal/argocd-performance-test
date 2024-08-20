#!/bin/bash

# Deleting 200 namespaces
echo "Deleting resources in namespaces..."
for i in {0..100}; do
  ns_name="argocd-test-$i"

  # Delete the specific deployment and service
  kubectl delete deployment bubble-animation -n "$ns_name" &
  kubectl delete service bubble-animation -n "$ns_name" &

  # Delete all pods in the namespace
  kubectl delete pods -n "$ns_name" --all --force&

  # Delete the namespace
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
