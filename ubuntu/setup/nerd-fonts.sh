#!/bin/bash

echo "Installing nerd-fonts"
cd /usr/src/
sudo git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
sudo ./install.sh --install-to-system-path
cd

