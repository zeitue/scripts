#!/bin/bash

# Bash

sudo apt install -y bash git wget

# Oh My Bash

git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
cp ~/.bashrc ~/.bashrc.orig
cp ~/.oh-my-bash/templates/bashrc.osh-template ~/.bashrc

sed -i -e 's/font/pure/g' ~/.bashrc
sed -i -e 's/OSH=.*$/OSH=\"$HOME\/.oh-my-bash\"/g' ~/.bashrc
sudo cp -R ~/.oh-my-bash /etc/skel/
sudo cp ~/.bashrc /etc/skel/

