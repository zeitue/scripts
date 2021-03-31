#!/bin/bash

# UniFlash

VERSION="6.1.0.2829"
SHORT_VERSION="${VERSION%.*}"
PREFIX="/opt/ti/uniflash_${SHORT_VERSION}"

echo "Installing UniFlash ${VERSION}"

VERSION="6.1.0.2829"
SHORT_VERSION="${VERSION%.*}"
PREFIX="/opt/ti/uniflash_${SHORT_VERSION}"
wget -c "https://software-dl.ti.com/ccs/esd/uniflash/uniflash_sl.${VERSION}.run"

sudo apt install -y libusb-0.1-4 libpython2.7 libc6:i386

sudo mkdir -p /usr/local/share/applications

chmod +x "uniflash_sl.${VERSION}.run"
sudo ./uniflash_sl.6.1.0.2829.run --unattendedmodeui none --mode unattended --prefix $PREFIX

# Add Menu entry
sudo ln -s "/opt/ti/uniflash_${SHORT_VERSION}/UniFlash.desktop" "/usr/local/share/applications/UniFlash-${SHORT_VERSION}.desktop"

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
sudo $PREFIX/deskdb/content/TICloudAgent/linux/ticloudagent/setup/install.sh --install
sudo $PREFIX/simplelink/imagecreator/installscripts/ti_debug_probes_linux_install.sh
sudo $PREFIX/simplelink/imagecreator/installscripts/usb_linux_install.sh

# Remove installer

rm "uniflash_sl.${VERSION}.run"
