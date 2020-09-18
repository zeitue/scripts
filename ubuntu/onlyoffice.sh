#!/bin/bash

# ONLYOFFICE Desktop Editors
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice-desktopeditors.list
sudo apt update
sudo apt install -y onlyoffice-desktopeditors
