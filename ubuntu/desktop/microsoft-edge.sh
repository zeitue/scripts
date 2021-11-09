#!/bin/bash

# Microsoft Edge

# Setup repository

echo "Installing Microsoft Edge"

wget -qO - "https://packages.microsoft.com/keys/microsoft.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/microsoft.gpg

echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/microsoft-edge.list

# Install
sudo apt update
sudo apt install -y microsoft-edge-stable

