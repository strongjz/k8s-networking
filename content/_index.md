+++
title = "k8 Networking"
outputs = ["Reveal"]
+++

# Kubernetes Networking

---

### Kubernetes Network model

* All Pods can communicate with all other Pods without using network address translation (NAT).
* All Nodes can communicate with all Pods without NAT.
* The IP that a Pod sees itself as is the same IP that others see it as.

---

### It's turtles all the down 

* Node
* Kube-proxy
* Container
* Container Network Interface
* Pod to Pod
* Kubernetes DNS
* Services
* External to Cluster
* Troubleshooting
* Network Policies

---

#### Kubernetes Components

![](/k8s-networking/images/data_flow.png)

---

## Kubernetes Node

![](/k8s-networking/images/networking-node.png)

{{% note %}}
A network daemon that orchestrates network management on every node
{{% /note %}}

---

### Container Network Interface

![](/k8s-networking/images/cni.png)

https://github.com/containernetworking/cni

{{% note %}}
1 .When the container runtime expects to perform network operations on a container, 
it (like the kubelet in the case of K8s) calls the CNI plugin with the desired command.
2. The container runtime also provides related network configuration and container-specific data to the plugin.
3. The CNI plugin performs the required operations and reports the result.

{{% /note %}}

---

# Container

![](/k8s-networking/images/node_namespaces_to_container.png)

---

### Container Networking

![](/k8s-networking/images/node_network_namespace_container.png)

---

### Pod to Pod

![](/k8s-networking/images/node_namespaces_multi_pod.png)

---

# Pod Networking Demo 

---

### Kubernetes DNS

![](/k8s-networking/images/coredns.png)

https://coredns.io/

---

### Kubernetes DNS

```bash
kubectl exec -it dnsutils -- host -v -t a github.com
Trying "github.com.default.svc.cluster.local"
Trying "github.com.svc.cluster.local"
Trying "github.com.cluster.local"
Trying "github.com"
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 9135
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             30      IN      A       140.82.113.4
```

---



# Services

* NodePort
* ClusterIP - Default
* LoadBalancer
* ExternalName
* Headless

{{% note %}}

ClusterIP: cluster-internal IP.  the Service only reachable from within the cluster. This is the default ServiceType.

NodePort: Exposes the Service on each Node’s IP at a static port (the NodePort). A ClusterIP Service, 
to which the NodePort Service routes, is automatically created. You’ll be able to contact the 
NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.

LoadBalancer: Exposes the Service externally using a cloud provider’s load balancer. 
NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

{{% /note %}}

---

### Service to Pod

![](/k8s-networking/images/service.png)

---

# Services Demo

---

# External to Cluster
 
* Service Type Loadbalancer
* Ingress

---

#### Service Type LoadBalancer

![](/k8s-networking/images/service_loadbalancer.png)


---

# Ingress

* Ingress Controller
* Ingress rule 

---

### Ingress Controller

* Nginx 
* Google Cloud Loadbalancer
* Contour
* Kong
* Lots more https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

---

#### Ingress Controller

![](/k8s-networking/images/ingress_cloud.png)

---

### Ingress rule 

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: basic-ingress
spec:
  rules:
    - http:
        paths:
          - path: /testpath
            pathType: Prefix
            backend:
              service:
                name: my-service
                port:
                  number: 8080
```

---

# Loadbalancer and Ingress Demo

---


### Troubleshooting

![](/k8s-networking/images/4c.png)

- [NetShoot image](https://hub.docker.com/r/nicolaka/netshoot)
- Remove label from service endpoint
- Check Ports match
- Check Probes 
- [CCCC check](https://kubernetes.io/docs/concepts/security/overview/)

---

### Network Policy

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: demo-db
spec:
  podSelector:
    matchLabels:
      app: demo-db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: demo
```

---

#### Networking and Kubernetes 

![](/k8s-networking/images/cover.png)

Available on [Amazon](https://www.amazon.com/Networking-Kubernetes-James-Strong-ebook/dp/B09FX149GC/) and [O'Reilly](https://learning.oreilly.com/library/view/networking-and-kubernetes/9781492081647/)

---

References:

* [Kubernetes Networking Links](https://github.com/nleiva/kubernetes-networking-links)
* [Kubernetes Services Tutorials](https://kubernetes.io/docs/tasks/access-application-cluster/)
* [K8s Services](https://kubernetes.io/docs/concepts/configuration/overview/#services)
* [K8s Loadbalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)
* [External Load balancers](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#external-load-balancer-providers)
* [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)


