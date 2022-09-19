#!/bin/bash


function make_link_if() {
    if [[ ! -h "$2" && ! -d "$2" && ! -f "$2" ]]; then
        sudo ln -s "$1" "$2"
    fi
}

echo "Installing Base system requirements"
sudo apt install -y git curl wget apt-transport-https bash zsh \
                    build-essential procps file rlwrap

echo "Setting up /usr/local"
# Setup /usr/local
sudo install -d /usr/local
sudo install -d /usr/local/bin
sudo install -d /usr/local/sbin
sudo install -d /usr/local/games
sudo install -d /usr/local/etc
sudo install -d /usr/local/include
sudo install -d /usr/local/src
sudo install -d /usr/local/lib
sudo install -d /usr/local/lib32
sudo install -d /usr/local/lib64
sudo install -d /usr/local/libexec
sudo install -d /usr/local/share
sudo install -d /usr/local/share/man
sudo install -d /usr/local/share/doc
sudo install -d /usr/local/share/info
sudo install -d /usr/local/share/pixmaps
sudo install -d /usr/local/share/applications
sudo install -d /usr/local/share/icons

# Add links
cd /usr/local
make_link_if share/man man
make_link_if share/doc doc
make_link_if share/info info
cd $OLDPWD
