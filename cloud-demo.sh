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

pei "kubectl cluster-info"
pei "kubectl get nodes -o wide"
wait
pei "kubectl apply -f web.yml,database.yml,netshoot.yml,service-clusterip.yml"
pei "kubectl scale deployment app --replicas 6"
wait
pei "kubectl get pods -o wide --watch"
wait

pei "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/aws/deploy.yaml"

pei "kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s"
wait

pei "cat ingress.yml"
wait
pei "kubectl apply -f ingress.yml"
wait

pei "kubectl get svc -n ingress-nginx"
wait

#Get External IP of the Ingress controller
EXT_IP=$(kubectl get svc -n ingress-nginx -o json ingress-nginx-controller | jq -r .status.loadBalancer.ingress[0].hostname)
#Curl it
p "EXT_IP=\$(kubectl get svc -n ingress-nginx -o json ingress-nginx-controller | jq -r .status.loadBalancer.ingress[0].hostname)"
pei "curl \$EXT_IP/host"
pei "curl \$EXT_IP/host"
pei "curl \$EXT_IP/host"
pei "curl \$EXT_IP/host"
pei "curl \$EXT_IP/host"
pei "curl \$EXT_IP/host"
wait

