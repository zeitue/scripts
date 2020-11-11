#!/bin/bash

# Microsoft Teams

# Add Repository
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'

# Install
sudo apt update
sudo apt install -y teams

