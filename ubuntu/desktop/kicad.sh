#!/bin/bash

# KiCad
echo "Installing KiCad"
VERSION=5.1
sudo add-apt-repository -y "ppa:js-reynaud/kicad-${VERSION}"
sudo apt update
sudo apt install -y --install-recommends kicad
