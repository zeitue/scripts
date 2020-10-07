#!/bin/bash

# Zsh
sudo apt install -y --install-recommends zsh

# Setup Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i -e 's/ZSH=.*$/ZSH=\"$HOME\/.oh-my-zsh\"/g' ~/.zshrc
sed -i -e 's/robbyrussell/pygmalion/g' ~/.zshrc
sudo cp -R ~/.oh-my-zsh /etc/skel/
sudo cp ~/.zshrc /etc/skel/

