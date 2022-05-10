#!/bin/bash

UBUNTU_VERSION=$(awk -F= '$1 == "UBUNTU_CODENAME" {gsub(/"/, "", $2); print $2}' /etc/os-release)

echo "Installing Wine"

# enable 32 bit support
sudo dpkg --add-architecture i386

# Add key
wget -qO - "https://dl.winehq.org/wine-builds/winehq.key" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/winehq.gpg


# Add repository
sudo add-apt-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ ${UBUNTU_VERSION} main"

sudo apt update

# Install Wine stable
sudo apt install -y --install-recommends winehq-stable

# Register binfmt
cat <<EOF | sudo dd status=none of="/etc/binfmt.d/wine.conf"
# Start WINE on Windows executables
:DOSWin:M::MZ::/usr/bin/wine:
EOF

# restart binfmt
sudo systemctl restart systemd-binfmt.service


# Add desktop integration
wget -c  https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/w/wine-installer/wine-desktop-files_5.0.3_all.deb
sudo apt install ./wine-desktop-files*.deb
rm wine-desktop-files*.deb

