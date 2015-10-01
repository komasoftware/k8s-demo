#!/bin/bash
source inc-funcs.sh

INSTANCE_GROUP=$(gcloud compute instance-groups list | grep -v NAME | awk '{ print $1 }')
pmt="Looks like we need more hosts!"
cmd="gcloud compute instance-groups managed resize $INSTANCE_GROUP --size 2"
pmt_cmd "$pmt" "$cmd"

pmt="Wait for hosts to join"
cmd="watch -n 1 'gcloud compute instances list' && gcloud compute instances list"
pmt_cmd "$pmt" "$cmd"


pmt="Scale up the ES data pods"
cmd="kubectl scale --replicas=5 rc webserver"
pmt_cmd "$pmt" "$cmd"

pmt="Wait for pods to all start"
cmd="watch -g -n 1 'kubectl get pods'"
pmt_cmd "$pmt" "$cmd"

INSTANCE=$(gcloud compute instances list | grep -v NAME | awk '{ print $1 }' | tail -n 1)
pmt="Let's kill a container"
cmd="gcloud compute ssh $INSTANCE"
pmt_cmd "$pmt" "$cmd"


pmt="See the pod restart"
cmd="watch -n 1 'kubectl get pods' && kubectl get pods"
pmt_cmd "$pmt" "$cmd"


pmt="Let's deploy a new version"
cmd="kubectl rolling-update webserver --image=gcr.io/k8s-elasticsearch/webserver-new --update-period=\"5s\""
pmt_cmd "$pmt" "$cmd"
