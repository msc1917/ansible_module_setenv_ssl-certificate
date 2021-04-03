# Konfiguration fuer den Service "SSL-CERTIFICATE" im Baikonur-Netzwerk
Service-Beschreibung:

## Rolle "setenv_03_ssl-certificate"
Richtet die Software für folgende Services ein:
* [SOFTWAREBEZEICHNUNG]

## Verzeichnis "tasks"
Playbook-Tasks, welche in der Rolle durchgeführt werden

## Files:
* **main.yml:** Beschreibung


## Kubernetes Certificates
Link: https://kubernetes.io/docs/setup/best-practices/certificates/

### Certificates Authorities
path                   | Default CN                | description
-----------------------+---------------------------+-------------------------------
ca.crt,key             | kubernetes-ca             | Kubernetes general CA
etcd/ca.crt,key        | etcd-ca                   | For all etcd-related functions
front-proxy-ca.crt,key | kubernetes-front-proxy-ca | For the front-end proxy

### Client Certificates
Default CN                    | Parent CA                 | O (in Subject) | kind           | hosts (SAN)
------------------------------+---------------------------+----------------+----------------+--------------------------------------------
kube-etcd                     | etcd-ca                   |                | server, client | localhost, 127.0.0.1
kube-etcd-peer                | etcd-ca                   |                | server, client | <hostname>, <Host_IP>, localhost, 127.0.0.1
kube-etcd-healthcheck-client  | etcd-ca                   |                | client         | 
kube-apiserver-etcd-client    | etcd-ca                   | system:masters | client         | 
kube-apiserver                | kubernetes-ca             |                | server         | <hostname>, <Host_IP>, <advertise_IP>, [1]
kube-apiserver-kubelet-client | kubernetes-ca             | system:masters | client         | 
front-proxy-client            | kubernetes-front-proxy-ca |                | client	        |

[1] any other IP or DNS name you contact your cluster on (as used by kubeadm the load balancer stable IP and/or DNS name, kubernetes, kubernetes.default, kubernetes.default.svc, kubernetes.default.svc.cluster, kubernetes.default.svc.cluster.local)

kind   | Key usage
-------+-------------------------------------------------
server | digital signature, key encipherment, server auth
client | digital signature, key encipherment, client auth