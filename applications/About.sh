#!/bin/bash

cat <<EOF >~/.local/share/applications/About.desktop
[Desktop Entry]
Version=1.0
Name=About
Comment=System information from Fastfetch
Exec=terminator -m -x fastfetch
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/sajans.ubuntu/applications/icons/Ubuntu.png
Categories=GTK;
StartupNotify=false
EOF