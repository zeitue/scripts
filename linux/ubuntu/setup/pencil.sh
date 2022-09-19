#!/bin/bash

echo "Installing Pencil"

URL_PATH=$(
curl https://pencil.evolus.vn/Downloads.html |\
     grep "amd64.deb" |\
     sed -n 's:.*href="\(.*\)">.*:\1:p' |\
     cut -d\" -f1 |\
     head -n1
)

URL="https://pencil.evolus.vn$URL_PATH"
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo apt install -y "./${FILENAME}"
rm "${FILENAME}"


# Add mime type
cat <<EOF | sudo dd status=none of="/usr/share/mime/packages/epgz.xml"
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
	<mime-type type="application/epgz">
		<comment>Pencil file</comment>
		<glob pattern="*.epgz"/>
	</mime-type>
</mime-info>
EOF

sudo update-mime-database /usr/share/mime

# Patch desktop file
sudo sed -i 's/pencil$/pencil %F --disable-seccomp-filter-sandbox/g' /usr/share/applications/pencil.desktop

sudo sed -i 's/text\/plain;/application\/epgz;/g' /usr/share/applications/pencil.desktop

sudo update-desktop-database /usr/share/applications/

