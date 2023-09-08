#!/bin/bash

sudo update-ca-certificates --fresh
sudo apt install -y python3-pip
sudo pip config set global.break-system-packages true
pip3 config set global.break-system-packages true
pip3 install --upgrade pip
pip3 install ansible

source ~/.profile
ansible --version