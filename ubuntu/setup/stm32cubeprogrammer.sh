#!/bin/bash

WORK=$(pwd)
mkdir "$WORK/Downloads"
echo "Downloads STM32CubeProgrammer from: https://www.st.com/en/development-tools/stm32cubeprog.html"
echo "And place the file into this directory $WORK/Downloads"
echo "Press enter when finished: "
read
cd "$WORK/Downloads"
unzip *.zip


# Install STM32CubeProgrammer
sudo ./SetupSTM32CubeProgrammer-*.linux

# make sure directory exists
sudo mkdir -p /usr/local/share/applications
sudo mv /root/Desktop/STM32CubeProgrammer.desktop /usr/local/share/applications
sudo mv /root/Desktop/STM32TrustedPackageCreator.desktop /usr/local/share/applications
sudo chmod 644 /usr/local/share/applications/STM32CubeProgrammer.desktop
sudo chmod 644 /usr/local/share/applications/STM32TrustedPackageCreator.desktop

sudo cp /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules/*.rules /etc/udev/rules.d/

cd "$WORK"
rm -Rf "$WORK/Downloads"

