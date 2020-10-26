#!/bin/bash

# Caja extensions
if [ -e /usr/bin/caja ]; then
    sudo apt install -y caja-open-terminal caja-rename caja-sendto\
    caja-mediainfo caja-image-converter caja-eiciel caja-gtkhash\
    caja-xattr-tags caja-nextcloud
fi

# Nemo extensions
if [ -e /usr/bin/nemo ]; then
    sudo apt install -y nemo-audio-tab nemo-emblems nemo-gtkhash\
    nemo-image-converter nemo-python nemo-nextcloud
fi


# Nautilus extensions
if [ -e /usr/bin/nautilus ]; then
    sudo apt install -y rabbitvcs-nautilus nautilus-nextcloud\
    nautilus-extension-gnome-terminal\
    nautilus-image-converter nautilus-sendto nautilus-gtkhash
fi

# Thumbnailers
sudo apt install -y exe-thumbnailer ooo-thumbnailer ffmpegthumbnailer
