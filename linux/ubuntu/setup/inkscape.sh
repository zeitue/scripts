#!/bin/bash

echo "Installing Inkscape"
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt update
sudo apt install -y inkscape
