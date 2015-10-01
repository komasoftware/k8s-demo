#!/bin/bash
# [Following Guide](https://cloud.google.com/container-engine/docs/before-you-begin)
# [enable GKE](https://console.developers.google.com/project/_/kubernetes/list)
# **Create new project k8s-elk**
# enable beta features in gcloud client tool
gcloud components update beta
gcloud components update kubectl
gcloud config set project k8s-elasticsearch # replace with your own project id
gcloud config set compute/zone europe-west1-b
# review cloud config
gcloud config list


echo "Now build the Docker images and push them to the container registry"
