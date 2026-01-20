#!/bin/bash

cat <<EOF >~/.local/share/applications/YoutubeMusic.desktop
[Desktop Entry]
Version=1.0
Name=Youtube Music
Comment=Youtube Music
Exec=google-chrome --app="https://music.youtube.com/?source=pwa" --name=Youtube Music --class=YoutubeMusic
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/sajans.ubuntu/applications/icons/YoutubeMusic.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/YoutubeMusic.desktop