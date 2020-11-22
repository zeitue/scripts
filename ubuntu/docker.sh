#!/bin/bash

# Docker

## Note: only LTS releases are supported
echo "Installing Docker"
RELEASE=$(awk -F= '$1 == "UBUNTU_CODENAME" {gsub(/"/, "", $2); print $2}' /etc/os-release)

# Install dependencies
sudo apt-get install -y apt-transport-https ca-certificates \
                        gnupg-agent software-properties-common

# Add repository
wget -qO - "https://download.docker.com/linux/ubuntu/gpg" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/docker.gpg
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable" |\
    sudo dd status=none of=/etc/apt/sources.list.d/docker.list


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
