#!/bin/bash

# UniFlash

URL=$(curl https://www.ti.com/tool/UNIFLASH | \
      grep uniflash | \
      grep run | \
      sed -n 's:.*href="\(.*\)">.*:\1:p' | \
      cut -d\" -f1 | \
      head -n1)

echo "Installing UniFlash"
VERSION=$(basename `dirname $URL`)
PREFIX="/opt/ti/uniflash_$VERSION/"
PREVIOUS=$(pwd)
mkdir tmp
cd tmp
wget -c "$URL"
chmod +x *.run
sudo apt install -y libusb-0.1-4
sudo ./*.run --unattendedmodeui none --mode unattended --prefix "$PREFIX"

sudo mkdir -p /usr/local/share/applications

sudo find "$PREFIX" -name  'UniFlash*.desktop' \
      -exec ln -sf {} "/usr/local/share/applications/UniFlash_$VERSION.desktop" \;


# Fix missing link
if [ ! $(/sbin/ldconfig -p|grep 'libudev.so.0 .*64') ]; then
  #64-bit libudev.so.0 is not present
  UDEVPATH=`ldconfig -p|grep 'libudev.so.1 .*64'|awk '{print $NF}'`
  if [ ! -z "$UDEVPATH" ]; then
    #64-bit libudev.so.1 is present, create the symlink
    CA_UDEV_LINK=`dirname $UDEVPATH`/libudev.so.0
    if [ ! -f $CA_UDEV_LINK ]; then
      sudo ln -s $UDEVPATH $CA_UDEV_LINK
    fi
  fi
fi

# enable permissions
sudo "$PREFIX/deskdb/content/TICloudAgent/linux/ticloudagent/setup/install.sh" --install
sudo "$PREFIX/simplelink/imagecreator/installscripts/ti_debug_probes_linux_install.sh"
sudo "$PREFIX/simplelink/imagecreator/installscripts/usb_linux_install.sh"

# Remove installer

cd "$PREVIOUS"
rm -Rf ./tmp
