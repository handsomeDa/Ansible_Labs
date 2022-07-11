#!/usr/bin/sh

## Create Ansible Managed Node User (devops) ##
useradd --create-home --shell /bin/bash devops
echo  redhat | passwd  --stdin devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


## Set SSH Folder ##
mkdir -p /home/devops/.ssh
chmod 700 /home/devops/.ssh

touch /home/devops/.ssh/authorized_keys
chmod 600 /home/devops/.ssh/authorized_keys

chown -R devops:devops /home/devops/


## Echo Control Node Public Key ##
echo 'CONTROL_NODE_PUBLIC_KEY_CONTENT(~/.ssh/id_rsa.pub)' >> /home/devops/.ssh/authorized_keys

echo '[Finish Create Ansible User: devops]'