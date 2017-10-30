# kubernetes-deploy

在连网环境下，一键部署多master节点Kubernetes集群

**环境依赖**

Ansible 2.2+

kubernetes 1.8+

**注意**

只在`ubuntu16.04 64bit` 上测试通过，其他平台未测试。


**变量文件：environments/test/group_vars/all**

	ETCD_URL: https://github.com/coreos/etcd/releases/download/v3.2.9/etcd-v3.2.9-linux-amd64.tar.gz
	KUBERNETES_CLIENT_URL: https://dl.k8s.io/v1.8.2/kubernetes-client-linux-amd64.tar.gz
	KUBERNETES_SERVER_URL: https://dl.k8s.io/v1.8.2/kubernetes-server-linux-amd64.tar.gz
	CALICOCTL: https://github.com/projectcalico/calicoctl/releases/download/v1.6.1/calicoctl
	TOKEN: b5aa35577173f8a527c2fd08439ac0cc ＃kubelet-bootstrap要适用的token,命令:head -c 16 /dev/urandom | od -An -t x | tr -d ' '
	PROXY_PORT: 7443 ＃每个节点nginx需要监听的端口
	CLUSTER_CIDR: 10.233.0.0/16


**文件 environments/test/inventory**

	[etcd]
	#etcd主机列表,奇数个，至少3个
	172.31.19.38
	172.31.19.37
	172.31.19.39
	
	[kubernetes:children]
	masters
	nodes
	
	[masters]
	＃k8s master主机列表
	172.31.19.38
	172.31.19.37
	172.31.19.39
	
	[nodes]
	＃k8s node列表
	172.31.19.38
	172.31.19.37
	172.31.19.39
	
**执行命令，一键部署**

	ansible-playbook -i environments/test/inventory deploy.yml
