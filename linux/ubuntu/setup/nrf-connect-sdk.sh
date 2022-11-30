#!/bin/bash

export NRFCONNECT_URL=$(
curl https://www.nordicsemi.com/Products/Development-tools/nRF-Connect-for-desktop/Download#infotabs |\
        grep -i AppImage | grep -o '>.*</span>' |\
        sed 's/\(>\|<\/span>\)//g;s/|/\n/g' |  grep http | sed -n '2 p'
)

export NRFCLI_URL=$(curl https://www.nordicsemi.com/Products/Development-tools/nrf-command-line-tools/download |\
      grep -i Linux-amd64.zip | grep -o '>.*</span>' | sed 's/\(>\|<\/span>\)//g;s/|/\n/g' | sed -n '2 p')

export GNUARMEMB_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
export SEGGER_URL="https://segger.com/downloads/embedded-studio/embeddedstudio_arm_nordic_linux_x64"

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

for EXE in $(ls -1 /opt/SEGGER/JLink/*Exe);do
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
  xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev zenity yad \
  gir1.2-gtk-4.0 gir1.2-adw-1


# install the GN tool
sudo mkdir /opt/gn
wget -O gn.zip https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-amd64/+/latest
sudo unzip gn.zip -d /opt/gn
rm gn.zip
sudo chmod +x /opt/gn/gn
sudo ln -s /opt/gn/gn /usr/local/bin/gn


wget -c "$NRFCONNECT_URL" -P "$HOME"
chmod +x nrfconnect-*-x86_64.AppImage


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
sudo chown -R root:root /opt/nordic
sudo chmod 777 /opt/nordic/ncs


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


# Add nRF Connect SDK Manager

cat <<EOF | sudo dd status=none of="/opt/nordic/tools/nrf-connect-sdk-manager.py"
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""nRF-Connect SDK manager"""

import gi
import os
import subprocess
import pprint
import shlex
import threading

gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')

from gi.repository import Adw, Gio, Gtk


class SdkManagerWindow(Gtk.ApplicationWindow):

    def install_remove_thread(self, to_install, sdk, was_installed):
        if was_installed:
            if not to_install:
                print('Remove')
                script = 'rm -Rf {sdk_dir}/{sdk}'.format(sdk=sdk,
                                                         sdk_dir=self.sdk_dir)
                os.system("bash -c '%s'" % script)
                self.show_list()
        else:
            if to_install:
                print('Install')
                script = """
                cd {sdk_dir}/
                python3 -m venv "{sdk}"
                cd "{sdk_dir}/{sdk}"
                source bin/activate
                pip3 install west wheel
                west init -m https://github.com/nrfconnect/sdk-nrf --mr {sdk}
                west update
                west zephyr-export

                pip3 install -r zephyr/scripts/requirements.txt
                pip3 install -r nrf/scripts/requirements.txt
                pip3 install -r bootloader/mcuboot/scripts/requirements.txt
                """.format(sdk=sdk, sdk_dir=self.sdk_dir)
                os.system("bash -c '%s'" % script)
                self.show_list()

    def install_remove(self, swt, to_install, sdk, was_installed):
        if was_installed != to_install:
            self.progress()
            thread = threading.Thread(target=self.install_remove_thread,
                                      args=(to_install, sdk, was_installed))
            thread.start()


    def run_in_env(self, button, sdk, command):
        script = """
          export GNUARMEMB_TOOLCHAIN_PATH=/opt/gnuarmemb
          export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
          source "{sdk_dir}/{sdk}/bin/activate"
          source "{sdk_dir}/{sdk}/zephyr/zephyr-env.sh"
          {command} &
        """.format(sdk_dir=self.sdk_dir, sdk=sdk, command=command)
        os.system("bash -c '%s'" % script)

    def progress(self):
        self.box.set_child(child=self.spinner)
        self.spinner.start()

    def show_list(self):
        self.spinner.stop()
        listbox_1 = Gtk.ListBox.new()
        listbox_1.set_selection_mode(mode=Gtk.SelectionMode.NONE)
        listbox_1.set_margin_end(margin=12)
        installed = os.listdir(self.sdk_dir)
        available_list = []
        git = ["git", "ls-remote", "-t", "--exit-code", "--refs",
               "https://github.com/nrfconnect/sdk-nrf"]
        output = subprocess.check_output(git).decode("utf-8")
        for line in output.split("\\n"):
            sdk = line.split("/")[-1]
            if sdk != '':
                available_list.append(sdk)
        available = sorted(available_list, reverse=True)

        for sdk in available:
            row = Gtk.ListBoxRow.new()
            row.set_selectable(selectable=False)

            hbox = Gtk.Box.new(orientation=Gtk.Orientation.HORIZONTAL,
                               spacing=0)
            row.set_child(child=hbox)

            label = Gtk.Label.new(str=sdk)
            label.set_margin_top(margin=6)
            label.set_margin_end(margin=6)
            label.set_margin_bottom(margin=6)
            label.set_margin_start(margin=6)
            label.set_xalign(xalign=0)
            label.set_hexpand(expand=True)
            hbox.append(child=label)

            switch = Gtk.Switch.new()
            switch.set_margin_top(margin=6)
            switch.set_margin_end(margin=6)
            switch.set_margin_bottom(margin=6)
            switch.set_margin_start(margin=6)
            instd = sdk in installed
            switch.set_state(state=instd)
            switch.connect('state-set', self.install_remove, sdk, instd)
            hbox.append(child=switch)

            ses = Gtk.Button.new_with_label(label='SEGGER Embedded Studio')
            ses.set_sensitive(instd)
            ses.connect('clicked', self.run_in_env, sdk, 'emStudio')
            hbox.append(child=ses)

            code = Gtk.Button.new_with_label(label='Visual Studio Code')
            code.set_sensitive(instd)
            code.connect('clicked', self.run_in_env, sdk, 'code')
            hbox.append(child=code)

            terminal = Gtk.Button.new_with_label(label='Terminal')
            terminal.set_sensitive(instd)
            terminal.connect('clicked',
                             self.run_in_env,
                             sdk,
                             'x-terminal-emulator')
            hbox.append(child=terminal)
            listbox_1.append(child=row)
        self.box.set_child(child=listbox_1)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.sdk_dir = "/opt/nordic/ncs"

        self.set_title(title='nRF Connect SDK Manager')
        self.set_default_size(width=int(1366 / 2), height=int(768 / 2))
        self.set_size_request(width=int(1366 / 2), height=int(768 / 2))

        vbox = Gtk.Box.new(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        vbox.set_homogeneous(homogeneous=True)
        vbox.set_margin_top(margin=12)
        vbox.set_margin_end(margin=12)
        vbox.set_margin_bottom(margin=12)
        vbox.set_margin_start(margin=12)
        self.set_child(child=vbox)

        self.box = Gtk.ScrolledWindow.new()
        vbox.append(child=self.box)
        self.spinner = Gtk.Spinner.new()
        self.show_list()


class SdkManagerApplication(Adw.Application):

    def __init__(self):
        super().__init__(application_id='com.nordicsemi.SdkManager',
                         flags=Gio.ApplicationFlags.FLAGS_NONE)

        self.create_action('quit', self.exit_app, ['<primary>q'])

    def do_activate(self):
        win = self.props.active_window
        if not win:
            win = SdkManagerWindow(application=self)
        win.present()

    def do_startup(self):
        Gtk.Application.do_startup(self)

    def do_shutdown(self):
        Gtk.Application.do_shutdown(self)

    def exit_app(self, action, param):
        self.quit()

    def create_action(self, name, callback, shortcuts=None):
        action = Gio.SimpleAction.new(name, None)
        action.connect('activate', callback)
        self.add_action(action)
        if shortcuts:
            self.set_accels_for_action(f'app.{name}', shortcuts)


if __name__ == '__main__':
    import sys

    app = SdkManagerApplication()
    app.run(sys.argv)

EOF

sudo chmod +x /opt/nordic/tools/nrf-connect-sdk-manager.py
sudo wget https://raw.githubusercontent.com/NordicSemiconductor/pc-nrfconnect-launcher/master/resources/icon.svg -P /opt/nordic/tools/

# add desktop files
cat <<EOF | sudo dd status=none of="/usr/local/share/applications/nrf-connect-sdk-manager.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=nRF Connect SDK Manager
Exec=/opt/nordic/tools/nrf-connect-sdk-manager.py
Comment=Launch tools in nRF Connect SDK
Terminal=false
Icon=/opt/nordic/tools/icon.svg
Type=Application
Categories=IDE;Development;
Hidden=false
NoDisplay=false
StartupWMClass=nrf-connect-sdk-manager.py
EOF

echo "The nRf Connect app is in your home folder place it where you'd like"

