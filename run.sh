#!/bin/bash

#kube-api-server
docker run --rm --net=host -v /opt/k8s/cert/:/opt/k8s/cert/ kube-apiserver:1.0 \
--admission-control=NamespaceLifecycle,NamespaceAutoProvision,LimitRanger,SecurityContextDeny,ResourceQuota \
--runtime-config=api/v1 --allow-privileged=true --insecure-bind-address=10.27.44.103 \
--insecure-port=8080 --kubelet-https=true --secure-port=6443 --bind-address=10.27.44.103 \
--client-ca-file=/opt/k8s/cert/ca.crt --tls-private-key-file=/opt/k8s/cert/server.key \
--tls-cert-file=/opt/k8s/cert/server.crt --service-cluster-ip-range=10.200.0.0/16 \
--etcd-servers=http://10.27.44.103:4001 --logtostderr=true --cors-allowed-origins='.*'

#kube-controller-manager
docker run -d --net=host -v /etc/kubernetes:/etc/kubernetes -v /opt/k8s:/opt/k8s kube-controller-manager:1.0 \
--master=10.27.44.103:8080 --master=https://10.27.44.103:6443 \
--service_account_private_key_file=/opt/k8s/server.key
--root-ca-file=/opt/k8s/cert/ca.crt --kubeconfig=/etc/kubernetes/kubeconfig-master \
--logtostderr=true

#kube-scheduler
docker run -d --net=host -v /etc/kubernetes:/etc/kubernetes -v /opt/k8s:/opt/k8s kube-scheduler:1.0 \
--master=https://10.27.44.103:6443 --kubeconfig=/etc/kubernetes/kubeconfig-master

#kube-proxy
docker run --privileged --rm --net=host -v /etc/kubernetes:/etc/kubernetes -v /opt/k8s:/opt/k8s  kube-proxy:1.0 \
--master=https://10.27.44.103:6443 --proxy-mode=iptables \
--logtostderr=true --kubeconfig=/etc/kubernetes/kubeconfig-kubelet

#run kube-dns
docker run --rm --net=host -v /opt/k8s/:/opt/k8s/ -v /etc/kubernetes:/etc/kubernetes kube-dns:1.0 \
--dns-port=53 --domain=cluster.local \
--kube-master-url=https://10.27.44.103:6443 \
--kubecfg-file=/etc/kubernetes/kubeconfig-master



# kubelet run in systemd
