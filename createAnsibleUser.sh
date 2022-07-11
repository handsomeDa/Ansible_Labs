#!/usr/bin/sh

## Create Ansible Managed Node User (asbops) ##
useradd --create-home --shell /bin/bash asbops
echo  redhat | passwd  --stdin asbops
echo 'asbops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


## Set SSH Folder ##
mkdir -p /home/asbops/.ssh
chmod 700 /home/asbops/.ssh

touch /home/asbops/.ssh/authorized_keys
chmod 600 /home/asbops/.ssh/authorized_keys

chown -R asbops:asbops /home/asbops/


## Echo Control Node Public Key ##
echo 'COUNTROL_NODE_ANSIBLE_ACCOUNT_PUBLIC_KEY' >> /home/asbops/.ssh/authorized_keys

echo '[Finish Create Ansible User: asbops]'