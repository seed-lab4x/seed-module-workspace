#!/bin/bash

set -e

[[ -z "$(command -v ansible-playbook)" ]] && source ~/.profile

source_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

seed_workpath="$(realpath $source_directory/../)"

ansible-playbook -K $seed_workpath/ansible-playbook/seed-wsl/wsl-windowspath.disable.yml

echo "NOTE: need reboot wsl"

# sudo touch /var/run/reboot-required
# sudo killall -r '.*'
if [[ -n "$(command -v wsl.exe)" ]];
then
    echo "terminate wsl $WSL_DISTRO_NAME"
    wsl.exe --terminate $WSL_DISTRO_NAME
else
    echo "You need exit wsl and run 'wsl --shutdown' or 'wsl --terminate $WSL_DISTRO_NAME'"
fi
