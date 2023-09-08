#!/bin/bash

source_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

seed_workpath="$(realpath $source_directory/../)"

ansible-playbook -K $seed_workpath/ansible-playbook/seed-wsl/wsl-automount.metadata.yml
ansible-playbook -K $seed_workpath/ansible-playbook/seed-wsl/wsl-windowspath.disable.yml
