#!/bin/bash

# Balena Etcher

echo "Installing Balena Etcher"

curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash

sudo apt update
sudo apt install -y balena-etcher-electron


