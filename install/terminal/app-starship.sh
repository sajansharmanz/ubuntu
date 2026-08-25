#!/bin/bash

# Starship: a minimal, fast, customizable cross-shell prompt.
# Install via the official script (gives the latest release) and let the bash
# init (defaults/bash/init) activate it. Install is a no-op if already present.

if command -v starship >/dev/null 2>&1; then
  echo "starship already installed; skipping."
  exit 0
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
