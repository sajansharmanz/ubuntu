#!/bin/bash

cat <<EOF >~/.local/share/applications/AWS.desktop
[Desktop Entry]
Version=1.0
Name=AWS
Comment=AWS
Exec=google-chrome --app="https://console.aws.amazon.com/?nc2=h_uta_mc" --name=AWS --class=AWS
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/AWS.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF