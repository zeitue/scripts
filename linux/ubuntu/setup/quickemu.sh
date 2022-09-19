#!/bin/bash

echo "Installing Quickemu"

sudo apt-add-repository -y ppa:flexiondotorg/quickemu
sudo add-apt-repository -y ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install -y quickemu quickgui
