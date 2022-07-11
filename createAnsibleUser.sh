#!/usr/bin/sh

### METHOD ###
create_ansible_client_user(){
  useradd --create-home --shell /bin/bash asbops
  echo  nm12ops | passwd  --stdin asbops
}

sudo_setting_ansible_user(){
  echo 'asbops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

ssh_folder_setting(){
  mkdir -p /home/asbops/.ssh
  chmod 700 /home/asbops/.ssh
}

auth_file_setting(){
  touch /home/asbops/.ssh/authorized_keys
  chmod 600 /home/asbops/.ssh/authorized_keys
}

apply_control_node_public_key(){  
  echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNoA3a4IcqNki5GDnzbixBfczG/GKe+2Pssn0PwqaTp0nO4e0z6gxxiJ52AXB+1A+2wcopzNrzdi1U6RI8CEYVIrV+dtHLyJ/xTG7bQz/JV8DbkvDjs16nS40nNY/mKbqmcmDYhlCeS61q7LBtdOkZfEeE6kG8cRTQ2sU6Vvf51oe9ZtaGynI0ZelSxAWybE/mP6hYQvPpEaonQtKuUuWw/MMWk/ZMZqgNA77m/QM0dDo5MPvWXWJ274v1siLSwkJp/nFH12wduIln5Nq9ge6x93C90jE2tnXrlXSwwojceShYveNqRCP3UT187f0SkOLs7v2EkP9LDaNJmmvKRp57 asbadmin@tpedk01t' >> /home/asbops/.ssh/authorized_keys
}



### VARIABLE ###
errflag=0;



### MAIN ###
if ! grep -q "asbops" "/etc/passwd"; then
  create_ansible_client_user;
  echo '[OK] => 1_Create Client User(asbops)';
else
  errflag=1;
  echo '[FAIL] => 1_Client User Exist(asbops)';
fi



if ! grep -q "asbops" "/etc/sudoers"; then
  sudo_setting_ansible_user;
  echo '[OK] => 2_Apply sudo Client User Setting(/etc/sudoers)';
else
  errflag=1;
  echo '[FAIL] => 2_sudo Client User Setting Exist(/etc/sudoers)';
fi



if [ ! -d "/home/asbops/.ssh" ]; then
  ssh_folder_setting;
  echo '[OK] => 3_Create SSH folder(/home/asbops/.ssh)';
else
  errflag=1;
  echo '[FAIL] => 3_SSH folder Exist(/home/asbops/.ssh)';
fi



if [ ! -e "/home/asbops/.ssh/authorized_keys" ]; then
  auth_file_setting;
  echo '[OK] => 4_Create SSH Auth File(/home/asbops/.ssh/authorized_keys)';
else
  errflag=1;
  echo '[FAIL] => 4_SSH Auth File Exist(/home/asbops/.ssh/authorized_keys)';
fi



if ! grep -q "asbadmin" "/home/asbops/.ssh/authorized_keys"; then
  apply_control_node_public_key;
  echo '[OK] => 5_Apply Control Node Public Key(/home/asbops/.ssh/authorized_keys)';
else
  errflag=1;
  echo '[FAIL] => 5_Control Node Public Key Exist(/home/asbops/.ssh/authorized_keys)';
fi



if [ "$errflag" -eq 0 ]; then
  chown -R asbops:asbops /home/asbops/
  echo '[OK] => 6_EXCUTE FINISH';
else
  echo '[FAIL] => 6_EXCUTE SOMETHING WRONG';
  exit;
fi
