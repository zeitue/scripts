#!/bin/bash

# KiCad
echo "Installing KiCad"
sudo add-apt-repository -y ppa:kicad/kicad-6.0-releases
sudo apt update
sudo apt install -y --install-recommends kicad

