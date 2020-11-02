# scripts

init lxc with basic stuf (ssh, user)
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/lxc.init.sh)

install docker 
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/install.docker.centos.7.sh)

docker on lxc proxmox
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/docker.lxc.proxmox.resolve.problem.sh) 'CONTAINER ID'

kubectl
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/install.kubectl.centos.7.sh)

centos 7 init
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/centos7.init.sh) hostname private
* bash -x <(curl https://raw.githubusercontent.com/badr-public/scripts/master/centos7.init.sh) hostname vpn HOST_VPN_IP VPN_GATEWAY 'NET_1;MASK_1 NET_2;MASK_2 NET_3;MASK_3'