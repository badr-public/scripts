#!/bin/bash

yum update
yum install -y sudo openssh-server vim zip unzip wget qemu-guest-agent selinux
#!/bin/bash

#adduser betob
mkdir /home/betob/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVz2yxLvqWKK+6q08vhRB+ODEmJrZ5Tx+t8LffFhR7ZWnF9z0zCghsutswoereG+z8AISGBrvb/kBENaIRdz1PScMdZFWbzVTnnCpSgYAYTyJrkCPQDgbWhUM5S+umQo6rkBYB4thM9+yR8Td1ZZSp0Qe4skRNwsPahjdltXU92Sy9iClH0x2QkPhnOk8Chnvx1GDKsi1EX1JNLrXujKV9hS91cwi3O86cgc36zz9q33y9HrDSPenne3USSN4DoO/dxyAUSi+sM3u6KgAfa1n93xLEiiW/eKmih8OosjiZIb3fX/PU/n/6WT8OWQgZUKA2Jlx3/wcx8s1i9YiCsqbPumwaKi/n/2+8WUF3SJnnkx6x8ybkl+iN6KxkgOwFcJP57ZqrwD10Qpt9CkNR2Bw6GCO4WToajczvbdl91+qrdGHPoGKGluV87sKyw2qBeVuB1u+BB6zCzJu19Mh/XRNnmmNkyKSTMCvWgj9rkOG6xo1+uqVcBXoX7EiWTKxX1UU= betob@NS0001F' >> /home/betob/.ssh/authorized_keys
chown -R betob:betob /home/betob/.ssh
chmod -R 700 /home/betob/.ssh

#echo 'betob ALL=(ALL) ALL' >> /etc/sudoers

systemctl start sshd
systemctl enable sshd

sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
