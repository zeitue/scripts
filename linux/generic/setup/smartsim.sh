#!/bin/bash

echo "Installing SmartSim"

FILE_PATH=$(curl https://www.smartsim.org.uk/downloads/ |\
    grep "href=\"/download" |\
    sed -n 's:.*href="\(.*\)">.*:\1:p' |\
    grep linux_x86_64.tar.gz)
URL="https://www.smartsim.org.uk${FILE_PATH}"
FILENAME=$(basename "$URL")
wget -c "$URL"

sudo tar -xf "./$FILENAME" -C /opt

cat <<EOF | sudo dd status=none of=/usr/local/share/applications/smartsim.desktop
[Desktop Entry]
Version=1.0
Name=SmartSim
Exec=/opt/smartsim/smartsim %U
Path=/opt/smartsim
Terminal=false
Type=Application
Icon=/opt/smartsim/resources/images/icons/smartsim64.png
Comment=SmartSim is a free and open source digital logic circuit design and simulation package.
Keywords=simulation;electronics;engineering;
Categories=Utility;
EOF

rm "./$FILENAME"
