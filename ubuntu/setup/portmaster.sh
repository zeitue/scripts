#!/bin/bash

echo "Installing Portmaster"
wget -c "https://updates.safing.io/latest/linux_amd64/packages/portmaster-installer.deb"
sudo apt install -y ./portmaster-installer.deb
#rm ./portmaster-installer.deb
