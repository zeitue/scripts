#!/bin/bash

echo "Installing Tailscale"
VERSION=$(lsb_release -c | cut -f 2)
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$VERSION.noarmor.gpg |\
    sudo dd status=none of=/usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$VERSION.tailscale-keyring.list |\
    sudo dd status=none of=/etc/apt/sources.list.d/tailscale.list

sudo apt update
sudo apt install -y tailscale
