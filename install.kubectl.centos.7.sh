#!/bin/bash



modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

# kubectl
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl kubeadm 

systemctl restart kubelet
systemctl enable kubelet

kubeadm init
exit 0

# k3d k3s
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# portainer
k3d cluster create portainer --api-port 6443 --servers 1 --agents 1 -p 30000-32767:30000-32767@server[0]

# rancher
#sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher

