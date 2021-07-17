#!/bin/bash

# install ansible
echo 'Installing ansible'
sudo dnf install ansible

# download playbook
wget -O playbook.yml https://raw.githubusercontent.com/norman00/Ansible/master/playbooks/technodrome_playbook.yml 

# log
echo 'Now run ansible-playbook playbook.yml'
