#!/bin/bash

echo "Installing Corectrl"

cat <<EOF | sudo dd status=none of="/etc/apt/preferences.d/corectrl"
# Never prefer packages from the ernstp repository
Package: *
Pin: release o=LP-PPA-ernstp-mesarc
Pin-Priority: 1

# Allow upgrading only corectrl from LP-PPA-ernstp-mesarc
Package: corectrl
Pin: release o=LP-PPA-ernstp-mesarc
Pin-Priority: 500
EOF

cat <<EOF | sudo dd status=none of="/etc/polkit-1/localauthority/50-local.d/90-corectrl.pkla"
[User permissions]
Identity=unix-group:sudo;unix-group:admin
Action=org.corectrl.*
ResultActive=yes
EOF


sudo add-apt-repository -y ppa:ernstp/mesarc
sudo apt -y install corectrl
