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

pei "cat pod.yml"

wait

pei "kubectl apply -f pod.yml"

pei "kubectl get pods --watch"

wait

pei "kubectl get pods -o wide"

wait

pei "kubectl exec -it bb1 -c bb1 -- curl -s localhost:80"

wait

BB3_ADR=$(kubectl get pods bb3 -o json | jq .status.podIP -r)
p "BB3_ADR=\$(kubectl get pods bb3 -o json | jq .status.podIP -r)"
pei "kubectl exec -it bb1 -c bb1 -- ping -c 4 \$BB3_ADR"

wait

NODE=$(kubectl get pods bb1 -o json | jq .spec.nodeName -r)
BB1_ADR=$(kubectl get pods bb1 -o json | jq .status.podIP -r)
CNI=$(docker exec kind-worker ip netns list | awk '{print $1}')

p "NODE=\$(kubectl get pods bb1 -o json | jq .spec.nodeName -r)"
p "BB1_ADR=\$(kubectl get pods bb1 -o json | jq .status.podIP -r)"

pei "docker exec \$NODE curl -s \$BB1_ADR"

wait

pei "docker exec \$NODE ip netns list"

wait

pei "docker exec \$NODE ip a"

wait

p "CNI=\$(docker exec \$NODE ip netns list)"
pei "docker exec \$NODE ip netns exec \$CNI ip a"
wait

