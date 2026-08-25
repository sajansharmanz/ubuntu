#!/bin/bash

# Apply the monochrome Kitty terminal theme.
# Copies the shared monochrome kitty.conf into the user's config dir. The file
# itself lives in defaults/kitty/kitty.conf so it can also be installed on a
# fresh machine by app-kitty.sh (without running the theme chooser).

KITTY_CONF_SRC="$SAJANS_UBUNTU_PATH/defaults/kitty/kitty.conf"
KITTY_CONF_DEST="$HOME/.config/kitty/kitty.conf"

mkdir -p "$(dirname "$KITTY_CONF_DEST")"
cp "$KITTY_CONF_SRC" "$KITTY_CONF_DEST"
