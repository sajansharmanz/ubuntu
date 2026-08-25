#!/bin/bash

# Restore an encrypted backup created by backup.sh.
# Prompts for the archive, asks for the password, decrypts it, then extracts
# the contents back to their original absolute locations (paths are stored
# relative to ~ inside the tarball).

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/header.sh

command -v openssl >/dev/null 2>&1 || { echo "openssl is required but not installed."; exit 1; }

# --- Choose the archive to restore ---
ARCHIVE=$(gum file "$HOME" --height 20 --pattern '*.enc' 2>/dev/null || true)
if [ -z "$ARCHIVE" ]; then
  # Fall back to a manual path if gum file isn't available / cancelled
  read -r -p "Path to backup archive (.enc): " ARCHIVE
fi

[ -f "$ARCHIVE" ] || { echo "Archive not found: $ARCHIVE"; exit 1; }

TMP_TAR="/tmp/sajans-restore-$$.tar.gz"

echo "Enter the password for this backup:"
if ! openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 \
  -in "$ARCHIVE" -out "$TMP_TAR"; then
  echo "Decryption failed (wrong password or corrupt archive)."
  rm -f "$TMP_TAR"
  exit 1
fi

echo "Decrypted. Restoring to original locations..."
# Paths were stored relative to ~, so extract into ~.
tar -xzf "$TMP_TAR" -C "$HOME"

rm -f "$TMP_TAR"
echo "Restore complete."

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/menu.sh
