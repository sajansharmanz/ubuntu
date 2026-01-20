#!/bin/bash

cat <<EOF >~/.local/share/applications/Notion.desktop
[Desktop Entry]
Version=1.0
Name=Notion
Comment=Notion
Exec=google-chrome --app="https://notion.so" --name=Notion --class=Notion
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/sajans.ubuntu/applications/icons/Notion.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF