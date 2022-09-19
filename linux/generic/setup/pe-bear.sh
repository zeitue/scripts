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

echo "Installing PE-bear"


URL=$(getLatest hasherezade/pe-bear 5_x64_linux.tar.xz)
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo install -d /opt/pe-bear/
tar -xf "$FILENAME" -C /opt/pe-bear/
rm "./$FILENAME"

# Add desktop file
sudo wget -c https://github.com/hasherezade/pe-bear/raw/ee1e92a6d45cd099f2a0cfce52e31259ba4527f7/logo/main_ico.png -P /opt/pe-bear/
cat <<EOF | sudo dd status=none of=/usr/local/share/applications/pe-bear.desktop
[Desktop Entry]
Version=1.0
Name=PE-bear
Exec=/opt/pe-bear/PE-bear %U
Path=/opt/pe-bear
Terminal=false
Type=Application
Icon=/opt/pe-bear/main_ico.png
Comment=PE-bear is a multiplatform reversing tool for PE files
Keywords=PE files;reverse engineering tool;
Categories=Development;
EOF