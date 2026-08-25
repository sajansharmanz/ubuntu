#!/bin/bash

# Install Kitty, a fast GPU-accelerated terminal emulator.
# Binary install + Linux desktop integration. See https://sw.kovidgoyal.net/kitty/binary/

# --- Install Hack Nerd Font (our terminal font) ---
# Monospace font used by Kitty and the system; the name set in
# set-gnome-settings.sh (Hack Nerd Font Mono 11) resolves against this.
mkdir -p ~/.local/share/fonts
cd /tmp || exit 1
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -o Hack.zip -d ~/.local/share/fonts
fc-cache -fv

# --- Install the official Kitty binary into ~/.local/kitty.app ---
echo "Installing Kitty binary..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create symlinks in ~/.local/bin so `kitty`/`kitten` are on the PATH
mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten

# --- Desktop integration ---
# Install .desktop files + icons so Kitty appears in the app grid.
# See https://sw.kovidgoyal.net/kitty/binary/#desktop-integration
mkdir -p ~/.local/share/applications
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

# Update the Icon and Exec paths in the .desktop files to point to the kitty install
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# Make xdg-terminal-exec (and desktop environments that support it) use Kitty
mkdir -p ~/.config
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# --- Apply the monochrome Kitty config on a fresh install ---
# So the terminal is themed (monochrome) without the user having to run the
# theme chooser. Only seed the config if one isn't already present, so an
# existing custom kitty.conf is never overwritten.
KITTY_CONF_DIR="$HOME/.config/kitty"
KITTY_CONF_DEST="$KITTY_CONF_DIR/kitty.conf"
KITTY_CONF_SRC="$SAJANS_UBUNTU_PATH/defaults/kitty/kitty.conf"
mkdir -p "$KITTY_CONF_DIR"
if [ ! -f "$KITTY_CONF_DEST" ] && [ -f "$KITTY_CONF_SRC" ]; then
    cp "$KITTY_CONF_SRC" "$KITTY_CONF_DEST"
    echo "Seeded monochrome kitty.conf from defaults."
fi

echo "Done. Kitty is installed."
