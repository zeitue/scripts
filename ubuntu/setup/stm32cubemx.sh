#!/bin/bash

WORK=$(pwd)
mkdir "$WORK/Downloads"
echo "Downloads STM32CubeMX from: https://www.st.com/en/development-tools/stm32cubemx.html"
echo "And place the file into this directory $WORK/Downloads"
echo "Press enter when finished: "
read
cd "$WORK/Downloads"
unzip *.zip

# create auto-install.xml
cat <<EOF | dd status=none of="./auto-install.xml"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<AutomatedInstallation langpack="eng">
    <com.st.microxplorer.install.MXHTMLHelloPanel id="readme"/>
    <com.st.microxplorer.install.MXLicensePanel id="licence.panel"/>
    <com.st.microxplorer.install.MXAnalyticsPanel id="analytics.panel"/>
    <com.st.microxplorer.install.MXTargetPanel id="target.panel">
        <installpath>/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX</installpath>
    </com.st.microxplorer.install.MXTargetPanel>
    <com.st.microxplorer.install.MXShortcutPanel id="shortcut.panel"/>
    <com.st.microxplorer.install.MXInstallPanel id="install.panel"/>
    <com.st.microxplorer.install.MXFinishPanel id="finish.panel"/>
</AutomatedInstallation>
EOF

# Install STM32CubeMX
sudo ./SetupSTM32CubeMX-* ./auto-install.xml

# make sure directory exists
sudo mkdir -p /usr/local/share/applications

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/STM32CubeMX.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=STM32CubeMX
GenericName=STM32Cube initialization code generator
Comment=Graphical tool for configuration of STM32 Microcontrollers
Exec=//usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/STM32CubeMX
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/help/STM32CubeMX.ico
Categories=IDE;Development;
StartupWMClass=com-st-microxplorer-maingui-STM32CubeMX
StartupNotify=true
EOF

rm -Rf "$WORK/Downloads"

