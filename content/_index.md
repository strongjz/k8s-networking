+++
title = "k8 Networking"
outputs = ["Reveal"]
+++

# Kubernetes Networking

---

* Container
* Pod to Pod
* Service to Pod 
* External to Cluster


---

## Kubernetes Network model

* all Pods can communicate with all other Pods without using network address translation (NAT).
* all Nodes can communicate with all Pods without NAT.
* the IP that a Pod sees itself as is the same IP that others see it as.

---

# Container

---

# Pod to Pod

---

# Service to Pod

---

# External to Cluster

---

References:

* [K8 Services](https://kubernetes.io/docs/concepts/configuration/overview/#services)

* [K8 Loadbalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)

* [External Loadbalancers](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#external-load-balancer-providers)

* [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)


---
