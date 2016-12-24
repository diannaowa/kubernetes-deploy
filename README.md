# kubernetes-deploy

环境依赖：

centos7

ansible 2.1/2.2

需要配置好该部署脚本所在机器到其它节点可以基于ssh-key登录。

克隆部署脚本：


	git clone https://github.com/diannaowa/kubernetes-deploy.git
	
	cd kubernetes-deploy

设置集群节点，编辑`environments/test/inventory`文件：

	[k8s-master]
	10.27.44.103
	
	[k8s-node]
	10.27.44.103
	
	[etcd-servers]
	10.27.44.103
	
注：目前`k8s-master`只支持一个节点，其他都可以填写多个节点ip，`etcd-servers`建议至少五个节点。

部署集群：

	ansible-playbook -i environments/test/inventory all.yml
	

