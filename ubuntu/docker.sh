#!/bin/bash

# Docker

# Install dependencies
sudo apt-get install -y apt-transport-https ca-certificates \
                        curl gnupg-agent software-properties-common

# Add repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y\
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(awk -F= '$1 == "UBUNTU_CODENAME" {gsub(/"/, "", $2); print $2}' /etc/os-release) \
   stable"

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Add users to group
if groups $USER | grep -q '\bdomain users\b'; then
    for u in $(wbinfo -u); do
        sudo usermod -a -G docker $u;
    done
else
    sudo usermod -a -G docker $USER
fi
