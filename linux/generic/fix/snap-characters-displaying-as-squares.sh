#!/bin/bash

echo "Fixing characters displaying as squares"

rm -Rf ~/.cache/fontconfig 
sudo fc-cache -r -v

find ~/snap/ -name 'fontconfig' -exec rm -Rf {} \;

