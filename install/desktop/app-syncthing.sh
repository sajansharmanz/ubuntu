#!/bin/bash

# Syncthing: continuous file synchronization between devices.
# Installs the daemon plus the GTK tray/app (syncthing-gtk) so it's reachable
# from the app grid and dock. See https://syncthing.net/
sudo apt-get install -y syncthing syncthing-gtk

# Enable the user service so it starts on login
systemctl --user enable --now syncthing.service 2>/dev/null || true
