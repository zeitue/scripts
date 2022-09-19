#!/bin/bash

getLatest() {
  REPO=$1
  SUFFIX=$2
  curl --silent https://api.github.com/repos/$REPO/releases/latest | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(''.join(s['browser_download_url']
for s in x['assets'] if s['name'].endswith('$SUFFIX')))"
}

echo "Installing Neoxa Wallet"
URL=$(getLatest NeoxaChain/Neoxa qt-linux64.zip)
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo unzip "./$FILENAME" -d /usr/local/bin/
rm "./$FILENAME"
sudo curl "https://avatars.githubusercontent.com/u/105069582?s=200&v=4" --output /usr/local/share/pixmaps/neoxa.png
cat <<EOF | sudo dd status=none of=/usr/local/share/applications/neoxa.desktop
[Desktop Entry]
Name=Neoxa
Exec=/usr/local/bin/neoxa-qt %U
Terminal=false
Type=Application
Icon=/usr/local/share/pixmaps/neoxa.png
Comment=Neoxa Core Wallet
Keywords=crypto;coin;blockchain;wallet;
Categories=Utility;
EOF



echo "Installing Neoxa CLI"
URL=$(getLatest NeoxaChain/Neoxa d-linux64.zip)
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo unzip "./$FILENAME" -d /usr/local/bin/
rm "./$FILENAME"
