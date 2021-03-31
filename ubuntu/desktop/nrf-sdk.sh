#!/bin/bash

# nRF SDK

export SDK="v1.4.2"
export NRFCONNECT_URL="https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-Connect-for-Desktop/3-6-1/nrfconnect361x8664.AppImage"
export GNUARMEMB_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2"
export SEGGER_URL="https://segger.com/downloads/embedded-studio/embeddedstudio_arm_nordic_linux_x64"
export SHGROUP="users"

if [[ ! -d /Applications ]]; then
  sudo mkdir /Applications
  sudo chmod 775 /Applications
  sudo chown root:users /Applications
fi

wget -c "$NRFCONNECT_URL" -P /Applications/
chmod +x /Applications/nrfconnect*.AppImage

# toolchain
sudo apt install -y git wget cmake ninja-build gperf ccache dfu-util\
                    device-tree-compiler python3-pip python3-setuptools\
                    python3-wheel xz-utils file make gcc-multilib python3-venv\
                    gcc libpq-dev python3-dev zenity

wget -c "$GNUARMEMB_URL"
tar -xf gcc-arm-none-eabi-*-update-linux.tar.bz2
sudo mv gcc-arm-none-eabi-*-update /opt/gnuarmemb
sudo chown -R root:root /opt/gnuarmemb
rm gcc-arm-none-eabi-*-update-linux.tar.bz2


# connected home
sudo mkdir /opt/gn
wget -O gn.zip https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-amd64/+/latest
sudo unzip gn.zip -d /opt/gn
rm gn.zip
sudo chmod +x /opt/gn/gn
sudo ln -s /opt/gn/gn /usr/local/bin/gn

# SDK
sudo mkdir /opt/Nordic
sudo mkdir /opt/Nordic/SDKs
sudo mkdir /opt/Nordic/IDEs
sudo mkdir /opt/Nordic/Projects
sudo chmod -R 775 /opt/Nordic
sudo chown -R root:"$SHGROUP" /opt/Nordic

# make sure user is a part of the group
sudo usermod -a -G "$SHGROUP" $USER

cd /opt/Nordic/SDKs
python3 -m venv "$SDK"
cd "/opt/Nordic/SDKs/$SDK"
source bin/activate
pip3 install west wheel
west init -m https://github.com/nrfconnect/sdk-nrf
west update
west zephyr-export

cd nrf
git checkout "$SDK"
west update

cd ../
pip3 install -r zephyr/scripts/requirements.txt
pip3 install -r nrf/scripts/requirements.txt
pip3 install -r bootloader/mcuboot/scripts/requirements.txt

# Segger IDE
cd
wget -c --content-disposition "$SEGGER_URL"
file=$(echo EmbeddedStudio_ARM_Nordic_*_linux_x64.tar.gz)
version=$(echo ${file%"_linux_x64.tar.gz"})
version=$(echo ${version#"EmbeddedStudio_ARM_Nordic_"})
sudo tar -xf "$file" -C "/opt/Nordic/IDEs/"
sudo mv "/opt/Nordic/IDEs/arm_segger_embedded_studio_${version}_linux_x64_nordic" \
        "/opt/Nordic/IDEs/${version}"
rm $file

# add desktop files
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/arm_segger_embedded_studio_${version}.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Segger Embedded Studio (Nordic) ($version)
Exec=/opt/Nordic/IDEs/$version/bin/emStudio.sh
Comment=Segger Embedded Studio For Nordic
Terminal=false
Icon=/opt/Nordic/IDEs/$version/bin/StudioIcon.png
Type=Application
Categories=Programming;IDE
Hidden=false
NoDisplay=false
StartupWMClass=SEGGER Embedded Studio
EOF



cat <<EOF | sudo dd status=none of="/opt/Nordic/IDEs/${version}/bin/emStudio.sh"
#!/bin/bash
sdks=()
for entry in /opt/Nordic/SDKs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done
sdk_choice=\$(zenity --list --title "SDK version" --column="SDK Version" \${sdks[@]})

source "/opt/Nordic/SDKs/\$sdk_choice/bin/activate"
/opt/Nordic/IDEs/${version}/bin/emStudio

EOF

sudo chmod +x "/opt/Nordic/IDEs/${version}/bin/emStudio.sh"

# seems permissions don't stick on some system
sudo chmod -R 775 /opt/Nordic
sudo chown -R root:"$SHGROUP" /opt/Nordic


