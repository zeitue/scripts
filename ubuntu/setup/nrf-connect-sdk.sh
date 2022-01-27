#!/bin/bash

export SDK="v1.5.0"

export NRFCONNECT_URL=$(echo "https://www.nordicsemi.com`curl https://www.nordicsemi.com/Products/Development-tools/nRF-Connect-for-desktop/Download#infotabs |\
      grep AppImage | grep -o '>.*</span>' | sed 's/\(>\|<\/span>\)//g;s/|/\n/g' | sed -n '2 p'`")
export GNUARMEMB_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
export SEGGER_URL="https://segger.com/downloads/embedded-studio/embeddedstudio_arm_nordic_linux_x64"
export SHGROUP="nordic"

sudo addgroup $SHGROUP


# nRF SDK
echo "Installing nRF Connect SDK"

# install the required tools on Ubuntu
curl https://apt.kitware.com/kitware-archive.sh | sudo bash

sudo apt update
sudo apt install -y --no-install-recommends git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget libncurses5 python3-venv \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
  xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev zenity



# install the GN tool
sudo mkdir /opt/gn
wget -O gn.zip https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-amd64/+/latest
sudo unzip gn.zip -d /opt/gn
rm gn.zip
sudo chmod +x /opt/gn/gn
sudo ln -s /opt/gn/gn /usr/local/bin/gn



if [[ ! -d /Applications ]]; then
  sudo mkdir /Applications
  sudo chmod 777 /Applications
  sudo chown root:users /Applications
fi


wget -c "$NRFCONNECT_URL" -P /Applications/
chmod +x /Applications/nrfconnect-*-x86_64.AppImage


wget -c "$GNUARMEMB_URL"
tar -xf gcc-arm-none-eabi-*-linux.tar.bz2
sudo mv gcc-arm-none-eabi-*major /opt/gnuarmemb
sudo chown -R root:root /opt/gnuarmemb
rm gcc-arm-none-eabi-*-linux.tar.bz2

# SDK
sudo mkdir /opt/nordic
sudo mkdir /opt/nordic/ncs
sudo mkdir /opt/nordic/vscode_nrf
sudo mkdir /opt/nordic/segger_nrf
sudo mkdir /opt/nordic/cli_nrf
sudo chmod -R 775 /opt/nordic
sudo chown -R root:"$SHGROUP" /opt/nordic

# make sure user is a part of the group
sudo usermod -a -G "$SHGROUP" $USER
newgrp $SHGROUP << END

cd /opt/nordic/ncs
python3 -m venv "$SDK"
cd "/opt/nordic/ncs/$SDK"
source bin/activate
pip3 install west wheel
west init -m https://github.com/nrfconnect/sdk-nrf --mr $SDK
west update
west zephyr-export

pip3 install -r zephyr/scripts/requirements.txt
pip3 install -r nrf/scripts/requirements.txt
pip3 install -r bootloader/mcuboot/scripts/requirements.txt
END


# Segger IDE
mkdir /tmp/segger
cd /tmp/segger
wget -c --content-disposition "$SEGGER_URL"
file=$(echo EmbeddedStudio_ARM_Nordic_*_linux_x64.tar.gz)
version=$(echo ${file%"_linux_x64.tar.gz"})
version=$(echo ${version#"EmbeddedStudio_ARM_Nordic_"})
sudo tar -xf "$file" -C "/opt/nordic/segger_nrf/"
sudo mv "/opt/nordic/segger_nrf/arm_segger_embedded_studio_${version}_linux_x64_nordic" \
        "/opt/nordic/segger_nrf/${version}"
cd
rm -Rf /tmp/segger

# add desktop files
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/arm_segger_embedded_studio_${version}.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Segger Embedded Studio (nRF) ($version)
Exec=/opt/nordic/segger_nrf/$version/bin/emStudio.sh
Comment=Segger Embedded Studio For Nordic
Terminal=false
Icon=/opt/nordic/segger_nrf/$version/bin/StudioIcon.png
Type=Application
Categories=Programming;IDE
Hidden=false
NoDisplay=false
StartupWMClass=SEGGER Embedded Studio
EOF



cat <<EOF | sudo dd status=none of="/opt/nordic/segger_nrf/${version}/bin/emStudio.sh"
#!/bin/bash
sdks=()
for entry in /opt/nordic/ncs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done
sdk_choice=\$(zenity --list --title "SDK version" --column="SDK Version" \${sdks[@]})

export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
source "/opt/nordic/ncs/\$sdk_choice/bin/activate"
source "/opt/nordic/ncs/\$sdk_choice/zephyr/zephyr-env.sh"
/opt/nordic/segger_nrf/${version}/bin/emStudio

EOF

sudo chmod +x "/opt/nordic/segger_nrf/${version}/bin/emStudio.sh"


sudo chmod -R 775 /opt/nordic/ncs
sudo chown -R root:"$SHGROUP" /opt/nordic/ncs

# install VSCode
cat <<EOF | sudo dd status=none of="/opt/nordic/vscode_nrf/vscode_nrf.sh"
#!/bin/bash
sdks=()
for entry in /opt/nordic/ncs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done
sdk_choice=\$(zenity --list --title "SDK version" --column="SDK Version" \${sdks[@]})

export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
source "/opt/nordic/ncs/\$sdk_choice/bin/activate"
source "/opt/nordic/ncs/\$sdk_choice/zephyr/zephyr-env.sh"
code "\$@"

EOF

sudo chmod +x "/opt/nordic/vscode_nrf/vscode_nrf.sh"


# nRf extensions
sudo apt install -y code
code --install-extension nordic-semiconductor.nrf-connect-extension-pack

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/code_nrf.desktop"
[Desktop Entry]
Name=Visual Studio Code (nRF)
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=/opt/nordic/vscode_nrf/vscode_nrf.sh --unity-launch %F
Icon=com.visualstudio.code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;application/x-code-workspace;
Actions=new-empty-window;
Keywords=vscode;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=/opt/nordic/vscode_nrf/vscode_nrf.sh --new-window %F
Icon=com.visualstudio.code
EOF


# install Terminal
cat <<EOF | sudo dd status=none of="/opt/nordic/cli_nrf/cli_nrf.sh"
#!/bin/bash
sdks=()
for entry in /opt/nordic/ncs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done
sdk_choice=\$(zenity --list --title "SDK version" --column="SDK Version" \${sdks[@]})

export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
source "/opt/nordic/ncs/\$sdk_choice/bin/activate"
source "/opt/nordic/ncs/\$sdk_choice/zephyr/zephyr-env.sh"
x-terminal-emulator "\$@"

EOF

sudo chmod +x "/opt/nordic/cli_nrf/cli_nrf.sh"

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/cli_nrf.desktop"
[Desktop Entry]
# VERSION=3.38.1
Name=Terminal (nRF)
Comment=Use the command line
Keywords=shell;prompt;command;commandline;cmd;
Exec=/opt/nordic/cli_nrf/cli_nrf.sh
Icon=terminal
Type=Application
Categories=System;TerminalEmulator;
StartupNotify=true
X-GNOME-SingleWindow=false

EOF

