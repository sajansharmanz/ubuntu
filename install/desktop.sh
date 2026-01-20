#!/bin/bash

# Purge unwanted apps
source ~/.local/share/sajans.ubuntu/install/desktop/purge/app-purge.sh

# Run desktop installers
for installer in ~/.local/share/sajans.ubuntu/install/desktop/*.sh; do source $installer; done

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot