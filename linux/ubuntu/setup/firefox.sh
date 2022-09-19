#!/bin/bash

if [ -d /snap/firefox ]; then
    echo "Removing snap firefox"
    sudo snap remove firefox
fi

sudo add-apt-repository -y ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo dd status=none of=/etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' |\
    sudo dd status=none of=/etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt -y install firefox
