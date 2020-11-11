#!/bin/bash

# VirtualBox
VERSION=6.1
UBUNTU_VERSION=$(awk -F= '$1 == "UBUNTU_CODENAME" {gsub(/"/, "", $2); print $2}' /etc/os-release)
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $UBUNTU_VERSION contrib" |\
sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update
sudo apt install -y "virtualbox-${VERSION}"
