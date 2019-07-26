+++
title = "k8 Networking"
outputs = ["Reveal"]
+++

# Kubernetes Networking

---

## Kubernetes Network model

* all Pods can communicate with all other Pods without using network address translation (NAT).
* all Nodes can communicate with all Pods without NAT.
* the IP that a Pod sees itself as is the same IP that others see it as.

---

## it's turtles all the down 

* Container to Container
* Pod to Pod
* Service to Pod 
* External to Cluster

---

# Container

![](/k8-networking/images/node.png)

```bash
kubectl apply -f pod.yml
```

```bash
kubectl exec -it bb1 -c curl localhost:80
```

---

### Pod to Pod

![](/k8-networking/images/node-2-pod-to-pod.png)


```bash
kubectl get pods -o wide
```

```bash
kubectl exec -it bb1 -c ping bb3
```
---

# Service to Pod

```bash
kubectl apply -f service-clusterip.yml
```

---

### Service Types

* ClusterIP - Default
* NodePort
* LoadBalancer

{{% note %}}

ClusterIP: cluster-internal IP.  the Service only reachable from within the cluster. This is the default ServiceType.

NodePort: Exposes the Service on each Node’s IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You’ll be able to contact the NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.

LoadBalancer: Exposes the Service externally using a cloud provider’s load balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

{{% /note %}}

---

# ClusterIP

```bash
kubectl expose deployment nginx1 --port=80 
```

---

# NodePort

```bash
kubectl create apply -f service-nodeport.yml
```

---

# LoadBalancer

```bash
kubectlcreate apply -f service-loadbalancer.yml
```

---

# External to Cluster
 

* Service Type LoadBalancer

* Ingress

---

### Ingress

* Ingress Controller
* Ingress rule 

---

### Ingress Controller

* Nginx
* Contour 
* F5 

---

### Ingress rule 

```bash
kubectl apply -f ingress.yml
```

---


References:

* [K8 Services](https://kubernetes.io/docs/concepts/configuration/overview/#services)

* [K8 Loadbalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)

* [External Loadbalancers](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#external-load-balancer-providers)

* [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)


