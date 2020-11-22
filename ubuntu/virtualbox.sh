#!/bin/bash

# VirtualBox
VERSION=6.1
UBUNTU_VERSION=$(awk -F= '$1 == "UBUNTU_CODENAME" {gsub(/"/, "", $2); print $2}' /etc/os-release)

echo "Installing VirtualBox ${VERSION}"

wget -qO - "https://www.virtualbox.org/download/oracle_vbox_2016.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/oracle-vbox-2016.gpg

wget -qO - "https://www.virtualbox.org/download/oracle_vbox.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/oracle-vbox.gpg

echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $UBUNTU_VERSION contrib" |\
    sudo dd status=none of=/etc/apt/sources.list.d/virtualbox.list

sudo apt update
sudo apt install -y "virtualbox-${VERSION}"
