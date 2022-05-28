#!/bin/bash

echo "Install Pico-SDK"
sudo apt install -y build-essential git cmake
sudo git clone https://github.com/raspberrypi/pico-sdk.git /opt/pico-sdk
sudo git -C /opt/pico-sdk submodule update --init
echo 'export PICO_SDK_PATH=/opt/pico-sdk' |\
      sudo dd status=none of="/etc/profile.d/pico-sdk.sh"
