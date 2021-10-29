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

pei "kubectl apply -f pod.yml"

wait

pei "kubectl get pods -o wide"

wait

pei "kubectl exec -it bb1 -- curl localhost:80"

wait

pei "kubectl exec -it bb1 -c bb1 -- ping \$(kubectl get pods bb3 -o json | jq .status.podIP -r)"
