#!/bin/bash

set -e

if [[ -n "$(command -v update-ca-certificates)" ]];
then
    sudo update-ca-certificates --fresh
fi
sudo apt update
sudo apt install -y python3-pip
sudo pip config set global.break-system-packages true
pip config set global.break-system-packages true
pip install --upgrade pip
pip install ansible

source ~/.profile
ansible --version