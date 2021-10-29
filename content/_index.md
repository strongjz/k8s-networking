+++
title = "k8 Networking"
outputs = ["Reveal"]
+++

# Kubernetes Networking

---

# Kubernetes Network model

* All Pods can communicate with all other Pods without using network address translation (NAT).
* All Nodes can communicate with all Pods without NAT.
* The IP that a Pod sees itself as is the same IP that others see it as.

---

# It's turtles all the down 

* Node
* Container
* Container to Container
* Pod to Pod
* Services
* External to Cluster

---

# Node

![](/k8s-networking/images/node.png)



---

# Container

![](/k8s-networking/images/node-container-1.png)

---

### Container to Container 
![](/k8s-networking/images/node-pod-1.png)

```bash
kubectl apply -f pod.yml
```

```bash
kubectl exec -it bb1 -c curl localhost:80
```

---

### Pod to Pod

![](/k8s-networking/images/node-container-host-2.png)

```bash
kubectl get pods -o wide
```

```bash
kubectl exec -it bb1 -c ping bb3
```
---

# Services

* NodePort
* ClusterIP - Default
* LoadBalancer

{{% note %}}

ClusterIP: cluster-internal IP.  the Service only reachable from within the cluster. This is the default ServiceType.

NodePort: Exposes the Service on each Node’s IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You’ll be able to contact the NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.

LoadBalancer: Exposes the Service externally using a cloud provider’s load balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

{{% /note %}}

---

### Service to Pod

![](/k8s-networking/images/service.png)

```bash
kubectl apply -f service-clusterip.yml
```

---

# External to Cluster
 
* Service Type Loadbalancer

* Ingress

---

#### Service Type LoadBalancer

![](/k8s-networking/images/service-loadbalancer.png)

```bash
kubectl apply -f service-loadbalancer.yml
```

---

# Ingress

* Ingress Controller
* Ingress rule 

---

### Ingress Controller

* Nginx
* Istio 
* Google Cloud Loadbalancer

---

### Ingress rule 

```bash
kubectl apply -f ingress.yml
```

---

#### Ingress 

![](/k8s-networking/images/service-Ingress.png)

---


References:

* [K8 Services](https://kubernetes.io/docs/concepts/configuration/overview/#services)

* [K8 Loadbalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)

* [External Loadbalancers](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#external-load-balancer-providers)

* [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)


