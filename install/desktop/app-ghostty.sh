#!/bin/bash

# Install Ghostty
sudo snap install ghostty --classic

# Set Ghostty as default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'ghostty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'

# Register ghostty first if it's not in update-alternatives
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /snap/ghostty/current/bin/ghostty 50

# Then set it as default
sudo update-alternatives --set x-terminal-emulator /snap/ghostty/current/bin/ghostty

# Install Nautilus Python bindings if not already installed
sudo apt-get install -y python3-nautilus
mkdir -p ~/.local/share/nautilus-python/extensions/

# Create Nautilus extension for Ghostty
cat > ~/.local/share/nautilus-python/extensions/open-ghostty.py <<'EOF'
import subprocess
from urllib.parse import unquote
from gi.repository import Nautilus, GObject
from typing import List

class OpenGhosttyExtension(GObject.GObject, Nautilus.MenuProvider):
    def _open_ghostty(self, folder: str) -> None:
        folder = unquote(folder)
        subprocess.Popen(
            ["/snap/bin/ghostty", f"--working-directory={folder}"],
            start_new_session=True
        )

    def menu_activate_cb(self, menu, file: Nautilus.FileInfo) -> None:
        self._open_ghostty(file.get_uri()[7:])

    def menu_background_activate_cb(self, menu, file: Nautilus.FileInfo) -> None:
        self._open_ghostty(file.get_uri()[7:])

    def get_file_items(self, files: List[Nautilus.FileInfo]):
        if len(files) != 1:
            return []
        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != "file":
            return []
        item = Nautilus.MenuItem(
            name="NautilusPython::openghostty_file_item",
            label="Open in Ghostty",
            tip=f"Open Ghostty in {file.get_name()}",
        )
        item.connect("activate", self.menu_activate_cb, file)
        return [item]

    def get_background_items(self, current_folder: Nautilus.FileInfo):
        item = Nautilus.MenuItem(
            name="NautilusPython::openghostty_background_item",
            label="Open in Ghostty",
            tip=f"Open Ghostty in {current_folder.get_name()}",
        )
        item.connect("activate", self.menu_background_activate_cb, current_folder)
        return [item]
EOF

# Reload Nautilus to apply extension
nautilus -q || true
