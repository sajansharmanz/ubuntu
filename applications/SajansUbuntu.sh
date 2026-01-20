#!/bin/bash

cat <<EOF >~/.local/share/applications/SajansUbuntu.desktop
[Desktop Entry]
Version=1.0
Name=Sajans Ubuntu
Comment=Ubuntu Controls
Exec=ghostty --maximize -e sajans.ubuntu
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/sajans.ubuntu/applications/icons/Sajan.png
Categories=GTK;
StartupNotify=false
EOF