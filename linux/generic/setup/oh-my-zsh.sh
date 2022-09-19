#!/bin/bash

# Setup Oh My Zsh
echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i -e 's/ZSH=.*$/ZSH=\"$HOME\/.oh-my-zsh\"/g' ~/.zshrc
sed -i -e 's/robbyrussell/pygmalion/g' ~/.zshrc
sudo cp -R ~/.oh-my-zsh /etc/skel/
sudo cp ~/.zshrc /etc/skel/
