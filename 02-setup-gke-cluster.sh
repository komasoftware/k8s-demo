#!/bin/bash
source inc-funcs.sh


pmt="List gcloud machine types?"
cmd="gcloud compute machine-types list --zones europe-west1-b"
pmt_cmd "$pmt" "$cmd"


pmt="Launch GKE cluster?"
cmd="gcloud container clusters create webcluster --num-nodes 1 --machine-type n1-standard-1"
pmt_cmd "$pmt" "$cmd"


CLUSTER_INFO=$(gcloud container clusters describe webcluster | grep -E 'endpoint|password|admin')
ENDPOINT=$(echo "$CLUSTER_INFO" | grep endpoint | sed -e 's/endpoint://' -e 's/[ \t]*//')
PASSWORD=$(echo "$CLUSTER_INFO" | grep password | sed -e 's/password://' -e 's/[ \t]*//')

pmt="Where is the Kubernetes UI?"
cmd="echo "https://admin:$PASSWORD@$ENDPOINT/ui/""
pmt_cmd "$pmt" "$cmd"


pmt="What instances do we now have?"
cmd="gcloud compute instances list && gcloud container clusters list"
pmt_cmd "$pmt" "$cmd"

echo "NOTE: GKE runs the master for us! We only need to specify adding/removing minion nodes!"
