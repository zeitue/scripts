#!/bin/bash

echo "Installing Hiri"
wget -c https://feedback.hiri.com/downloads/Hiri.tar.gz
sudo mkdir /opt/hiri
sudo tar -xf Hiri.tar.gz -C /opt/hiri/
sudo ln -s /opt/hiri/hiri_?.?.?.? /opt/hiri/current

sudo mkdir -p /usr/local/share/applications
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/hiri.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=Hiri
GenericName=Mail Client
Comment=Hiri Email client
Categories=Office;Network;Email;Calendar;
Keywords=Email;E-mail;Calendar;Contacts;Terminal=false
StartupNotify=true
MimeType=x-scheme-handler/mailto;
Exec="/opt/hiri/current/hiri.sh" %u
Icon=/opt/hiri/current/hiri.png
EOF

rm ./Hiri.tar.gz

