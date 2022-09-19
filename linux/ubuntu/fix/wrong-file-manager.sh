#!/bin/bash

echo "Fixing opening with the wrong file manager"

cat <<EOF | sudo dd status=none of="/etc/dbus-1/session-local.conf"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE busconfig PUBLIC
"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
	<policy context="default">
		<!-- Block all usage of org.freedesktop.FileManager1 for opening files -->
		<deny send_interface="org.freedesktop.FileManager1" send_destination="org.freedesktop.FileManager1"/>
	</policy>
</busconfig>
EOF


dbus-send --session --print-reply\
          --dest=org.freedesktop.DBus\
          --type=method_call /org/freedesktop/DBus\
          org.freedesktop.DBus.ReloadConfig
