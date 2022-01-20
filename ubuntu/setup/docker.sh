#!/bin/bash

# Docker

## Note: only LTS releases are supported
echo "Installing Docker"
RELEASE=$(lsb_release -cs)

# Install dependencies
sudo apt-get install -y apt-transport-https ca-certificates \
                        gnupg-agent software-properties-common curl

# Add repository
wget -qO - "https://download.docker.com/linux/ubuntu/gpg" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/docker.gpg
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable" |\
    sudo dd status=none of=/etc/apt/sources.list.d/docker.list


# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Add user to group
sudo usermod -a -G docker $USER

