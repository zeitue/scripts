#!/bin/bash

echo "Installing Liquorix Kernel"

sudo add-apt-repository -y ppa:damentz/liquorix
sudo apt update

sudo apt install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
