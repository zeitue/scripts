#!/bin/bash

# Signal Desktop

echo "Installing Signal Desktop"

# 1. Install our official public software signing key
wget -qO - https://updates.signal.org/desktop/apt/keys.asc |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/signal-desktop.gpg

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo dd status=none of=/etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update
sudo apt install -y signal-desktop

# fix Signal desktop not showing in the system tray
sudo mkdir -p /usr/local/share/applications
cat <<EOF | sudo dd status=none of=/usr/local/share/applications/signal-desktop.desktop
[Desktop Entry]
Name=Signal
Exec=/opt/Signal/signal-desktop --start-in-tray --use-tray-icon --no-sandbox %U
Terminal=false
Type=Application
Icon=signal-desktop
StartupWMClass=Signal
Comment=Private messaging from your desktop
MimeType=x-scheme-handler/sgnl;
Categories=Network;InstantMessaging;Chat;
EOF
