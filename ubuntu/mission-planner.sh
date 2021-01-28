#!/bin/bash

# Mission

echo "Installing Mission Planner"

sudo apt install -y mono-complete xdotool

wget -c https://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-stable.zip
sudo unzip MissionPlanner-stable.zip -d /opt/MissionPlanner/


if [[ ! -d "/usr/local/share/applications" ]]; then
    sudo mkdir -p "/usr/local/share/applications"
fi

cat <<EOF | sudo dd status=none of="/opt/MissionPlanner/MissionPlanner.sh"
#!/bin/bash
/usr/bin/mono /opt/MissionPlanner/MissionPlanner.exe &
sleep 9
xdotool search --name "Mission Planner" set_window --class "MissionPlanner"
EOF

sudo chmod +x /opt/MissionPlanner/MissionPlanner.sh

# desktop file
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/mission-planner.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Mission Planner
Exec=/opt/MissionPlanner/MissionPlanner.sh
Icon=/opt/MissionPlanner/mpdesktop150.png
Terminal=false
Type=Application
Categories=Development;
StartupNotify=true
Keywords=development;programming;
StartupWMClass=MissionPlanner
EOF
