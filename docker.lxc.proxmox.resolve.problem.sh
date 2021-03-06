#!/bin/bash

if [ ! -f /etc/pve/local/lxc/${1}.conf ]; then
    echo 'Error, lxc config not found'
    exit 1
fi

pct stop ${1}

echo '#insert docker part below
lxc.apparmor.profile: unconfined
lxc.cgroup.devices.allow: a
lxc.cap.drop:' >> /etc/pve/local/lxc/${1}.conf

pct start ${1}

