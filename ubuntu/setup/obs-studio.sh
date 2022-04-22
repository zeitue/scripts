#!/bin/bash

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y v4l2loopback-dkms obs-studio

