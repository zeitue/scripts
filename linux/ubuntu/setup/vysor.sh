#!/bin/bash

echo "Installing Vysor"
echo 'deb [arch=amd64, trusted=yes] https://nuts.vysor.io/apt ./' |\
sudo dd status=none of=/etc/apt/sources.list.d/vysor.list
sudo apt update
sudo apt -y install vysor
