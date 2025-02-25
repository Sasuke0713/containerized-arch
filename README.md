# containerized-arch

## Dockerfile Build and Push

This repository builds a base `ubuntu 22.04` image with `python 2`, `python 3` and `r-base` installed. This repository is fully automated in the fact that it will test your changes to the `Dockerfile` by building the `Dockerfile` within a github action. If your `Dockerfile` builds successfully, the pull request check job will pass and you will be able to merge your PR. After merging your PR, another github action job will kick off on the main branch. This github action will build the `Dockerfile` and push it to my personal dockerhub repository at `goku0713/ubuntu2204python`. And for a bonus I use `trivy` to scan the image and show CVE's necessary to fix.
