#!/bin/bash

set -e

source_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
inventory_path=$(realpath ${PWD}/../../test@local/2ssh/ansible-inventories)
echo $inventory_path

ansible-playbook -vvv -i $inventory_path $source_directory/ansible-playbook.init.yml


# 0
ansible-playbook -vvv -e ansible_password=seed -i $inventory_path $source_directory/ansible-playbook.test0.yml


# 1
ansible-playbook -vvv -e ansible_password=seed -i $inventory_path $source_directory/ansible-playbook.test1.yml


# 2
pkill ssh
sleep 2
ansible-playbook -vvv -i $inventory_path --extra-vars "mode=failed" $source_directory/ansible-playbook.ping.yml

ansible-playbook -vvv -e ansible_password=seed -i $inventory_path $source_directory/ansible-playbook.test2.yml

pkill ssh
sleep 2
ansible-playbook -vvv -i $inventory_path --extra-vars "mode=succeeded" $source_directory/ansible-playbook.ping.yml


ansible-playbook -vvv -i $inventory_path $source_directory/ansible-playbook.clean.yml
