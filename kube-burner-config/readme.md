## Kube-Burner Configuration Details

kube-burner-config/metric/metrics-profile.yaml
This file contains the metrics profile for ArgoCD performance testing, capturing key metrics such as:

CPU Usage of ArgoCD Application Controller:
```
- query: irate(process_cpu_seconds_total{container="argocd-application-controller",namespace=~".+"}[1m])
  metricName: argocdAppControllerCPU
```

Memory Usage of ArgoCD Application Controller:
```
- query: go_memstats_heap_alloc_bytes{container="argocd-application-controller",namespace=~".+"}
  metricName: argocdAppControllerHeapAllocMemory

- query: go_memstats_heap_inuse_bytes{container="argocd-application-controller",namespace=~".+"}
  metricName: argocdAppControllerHeapInuseMemory
```

Number of Kubernetes Resource Objects in the Cache:
```
- query: sum(argocd_cluster_api_resource_objects{namespace=~".+"})
  metricName: argocdClusterApiResourceObjects
```
Number of Monitored Kubernetes API Resources:
```
- query: sum(argocd_cluster_api_resources{namespace=~".+"}) 
  metricName: argocdClusterApiResources
```
Total IO Operations of ArgoCD Application Controller:
```
- query: sum(rate(container_fs_reads_total{pod=~"openshift-gitops-application-controller-.*",namespace=~".+"}[1m])) + sum(rate(container_fs_writes_total{pod=~"openshift-gitops-application-controller-.*",namespace=~".+"}[1m]))
  metricName: argocdAppControllerIO
```
ArgoCD Pending Kubectl Exec:
```
- query: sum(argocd_kubectl_exec_pending{namespace=~".+"})
  metricName: argocdPendingKubectlExec
```
### kube-burner-config/template
This directory contains several template files necessary for the test setup:

application.yaml: ArgoCD application template.

namespace.yaml: ArgoCD application destination namespace template.

role.yaml: ArgoCD application controller role template in the destination namespace.

rolebinding.yaml: ArgoCD application controller rolebinding template in the destination namespace.

### Template Customization

Before deploying, you need to update some fields in the YAML files located in the kube-burner-config/template directory:

application.yaml: Update the namespace field with ```<argocd-namespace>```.

namespace.yaml:
```
labels:
  argocd.argoproj.io/managed-by: <argocd-namespace>
```
rolebinding.yaml: Update the following fields:
```
subjects:
  - kind: ServiceAccount
    name: <application controller service account name>
    namespace: <argocd-namespace>
```

Replace ```<argocd-namespace>``` and ```<application-controller-service-account-name>``` with the appropriate values for your environment.
