#!/bin/bash

# Microsoft Teams

# Add Repository

echo "Installing Microsoft Teams"

wget -qO - "https://packages.microsoft.com/keys/microsoft.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/microsoft.gpg

echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/teams.list

# Install
sudo apt update
sudo apt install -y teams

