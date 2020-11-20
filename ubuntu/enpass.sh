#!/bin/bash

# Enpass

sudo sh -c 'echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list'
wget -qO - https://apt.enpass.io/keys/enpass-linux.key | gpg --dearmor > enpass.gpg
sudo install -o root -g root -m 644 enpass.gpg /etc/apt/trusted.gpg.d/
rm enpass.gpg
sudo apt update
sudo apt install -y enpass
