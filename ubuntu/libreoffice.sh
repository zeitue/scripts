#!/bin/bash

# LibreOffice
VERSION=7-0
sudo add-apt-repository -y "ppa:libreoffice/libreoffice-${VERSION}"
sudo apt update
sudo apt install -y libreoffice
sudo apt upgrade -y libreoffice
