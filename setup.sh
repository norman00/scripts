#!/bin/bash
#
# This script configures and deploys GCP Kubeflow cluster
#
set -x
# Set environment
KFCTL_PATH=kfctl
kfctl_ver=v0.7.0
export PROJECT=ssp-data-centric-10491814
export ZONE=us-west1-a
export REGION=us-west1
export HC_CLUSTER=hc-usecase-dev-cluster
export KF_NAME=kf-hc
export NAMESPACE=kubeflow
export MIN_CPU_PLATFORM="Intel Skylake"
export SA_NAME=hc-kf-user1
export GCPROLES=roles/editor
export CLIENT_ID=1081039292574-dj6rv00p8r2pm4gfpik4ropnu2jok1em.apps.googleusercontent.com
export CLIENT_SECRET=hdlqtEjLA0MM5UuWVy8V0I6T
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v0.7-branch/kfdef/kfctl_gcp_iap.0.7.1.yaml"
export MANIFEST_GITHUB="https://github.com/kubeflow/manifests/archive"
export MANIFEST_BRANCH="v0.7-branch.tar.gz"
export MANIFEST_DIR="manifests-0.7-branch"
export BASE_DIR=$PWD
echo $BASE_DIR
export KF_DIR=${BASE_DIR}/${KF_NAME}
echo $KF_DIR
echo $CONFIG_URI
export KUBEFLOW_USERNAME=kubeflow
export KUBEFLOW_PASSWORD=knc@123
export PATH=$PATH:${PWD}/${KFCTL_PATH}
export KFCTL_GCP_YAML=kfctl_gcp_iap.0.7.1.yaml
# Config gcloud zone and region
gcloud config set compute/zone $ZONE
gcloud config set compute/region $REGION
# Kubeflow config
mkdir -p ${KF_DIR}
cd ${KF_DIR}
wget $MANIFEST_GITHUB/$MANIFEST_BRANCH
tar -xvf $MANIFEST_BRANCH
# Locate and update kfctl_gcp_iap.0.7.1.yaml file
PATH_KFCTL_GCP_YAML=$(find . -name $KFCTL_GCP_YAML)
# Update manifests URI with local branch
export MANIFEST_GITHUB_BRANCH=$MANIFEST_GITHUB/$MANIFEST_BRANCH
export MANIFEST_LOCAL_BRANCH=$KF_DIR/$MANIFEST_DIR\/
sed -i "s#$MANIFEST_GITHUB_BRANCH#$MANIFEST_LOCAL_BRANCH#g" $PATH_KFCTL_GCP_YAML
# Build  YAML file
kfctl build -V -f $KFCTL_GCP_YAML
cd $MANIFEST_DIR/gcp/
# Locate and update jinja config file
CLUSTER_JINJA=$(find . -name cluster.jinja)
sed -i "s#Intel\ Broadwell#$MIN_CPU_PLATFORM#g" $CLUSTER_JINJA
# Locate and update cluster-kubeflow.yaml
CLUSTER_KUBEFLOW=$(find . -name cluster-kubeflow.yaml)
sed -i "s#gpu-pool-max-nodes\:\ 10#gpu-pool-max-nodes\:\ 0#g" $CLUSTER_KUBEFLOW
cd ../kfdef/
kfctl apply -V -f $KFCTL_GCP_YAML
