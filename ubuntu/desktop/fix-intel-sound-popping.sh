#!/bin/bash

echo "Fixing sound popping issue"
echo "options snd_hda_intel power_save=0" |\
    sudo dd status=none of=/etc/modprobe.d/audio_disable_powersave.conf
