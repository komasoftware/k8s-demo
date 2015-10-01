#!/bin/bash
source inc-funcs.sh

pmt="Download and start the Elasticsearch docker image?"
cmd="kubectl run webserver --image=gcr.io/k8s-elasticsearch/webserver --port=80"
pmt_cmd "$pmt" "$cmd"


pmt="Watch for the webserver container to start"
cmd="watch -g -n 1 'kubectl get pods | grep -i running' && kubectl get pods"
pmt_cmd "$pmt" "$cmd"


pmt="Expose the running container to the world. (discuss services and kube-proxy)"
cmd="kubectl expose rc webserver --create-external-load-balancer=true && watch -g -n 1 'gcloud compute forwarding-rules list' && gcloud compute forwarding-rules list"
pmt_cmd "$pmt" "$cmd"


pmt="Watch for kubernetes to see the new load balancer external IP"
cmd="watch -g -n 1 'kubectl get services webserver' && kubectl get services webserver"
pmt_cmd "$pmt" "$cmd"


put="NOTE: Note there are 2 IP(s) listed, both serving port 80. One is the internal IP that other pods in the cluster can use to talk to your service; the other is the external load-balanced IP."
cmd="kubectl get services webserver"
put_cmd "$put" "$cmd"


ES_IP=$(kubectl get services webserver -o yaml | grep ip: | sed -e 's/- ip://' -e 's/[ \t]*//' )
put="Let's see if nginx is actually up and available..."
cmd="curl --retry 10 http://${ES_IP}:80"
put_cmd "$put" "$cmd"
