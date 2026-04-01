#!/bin/bash

cat <<EOF >~/.local/share/applications/Activity.desktop
[Desktop Entry]
Version=1.0
Name=Activity
Comment=System activity from btop
Exec=terminator -m -x btop
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/sajans.ubuntu/applications/icons/Activity.png
Categories=GTK;
StartupNotify=false
EOF