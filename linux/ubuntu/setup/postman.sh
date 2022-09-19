#!/bin/bash

echo "Installing Postman"

FILENAME=$(curl --remote-name --remote-header-name --write-out "%{filename_effective}"\
 		--silent https://dl.pstmn.io/download/latest/linux64)
sudo tar -xf "./$FILENAME" -C /opt/
rm $FILENAME

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/Postman.desktop"
[Desktop Entry]
Name=Postman
GenericName=Postman
Comment=Testing API
Exec=/opt/Postman/Postman
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/Postman/app/resources/app/assets/icon.png
Categories=Development;WebDevelopment;
StartupWMClass=Postman
StartupNotify=true
EOF
