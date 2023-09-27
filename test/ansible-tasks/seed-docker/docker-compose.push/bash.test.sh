#!/bin/bash

set -e

source_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
inventory_path=$(realpath ${PWD}/../../test@local/4docker/ansible-inventories)
echo $inventory_path

ansible-playbook -vvv -i $inventory_path $source_directory/ansible-playbook.init.yml


ansible-playbook -vvv -i $inventory_path $source_directory/ansible-playbook.test0.yml


ansible-playbook -vvv -i $inventory_path $source_directory/ansible-playbook.clean.yml
