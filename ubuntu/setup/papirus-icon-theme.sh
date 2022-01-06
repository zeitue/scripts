#!/bin/bash

echo "Installing Papirus Icon Theme"
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt-get update
sudo apt-get install -y papirus-icon-theme

