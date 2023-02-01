#!/bin/bash

CURRENT="$(pwd)"
mkdir "${CURRENT}/chitubox-tmp"
cd "${CURRENT}/chitubox-tmp"
echo "Download chitubox from https://www.chitubox.com/en/download/chitubox-free"
xdg-open "https://www.chitubox.com/en/download/chitubox-free" &
echo "Press enter after you place the chitubox file in the folder ${CURRENT}/chitubox-tmp"
sudo mkdir /opt/chitubox
sudo tar -xf *.tar.gz -C /opt/chitubox

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/chitubox.desktop"
[Desktop Entry]
Name=Chitubox
Comment=SLA 3D Printer Slicer
Type=Application
Categories=Graphics;3DGraphics;
Icon=/opt/chitubox/resource/ico/freeIcon.ico
Terminal=false
Exec=env LD_LIBRARY_PATH="/opt/chitubox/lib/:$LD_LIBRARY_PATH" /opt/chitubox/CHITUBOX
EOF

echo "Installing Chitubox"
cd "$CURRENT"
rm -Rf "${CURRENT}/chitubox-tmp"

# # get the html
# HTML=$(curl https://www.chitubox.com/en/download/chitubox-free)

# # download all javascript from website
# JS=$(echo "$HTML" |\
#      grep -Eo "<script.*(</script>|>)" |\
#      grep -o '"[^"]*"' |\
#      tr -d '"'  | grep .js | grep -v '/')

# JSFILES=$(for i in $JS; do curl "https://www.chitubox.com/$i"; done)

# softwareId
# mainstreamProductInfo&&(" to "

# ID=$(
#     echo $JSFILES |\
#     grep -oP "(?<=\"\=\=\=r\.mainstreamProductInfo\.softwareId\|\|\")(.*)(?=\"\=\=\=r)" |\
#     cut -d\" -f1
# )

# VERSION=$(
#     echo $HTML |\
#     grep -Eo "stableVersion\&q\;\:\&q\;.+\&q\;" |\
#     grep -o '[^stableVersion\&q\;\:\&q\;]*\&q\;' |\
#     grep -o -P '(?<=v).*(?=\&)' |\
#     grep '\.' |\
#     head -n1
# )

# URL="https://sac.chitubox.com/software/download.do?softwareId=${ID}&softwareVersionId=v${VERSION}&fileName=CHITUBOX_V${VERSION}.tar.gz"
# FILENAME="CHITUBOX_V${VERSION}.tar.gz"
# wget -c --content-disposition "$URL"
