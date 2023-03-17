#!/bin/bash

echo "Installing Glow"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" |\
    sudo dd status=none of=/etc/apt/sources.list.d/charm.list
sudo apt update
sudo apt -y install glow
