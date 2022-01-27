#!/bin/bash

# Caja extensions
if [ -e /usr/bin/caja ]; then
  echo "Installing Caja extensions"
  sudo apt install -y caja-open-terminal caja-rename caja-sendto\
    caja-mediainfo caja-image-converter caja-eiciel caja-gtkhash\
    caja-xattr-tags caja-nextcloud
fi

# Nemo extensions
if [ -e /usr/bin/nemo ]; then
  echo "Installing Nemo extensions"
  sudo apt install -y nemo-audio-tab
  sudo apt install -y nemo-emblems
  sudo apt install -y nemo-gtkhash nemo-image-converter\
    nemo-python nemo-nextcloud
fi


# Nautilus extensions
if [ -e /usr/bin/nautilus ]; then
  echo "Installing Nautilus extensions"
  sudo apt install -y rabbitvcs-nautilus nautilus-nextcloud\
    nautilus-extension-gnome-terminal\
    nautilus-image-converter nautilus-sendto nautilus-gtkhash
fi

# Dolphin extensions
if [ -e /usr/bin/dolphin ]; then
  echo "Installing Dolphin extensions"
  sudo apt install -y dolphin-nextcloud\
    dolphin-plugins ffmpegthumbs kio-gdrive
fi

# Thumbnailers
echo "Installing thumbnailers"
if [ -e /usr/bin/nautilus ] || [ -e /usr/bin/nemo ] || [ -e /usr/bin/caja ]; then
  sudo apt install -y exe-thumbnailer ooo-thumbnailer ffmpegthumbnailer
fi

if [ -e /usr/bin/dolphin ]; then
  sudo apt install -y kde-thumbnailer-deb kdesdk-thumbnailers kdegraphics-thumbnailers
fi

