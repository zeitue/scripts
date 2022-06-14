#!/bin/bash

cat <<EOF | dd status=none of=/etc/default/grub.d/cgroup.cfg
GRUB_CMDLINE_LINUX=systemd.unified_cgroup_hierarchy=false
EOF

sudo update-grub

