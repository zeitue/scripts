#!/bin/bash

echo "Installing WPS"

PAGE=$(curl "https://www.wps.com/")


LINKS=$(echo $PAGE |\
        grep -io '<link rel="preload" href=['"'"'"][^"'"'"']*['"'"'"]' |\
        sed -e 's/^<link rel="preload" href=["'"'"']//i' -e 's/["'"'"']$//i')
JS=$(curl $JS)
URL=$(echo $JS |\
      tr ',' '\n' |\
      grep linux_deb\: |\
      grep -o -P '(?<=linux_deb:\").*(?=\")' |\
      head -n1
)
FILENAME=$(basename "$URL")
wget -c "$URL"
# Accept license for MS fonts
echo msttcorefonts msttcorefonts/accepted-mscorefonts-eula select true |\
    sudo debconf-set-selections

sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
