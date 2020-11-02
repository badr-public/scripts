#!/bin/bash

yum update
yum install -y sudo openssh-server vim zip unzip wget qemu-guest-agent selinux epel-release yum-utils wget vim zip unzip mutt cyrus-sasl-plain certbot certbot-nginx nginx

groups betob
if [ $? -ne 0 ]; then
  adduser betob
  echo 'betob ALL=(ALL) ALL' >> /etc/sudoers
fi
mkdir /home/betob/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVz2yxLvqWKK+6q08vhRB+ODEmJrZ5Tx+t8LffFhR7ZWnF9z0zCghsutswoereG+z8AISGBrvb/kBENaIRdz1PScMdZFWbzVTnnCpSgYAYTyJrkCPQDgbWhUM5S+umQo6rkBYB4thM9+yR8Td1ZZSp0Qe4skRNwsPahjdltXU92Sy9iClH0x2QkPhnOk8Chnvx1GDKsi1EX1JNLrXujKV9hS91cwi3O86cgc36zz9q33y9HrDSPenne3USSN4DoO/dxyAUSi+sM3u6KgAfa1n93xLEiiW/eKmih8OosjiZIb3fX/PU/n/6WT8OWQgZUKA2Jlx3/wcx8s1i9YiCsqbPumwaKi/n/2+8WUF3SJnnkx6x8ybkl+iN6KxkgOwFcJP57ZqrwD10Qpt9CkNR2Bw6GCO4WToajczvbdl91+qrdGHPoGKGluV87sKyw2qBeVuB1u+BB6zCzJu19Mh/XRNnmmNkyKSTMCvWgj9rkOG6xo1+uqVcBXoX7EiWTKxX1UU= betob@NS0001F' >> /home/betob/.ssh/authorized_keys
chown -R betob:betob /home/betob/.ssh
chmod -R 700 /home/betob/.ssh

systemctl start sshd
systemctl enable sshd

if [ "${1}" == "vpn" ]; then
  ROUTE_FILE='~/route_vpn.sh';
  VPN_PRIVATE_IP=${2}
  VPN_GATEWAY=${3}
  # 192.168.2.0;255.255.255.0 10.0.3.0;255.255.255.0 10.0.6.0;255.255.255.0
  VPN_ROUTES="${4}"  

  yum install openvpn easy-rsa iptables-services
  echo "#!/bin/bash -x
  
  systemctl start openvpn@sp1
  sleep 1
  
  EX_VALUE=1
  while [ \$EX_VALUE -ne 0 ]; do
  /sbin/ip addr | grep ${VPN_PRIVATE_IP}
  EX_VALUE=\$?
  done

  # routes" > ${ROUTE_FILE}
  for VPN_ROUTE in ${VPN_ROUTES}; do
    NET=$(echo ${VPN_ROUTE} | cut -d';' -f1);
    MASK=$(echo ${VPN_ROUTE} | cut -d';' -f2);
    echo "route add -net ${NET} netmask ${MASK} gw ${VPN_GATEWAY}" >> ${ROUTE_FILE}
  done
  echo "
  # remove ssh from public interface
  grep '^NAME' /etc/os-release | grep -i 'CentOS'
  if [ \$? -eq 0 ]; then
    firewall-cmd --zone=trusted --change-interface=tun0
    firewall-cmd --zone=public --remove-service=ssh
  fi" >> ${ROUTE_FILE}

elif [ "${1}" == "private" ]; then
  ## Disable selinux
  setsebool -P httpd_can_network_connect 1
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

  ## Disable firewall
  systemctl disable firewalld
fi

reboot
