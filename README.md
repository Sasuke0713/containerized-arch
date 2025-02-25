# containerized-arch

## Dockerfile Build and Push

This repository builds a base `ubuntu 22.04` image with `python 2`, `python 3`, and `r-base` installed. This repository is fully automated in the fact that it will test your changes to the `Dockerfile` by building the `Dockerfile` within a GitHub action. If your `Dockerfile` builds successfully, the pull request check job will pass and you will be able to merge your PR. After merging your PR, another GitHub action job will kick off on the main branch. This GitHub action will build the `Dockerfile` and push it to my personal DockerHub repository at `goku0713/ubuntu2204python`. And for a bonus, I use `trivy` to scan the image and show CVE's necessary to fix.

The CI/CD workflow is defined in the [`.github/workflows/docker.yml`](.github/workflows/docker.yml) file.

## Kind Cluster and JupyterHub Deployment

This repository also includes a GitHub Actions workflow to set up a `kind` cluster and deploy JupyterHub. The workflow installs Helm, adds the JupyterHub Helm repository, creates the `jupyterhub` namespace, and deploys JupyterHub using Helm.

The deployment workflow is defined in the [`.github/workflows/k8s.yml`](.github/workflows/k8s.yml) file.

## Monitoring

This repository includes a monitoring setup using Prometheus and Grafana to ensure that resource requests are accurate (requested vs used) with the CPU and memory limits.

### Prometheus and Grafana Installation

Prometheus and Grafana are installed using Helm charts. The `k8s.yml` workflow includes steps to add the Helm repositories, install Prometheus and Grafana, and configure them to scrape metrics from the Kubernetes cluster.

### Prometheus Rules

Prometheus rules are defined to alert on high CPU and memory usage. These rules are applied to the cluster to monitor resource usage and ensure that the requested resources are being used efficiently.

### Grafana Dashboards

Grafana dashboards are used to visualize the metrics collected by Prometheus. Pre-built Kubernetes dashboards are imported to provide insights into the cluster's resource usage.

### Example Prometheus Alert Rule

```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: prometheus-alerts
  namespace: monitoring
spec:
  groups:
  - name: resource-usage
    rules:
    - alert: HighCPUUsage
      expr: (sum(rate(container_cpu_usage_seconds_total[5m])) by (pod) / sum(kube_pod_container_resource_requests{resource="cpu"}) by (pod)) > 0.8
      for: 5m
      labels:
        severity: warning
      annotations:
        summary: "High CPU usage detected"
        description: "Pod {{ $labels.pod }} is using more than 80% of its requested CPU for more than 5 minutes."
    - alert: HighMemoryUsage
      expr: (sum(container_memory_usage_bytes) by (pod) / sum(kube_pod_container_resource_requests{resource="memory"}) by (pod)) > 0.8
      for: 5m
      labels:
        severity: warning
      annotations:
        summary: "High Memory usage detected"
        description: "Pod {{ $labels.pod }} is using more than 80% of its requested memory for more than 5 minutes."
