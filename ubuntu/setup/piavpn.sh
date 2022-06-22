#!/bin/bash

echo "Installing Private Internet Access"

URL=$(curl https://www.privateinternetaccess.com/download |\
     grep "pia-linux" |\
     sed -n 's:.*href="\(.*\)">.*:\1:p' |\
     cut -d\" -f1 |\
     head -n1
)
FILENAME=$(basename "$URL")
wget -c "$URL"
chmod +x "$FILENAME"
"./$FILENAME"
rm "./$FILENAME"
