#Managed Node Step
## 1_Create Client User(devops)
useradd --create-home --shell /bin/bash devops
echo  redhat | passwd  --stdin devops

## 2_Apply sudo Client User Setting(/etc/sudoers)
echo 'devops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

## 3_Create SSH folder(/home/devops/.ssh)
mkdir -p /home/devops/.ssh
chmod 700 /home/devops/.ssh

## 4_Create SSH Auth File(/home/devops/.ssh/authorized_keys)
touch /home/devops/.ssh/authorized_keys
chmod 600 /home/devops/.ssh/authorized_keys

## 5_Apply Control Node Public Key(/home/devops/.ssh/authorized_keys)
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNoA3a4IcqNki5GDnzbixBfczG/GKe+2Pssn0PwqaTp0nO4e0z6gxxiJ52AXB+1A+2wcopzNrzdi1U6RI8CEYVIrV+dtHLyJ/xTG7bQz/JV8DbkvDjs16nS40nNY/mKbqmcmDYhlCeS61q7LBtdOkZfEeE6kG8cRTQ2sU6Vvf51oe9ZtaGynI0ZelSxAWybE/mP6hYQvPpEaonQtKuUuWw/MMWk/ZMZqgNA77m/QM0dDo5MPvWXWJ274v1siLSwkJp/nFH12wduIln5Nq9ge6x93C90jE2tnXrlXSwwojceShYveNqRCP3UT187f0SkOLs7v2EkP9LDaNJmmvKRp57 devopsadmin@tpedk01t' >> /home/devops/.ssh/authorized_keys

## 6_Change Folder Owner
chown -R devops:devops /home/devops/



#Control Node Step
## 1_Create Ansible Control Node User(devopsadmin)
useradd --create-home --shell /bin/bash devopsadmin
echo redhat | passwd --stdin devopsadmin

## 2_Change Role to Ansible Control Node User(devopsadmin)
su - devopsadmin
ssh-keygen -q -N "" -f /home/devopsadmin/.ssh/id_rsa

## Pass Public Key to Managed Node or 
## Copy Public key to Managed Node
ssh-copy-id -i ~/.ssh/id_rsa.pub devops@servera.lab.example.com