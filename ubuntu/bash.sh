#!/bin/bash

# Bash

sudo apt install -y bash

# Bash-it

git clone --depth=1 "https://github.com/Bash-it/bash-it.git" ~/.bash_it
~/.bash_it/install.sh --silent
sed -i -e 's/bobby/pure/g' ~/.bashrc
sed -i -e 's/BASH_IT=.*$/BASH_IT=\"$HOME\/.bash_it\"/g' ~/.bashrc
sudo cp -R ~/.bash_it /etc/skel/
sudo cp ~/.bashrc /etc/skel/
