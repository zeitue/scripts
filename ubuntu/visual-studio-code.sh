#!/bin/bash

# Visual Studio Code

echo "Installing Visual Studio Code"

wget -qO - "https://packages.microsoft.com/keys/microsoft.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/packages.microsoft.gpg

echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/vscode.list

sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y code
