#!/bin/bash

export SDK="main"

export NRFCONNECT_URL=$(echo "https://www.nordicsemi.com`curl https://www.nordicsemi.com/Products/Development-tools/nRF-Connect-for-desktop/Download#infotabs |\
      grep AppImage | grep -o '>.*</span>' | sed 's/\(>\|<\/span>\)//g;s/|/\n/g' | sed -n '2 p'`")

export NRFCLI_URL=$(echo "https://www.nordicsemi.com`curl https://www.nordicsemi.com/Products/Development-tools/nrf-command-line-tools/download |\
      grep -i Linux-amd64.zip | grep -o '>.*</span>' | sed 's/\(>\|<\/span>\)//g;s/|/\n/g' | sed -n '2 p'`")

export GNUARMEMB_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
export SEGGER_URL="https://segger.com/downloads/embedded-studio/embeddedstudio_arm_nordic_linux_x64"
export SHGROUP="nordic"

sudo addgroup $SHGROUP

# nRF tools
echo "Installing nRF Command Line Tools"
sudo mkdir -p /usr/local/share/applications
sudo mkdir -p /usr/local/share/pixmaps
mkdir nrf-cmd
cd nrf-cmd

# Download
wget -c  --content-disposition $NRFCLI_URL
unzip *.zip

# Install nRF command line tools
tar -xf nrf-command-line-tools-*.tar.gz
sudo mv nrf-command-line-tools /opt/
sudo ln -s /opt/nrf-command-line-tools/bin/* /usr/local/bin/
# Install JLink
sudo mkdir /opt/SEGGER
sudo tar -xf JLink_*.tgz -C /opt/SEGGER/
sudo ln -s /opt/SEGGER/JLink_*x86_64 /opt/SEGGER/JLink
find /opt/SEGGER/JLink/ -type f -executable ! -name '*.so*' -exec sudo ln -s {} /usr/local/bin/ \;
find /opt/SEGGER/JLink/ -type f -name '99-jlink.rules' -exec sudo cp {} /etc/udev/rules.d/99-segger-jlink.rules \;

# Reload udev
sudo udevadm control -R
sudo udevadm trigger --action=remove --attr-match=idVendor=1366 --subsystem-match=usb
sudo udevadm trigger --action=add    --attr-match=idVendor=1366 --subsystem-match=usb

# icon start
base64 -d <<EOF | dd status=none of="./jlink.png"
iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAC9klEQVRoge1ay2oVQRBNiBojRoyP
SDBBgyFGEx8EXLgRXLhw4SKLLIK4UHAhCJJFIGQREMwmGz/BP/A7/Kp75NAWFGXPdE/3dM+9JA1F
Qs+rTp0+VV1zZ2r7FHh+4uzZd+DpMbB15OzxAbCx7+zhV2D9C7D22dmDj8DqB+D+nrN7u8DKDrD8
ztndt8DSG2d3XgOLr4BbL53dfAHc2AauP3F27REwvw5cXXV2ZQWYWwIuLwKzt4FLC8CFeWczc8D0
RWBq+p8RAP/hJI0n8ERexIt5E96MN6XxAXwYHyoO0Bk6JQ7SWTotAAiGoAiQRrAEzQAwEGufXFAY
IAZq45sLGgO4eeiCycAywBJs8TsIgGYB0PkuAIQVDYDOi/kA0HmarIYoAHS+jQGhWDNA5zUAOq8B
MPqaATqfywB9bmRA1losAM3AaDSKthAAYaDTEkphIBXAz9+j+hoILaESAHwaaFxCuRoYnIHcJUQR
0zGf9clAUQA2jUoW6pOBYkuorQ5UYSBUiXPqwMRooGkrMbZZaAgNFN1KTBwDIQBVGUgRsW8J0fmJ
YeBMaCBlK9HWD1TXgM/5sWHALiFdyNo2cjENDZ0vvpXosgPV0S/S0KRkoRTni7WUpRjQ2+qUnpjO
F9VAUw+gretrlbHKQn2/laj6WiX3xdbYVOIqDNBkUHwxAPTIebWoR5YG9KD4YgFItkllwD43WQOp
AOT8VA1IECyA4gzYNJrLgDA5CAO6H9ARtX9//QkzoDWgi2I1DWiH7OA8QcQwYCt6dBZKYUBrwEZU
TDv6/sf/DGgA1vmqWcjOiwasoz4AesnJedWykF1CXQFYIDyneB3QD/NpIBaAPibXDVYHBmdALs5h
QN+niwbs6/hoDUgW0hemaMDWgRQAvhTamYGmPM5RQgM2jXauA1YDbYM3C2lAz2sAej60mbOVmMeC
/UBMiygA2vZCvpaS+yA9r/sBPW/3QvrYIL8PnPfEQ/3EVKUn7utzG/3JTR+f2/g+ubGf2/wFWLcX
3hpA/V8AAAAASUVORK5CYII=
EOF
# icon end

sudo install ./jlink.png /usr/local/share/pixmaps

for EXE in $(ls -1 /opt/JLink*/*Exe);do
WMCLASS=$(basename $EXE)
NAME=${WMCLASS::-3}
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/${WMCLASS}.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=$NAME
Exec=$EXE
Icon=/usr/local/share/pixmaps/jlink.png
Terminal=false
Type=Application
Categories=IDE;Development;
StartupNotify=true
Keywords=IDE;development;
StartupWMClass=$WMCLASS
EOF
done

