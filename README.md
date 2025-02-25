# containerized-arch

## Dockerfile Build and Push

This repository builds a base `ubuntu 22.04` image with `python 2`, `python 3`, and `r-base` installed. This repository is fully automated in the fact that it will test your changes to the `Dockerfile` by building the `Dockerfile` within a GitHub action. If your `Dockerfile` builds successfully, the pull request check job will pass and you will be able to merge your PR. After merging your PR, another GitHub action job will kick off on the main branch. This GitHub action will build the `Dockerfile` and push it to my personal DockerHub repository at `goku0713/ubuntu2204python`. And for a bonus, I use `trivy` to scan the image and show CVE's necessary to fix.

The CI/CD workflow is defined in the [`.github/workflows/docker.yml`](.github/workflows/docker.yml) file.

## Kind Cluster and JupyterHub Deployment

This repository also includes a GitHub Actions workflow to set up a `kind` cluster and deploy JupyterHub. The workflow installs Helm, adds the JupyterHub Helm repository, creates the `jupyterhub` namespace, and deploys JupyterHub using Helm.

The deployment workflow is defined in the [`.github/workflows/k8s.yml`](.github/workflows/k8s.yml) file.
