#!/bin/bash

echo "Installing PowerShell"

VERSION_ID=$(awk -F= '$1 == "VERSION_ID" {gsub(/"/, "", $2); print $2}' /etc/os-release)

curl -o microsoft.list "https://packages.microsoft.com/config/ubuntu/${VERSION_ID}/prod.list"
sudo mv microsoft.list /etc/apt/sources.list.d/microsoft-prod.list

curl -sSL https://packages.microsoft.com/keys/microsoft.asc |\
gpg --dearmor |\
sudo dd status=none of=/etc/apt/trusted.gpg.d/microsoft.gpg

sudo apt update
sudo apt install -y powershell
