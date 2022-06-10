#!/bin/bash

echo "Code Composter Studio"

URL=$(curl https://www.ti.com/tool/download/CCSTUDIO |\
      grep linux |\
      sed -n 's:.*href="\(.*\)">.*:\1:p' |\
      cut -d\" -f1 |\
      head -n1
)

sudo apt install -y libusb-0.1-4 python3

mkdir tmp
PREVIOUS=$(pwd)
cd tmp
FILENAME=$(basename "$URL")
DIRNAME=${FILENAME//.tar.gz}
wget -c "$URL"

tar -xf "./$FILENAME"
cd "$DIRNAME"


sudo ./*.run --mode unattended \
     --install-BlackHawk true \
     --install-Segger true\
     --enable-components PF_MSP430,PF_MSP432,PF_CC2X,PF_CC3X,PF_CC2538,PF_C28,\
PF_TM4C,PF_HERCULES,PF_SITARA,PF_SITARA_MCU,PF_OMAPL,PF_DAVINCI,PF_OMAP,\
PF_TDA_DRA,PF_C55,PF_C6000SC,PF_C66AK_KEYSTONE,PF_MMWAVE,PF_C64MC,\
PF_DIGITAL_POWER,PF_PGA

# Link the desktop file, who knows why they don't do this by default
sudo ln -s -f /opt/ti/ccs*/*.desktop /usr/local/share/applications/
cd "$PREVIOUS"
rm -Rf tmp

