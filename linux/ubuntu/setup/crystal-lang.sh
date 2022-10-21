#!/bin/bash

echo "Installing Crystal"

VERSION_ID=$(awk -F= '$1 == "VERSION_ID" {gsub(/"/, "", $2); print $2}' /etc/os-release)
REPOSITORY="xUbuntu_${VERSION_ID}"

echo "deb http://download.opensuse.org/repositories/devel:/languages:/crystal/${REPOSITORY}/ /" |\
 sudo dd status=none of="/etc/apt/sources.list.d/crystal.list"

# Add signing key
curl -fsSL "https://download.opensuse.org/repositories/devel:languages:crystal/${REPOSITORY}/Release.key" |\
    gpg --dearmor |\
    sudo dd status=none of="/etc/apt/trusted.gpg.d/crystal.gpg"

sudo apt update
sudo apt -y install crystal libssl-dev libxml2-dev libyaml-dev libgmp-dev libz-dev
