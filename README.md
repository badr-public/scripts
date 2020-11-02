# scripts

init lxc with basic stuf (ssh, user)
* curl https://raw.githubusercontent.com/badr-public/scripts/master/lxc.init.sh | bash

install docker 
* curl https://raw.githubusercontent.com/badr-public/scripts/master/install.docker.centos.7.sh | bash

docker on lxc proxmox
* curl https://raw.githubusercontent.com/badr-public/scripts/master/docker.lxc.proxmox.resolve.problem.sh > docker.lxc.proxmox.resolve.problem.sh
* bash -x docker.lxc.proxmox.resolve.problem.sh '<CONTAINER ID>'
