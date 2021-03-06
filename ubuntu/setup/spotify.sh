#!/bin/bash

# Spotify

echo "Installing Spotify"

wget -qO - https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/spotify.gpg

echo "deb http://repository.spotify.com stable non-free" |\
  sudo dd status=none of=/etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install -y spotify-client