# Cleanup
cd ../
rm -Rf nrf-cmd

# nRF SDK
echo "Installing nRF Connect SDK"

# install the required tools on Ubuntu
curl https://apt.kitware.com/kitware-archive.sh | sudo bash

sudo apt update
sudo apt install -y --no-install-recommends git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget libncurses5 python3-venv \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
  xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev zenity yad


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
  sudo chown root:root /Applications
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
sudo mkdir /opt/nordic/tools
sudo mkdir /opt/nordic/segger
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
sudo tar -xf "$file" -C "/opt/nordic/segger/"
sudo mv "/opt/nordic/segger/arm_segger_embedded_studio_${version}_linux_x64_nordic" \
        "/opt/nordic/segger/${version}"
cd
rm -Rf /tmp/segger

# add desktop files
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/arm_segger_embedded_studio_${version}.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Segger Embedded Studio (nRF) ($version)
Exec=/opt/nordic/segger/$version/bin/emStudio.sh
Comment=Segger Embedded Studio For Nordic
Terminal=false
Icon=/opt/nordic/segger/$version/bin/StudioIcon.png
Type=Application
Categories=IDE;Development;
Hidden=false
NoDisplay=false
StartupWMClass=SEGGER Embedded Studio
EOF



cat <<EOF | sudo dd status=none of="/opt/nordic/segger/${version}/bin/emStudio.sh"
#!/bin/bash
sdks=()
for entry in /opt/nordic/ncs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done
sdk_choice=\$(zenity --list --title "SDK version" --column="SDK Version" \${sdks[@]})

export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
source "/opt/nordic/ncs/\$sdk_choice/bin/activate"
source "/opt/nordic/ncs/\$sdk_choice/zephyr/zephyr-env.sh"
/opt/nordic/segger_nrf/${version}/bin/emStudio

EOF

sudo chmod +x "/opt/nordic/segger/${version}/bin/emStudio.sh"

sudo ln -s "/opt/nordic/segger/${version}/bin/emStudio" "/usr/local/bin/emStudio"


# install VSCode
sudo apt install -y code

# nRf extensions
code --install-extension nordic-semiconductor.nrf-connect-extension-pack

# Add nRF launcher

cat <<EOF | sudo dd status=none of="/opt/nordic/tools/nrf-launcher.sh"
#!/bin/bash
sdks=()
for entry in /opt/nordic/ncs/*
do
  sdk_version=\$(basename \$entry)
  sdks+=("\$sdk_version")
done

printf -v joined '%s,' "\${sdks[@]}"
sdk_choices=\$(echo "\${joined%,}")
tool_choices="Visual Studio Code,Segger Embedded Studio,Terminal"

choices=\$(yad --separator="," --item-separator="," \\
               --window-icon=/opt/nordic/tools/icon.svg \\
               --title="nRF Launcher" --form \\
               --field="SDK Version":CB "\${sdk_choices}" \\
               --field="Tool":CB "\${tool_choices}")

if [ ! -z "\${choices}" ]; then
  sdk_choice=\$(echo \$choices | cut -d ',' -f1)
  tool_choice=\$(echo \$choices | cut -d ',' -f2)
  export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
  export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
  source "/opt/nordic/ncs/\$sdk_choice/bin/activate"
  source "/opt/nordic/ncs/\$sdk_choice/zephyr/zephyr-env.sh"


  case "\${tool_choice}" in
  "Visual Studio Code")
    code "\$@"
    ;;
  "Segger Embedded Studio")
    emStudio "\$@"
    ;;
  "Terminal")
    x-terminal-emulator "\$@"
    ;;
esac
fi
EOF

sudo chmod +x /opt/nordic/tools/nrf-launcher.sh
sudo wget https://raw.githubusercontent.com/NordicSemiconductor/pc-nrfconnect-launcher/master/resources/icon.svg -P /opt/nordic/tools/

# add desktop files
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/nrf-launcher.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=nRF Launcher
Exec=/opt/nordic/tools/nrf-launcher.sh
Comment=Launch tools in nRF Connect SDK
Terminal=false
Icon=/opt/nordic/tools/icon.svg
Type=Application
Categories=IDE;Development;
Hidden=false
NoDisplay=false
EOF

