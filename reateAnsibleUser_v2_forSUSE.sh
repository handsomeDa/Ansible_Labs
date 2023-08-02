#!/usr/bin/sh

### METHOD ###
create_ansible_client_user(){
  useradd --create-home --shell /bin/bash devops
  echo  redhat | passwd  --stdin devops
}

sudo_setting_ansible_user(){
  echo 'devops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

ssh_folder_setting(){
  mkdir -p /home/devops/.ssh
  chmod 700 /home/devops/.ssh
}

auth_file_setting(){
  touch /home/devops/.ssh/authorized_keys
  chmod 600 /home/devops/.ssh/authorized_keys
}

apply_control_node_public_key(){  
  echo 'CONTROL_NODE_PUBLIC_KEY_CONTENT(~/.ssh/id_rsa.pub)' >> /home/devops/.ssh/authorized_keys
}



### VARIABLE ###
errflag=0;



### MAIN ###
if ! grep -q "devops" "/etc/passwd"; then
  create_ansible_client_user;
  echo '[OK] => 1_Create Client User(devops)';
else
  errflag=1;
  echo '[FAIL] => 1_Client User Exist(devops)';
fi



if ! grep -q "devops" "/etc/sudoers"; then
  sudo_setting_ansible_user;
  echo '[OK] => 2_Apply sudo Client User Setting(/etc/sudoers)';
else
  errflag=1;
  echo '[FAIL] => 2_sudo Client User Setting Exist(/etc/sudoers)';
fi



if [ ! -d "/home/devops/.ssh" ]; then
  ssh_folder_setting;
  echo '[OK] => 3_Create SSH folder(/home/devops/.ssh)';
else
  errflag=1;
  echo '[FAIL] => 3_SSH folder Exist(/home/devops/.ssh)';
fi



if [ ! -e "/home/devops/.ssh/authorized_keys" ]; then
  auth_file_setting;
  echo '[OK] => 4_Create SSH Auth File(/home/devops/.ssh/authorized_keys)';
else
  errflag=1;
  echo '[FAIL] => 4_SSH Auth File Exist(/home/devops/.ssh/authorized_keys)';
fi



if ! grep -q "devopsadmin" "/home/devops/.ssh/authorized_keys"; then
  apply_control_node_public_key;
  echo '[OK] => 5_Apply Control Node Public Key(/home/devops/.ssh/authorized_keys)';
else
  errflag=1;
  echo '[FAIL] => 5_Control Node Public Key Exist(/home/devops/.ssh/authorized_keys)';
fi



if [ "$errflag" -eq 0 ]; then
  chown -R devops:users /home/devops/
  echo '[OK] => 6_EXCUTE FINISH';
else
  echo '[FAIL] => 6_EXCUTE SOMETHING WRONG';
  exit;
fi
