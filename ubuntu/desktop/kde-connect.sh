#!/bin/bash

# KDE Connect

echo "Installing KDE Connect"

sudo apt install -y kdeconnect

# Open ports for KDE Connect
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp
sudo ufw reload
