#!/usr/bin/env bash

########################
# include the magic
########################
. ./demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
 TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# text color
# DEMO_CMD_COLOR=$BLACK

# hide the evidence
clear

pei "kubectl apply -f web.yml,database.yml,netshoot.yml"
wait

pei "kubectl get pods --watch"
wait

# Stateful
p "#Statefulset demo"
pei "kubectl get statefulset postgres"
wait
pei "kubectl describe statefulset postgres"
wait
pei "kubectl exec netshoot -- host postgres-0.postgres.default.svc.cluster.local."
wait
pei "kubectl exec netshoot -- host postgres-1.postgres.default.svc.cluster.local."
wait
pei "kubectl exec netshoot -- host postgres"
wait

# Nodeport
p "#Nodeport DEMO"
pei "kubectl scale deployment app --replicas 6"
wait
pei "kubectl get pods -o wide -l app=app"
wait
pei "kubectl get pods -o wide -l app=app --watch"
wait

NODE1=$(kubectl get nodes kind-worker -o json | jq -r .status.addresses[0].address)
NODE2=$(kubectl get nodes kind-worker2 -o json | jq -r .status.addresses[0].address)
NODE3=$(kubectl get nodes kind-worker3 -o json | jq -r .status.addresses[0].address)

pei "kubectl apply -f service-nodeport.yml"
wait
pei "kubectl exec -it netshoot -- wget -q -O- \$NODE1:30040/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$NODE2:30040/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$NODE3:30040/host"
wait

# Cluster IP
p "#Cluster IP DEMO"
pei "kubectl apply -f service-clusterip.yml"
wait
pei "kubectl get service clusterip-service"
wait
pei "kubectl get endpoints clusterip-service"
wait

CLUSTER_IP=$(kubectl get service clusterip-service -o json | jq -r .spec.clusterIP)
CLUSTER_PORT=$(kubectl get service clusterip-service -o json | jq -r .spec.ports[0].port)

pei "kubectl exec -it netshoot -- wget -q -O- \$CLUSTER_IP:\$CLUSTER_PORT/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$CLUSTER_IP:\$CLUSTER_PORT/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$CLUSTER_IP:\$CLUSTER_PORT/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$CLUSTER_IP:\$CLUSTER_PORT/host"
pei "kubectl exec -it netshoot -- wget -q -O- \$CLUSTER_IP:\$CLUSTER_PORT/host"
wait

#Headless
p "#HEADLESS DEMO"
pei "kubectl apply -f service-headless.yml"
wait
pei "kubectl exec netshoot -- host -v -t a headless-service"
wait
pei "kubectl describe endpoints headless-service"
wait

# External Service
p "#HEADLESS DEMO"
pei "kubectl apply -f service-external.yml"
wait
pei "kubectl exec -it netshoot -- host -v -t a external-service"
wait
pei "kubectl exec -it netshoot -- host -v -t a github.com"
wait