#!/bin/bash

echo "Installing Qucs-S"

VERSION_ID=$(awk -F= '$1 == "VERSION_ID" {gsub(/"/, "", $2); print $2}' /etc/os-release)

echo "deb http://download.opensuse.org/repositories/home:/ra3xdh/xUbuntu_${VERSION_ID}/ /" |\
 sudo dd status=none of="/etc/apt/sources.list.d/home:ra3xdh.list"
curl -fsSL "https://download.opensuse.org/repositories/home:ra3xdh/xUbuntu_${VERSION_ID}/Release.key" |\
 gpg --dearmor | sudo dd status=none of="/etc/apt/trusted.gpg.d/home_ra3xdh.gpg"

sudo apt update
sudo apt -y install qucs-s ngspice
