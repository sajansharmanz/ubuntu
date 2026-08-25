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
# Installs the .desktop file + icons for the current user so Kitty appears in the
# app grid, is launchable, and can be pinned to the dock.
# See https://sw.kovidgoyal.net/kitty/binary/#desktop-integration
~/.local/kitty.app/bin/kitty + runpy "from kitty.install import install_desktop_files_for; install_desktop_files_for('~/.local')"

# Register Kitty as a default terminal emulator (x-scheme-handler/terminal)
mkdir -p ~/.local/share/applications
if [ -f ~/.local/share/applications/kitty.desktop ]; then
    if ! grep -q "x-scheme-handler/terminal" ~/.local/share/applications/kitty.desktop; then
        echo "X-GNOME-MimeType=x-scheme-handler/terminal;" >> ~/.local/share/applications/kitty.desktop
    fi
    update-desktop-database ~/.local/share/applications 2>/dev/null || true
fi

# Make Kitty the default terminal for the desktop environment
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.default-applications.terminal exec kitty 2>/dev/null || true
fi

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
