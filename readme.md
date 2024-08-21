# ArgoCD Performance Testing with Kube-Burner

This repository contains the configuration used to test ArgoCD's performance when managing 100 applications across 100 different namespaces on an OpenShift cluster.

## Why Use Kube-Burner?

[Kube-Burner](https://kube-burner.github.io/kube-burner/latest/) is a versatile tool that not only creates resources but also waits for them to reach a desired state and collects relevant metrics. This capability is particularly useful for performance testing and benchmarking.

In the context of ArgoCD, while Kube-Burner does not have the ability to check or wait for an application to be synced, it can monitor the child resources created by ArgoCD using labels and collect the necessary metrics.

### Wait Configuration Example

The following is an example of the wait configuration used in this setup:

```yaml
objects:
  - kind: Application
    objectTemplate: template/application.yaml
    replicas: 1
    waitOptions:
      kind: Deployment
      labelSelector: {kube-burner: argocd-performance-test}
```

### Deploying the Test Setup

To deploy the applications, navigate to the kube-burner-config directory and run the following command:
```
kube-burner init -c config.yaml -e metric/ep.yaml
```

This command will initialize the test setup using the specified configuration files.


