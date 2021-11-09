#!/bin/bash

# LibreOffice
echo "Installing LibreOffice"
sudo add-apt-repository -y "ppa:libreoffice/ppa"
sudo apt update
sudo apt install -y libreoffice
sudo apt upgrade -y libreoffice
