#!/bin/bash

# nRF Command Line Tools
URL="https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-11-1/nRFCommandLineTools10111Linuxamd64tar.gz"

# Setup
sudo mkdir -p /usr/local/share/applications
sudo mkdir -p /usr/local/share/pixmaps
mkdir nrf-cmd
cd nrf-cmd

# Download
wget -c  --content-disposition $URL
tar -xf nRF-Command-Line-Tools_*_Linux-amd64.tar.gz


# Install
sudo apt install -y ./*.deb

# Cleanup
cd ../
rm -Rf nrf-cmd


# Add icons and launchers
sudo install ./resources/icons/jlink.png /usr/local/share/pixmaps

for EXE in $(ls -1 /opt/SEGGER/JLink/*Exe);do
echo $EXE;
WMCLASS=$(basename $EXE)
NAME=${WMCLASS::-3}
cat <<EOF | sudo tee "/usr/local/share/applications/${WMCLASS}.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=$NAME
Exec=$EXE
Icon=/usr/local/share/pixmaps/jlink.png
Terminal=false
Type=Application
Categories=Development;
StartupNotify=true
Keywords=IDE;development;programming;
StartupWMClass=$WMCLASS
EOF
done

