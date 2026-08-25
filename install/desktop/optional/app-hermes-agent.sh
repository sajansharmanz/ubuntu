#!/bin/bash

# Hermes Agent — self-improving AI agent by Nous Research.
# See https://hermes-agent.nousresearch.com/docs
# Installs via the official installer, then hands control to the interactive
# setup wizard so you can configure Telegram / Discord / model provider etc.
# manually (we never auto-fill credentials).

# Prerequisites the installer expects on Debian/Ubuntu
sudo apt-get install -y git curl xz-utils build-essential

# Run the official installer (per-user layout: ~/.hermes + ~/.local/bin/hermes)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# Make the new hermes command available in this shell
export PATH="$HOME/.local/bin:$PATH"
hash -r 2>/dev/null || true

if command -v hermes >/dev/null 2>&1; then
  echo ""
  echo "Hermes Agent installed. Starting interactive setup so you can connect"
  echo "Telegram, choose a model provider, and configure tools."
  echo "(Run 'hermes setup --portal' later for the one-login Nous Portal option.)"
  echo ""

  # Reload the user's shell environment so hermes is on the PATH for the wizard
  source "$HOME/.bashrc" 2>/dev/null || true

  # Interactive first-run setup (Telegram, model, tools). User drives this.
  hermes setup

  # Offer the messaging-gateway setup too (Telegram/Discord/etc.) if they want it.
  if command -v gum >/dev/null 2>&1; then
    if gum confirm "Set up messaging platforms now (Telegram, Discord, ...)?" \
        --affirmative "Yes" --negative "Skip"; then
      hermes gateway setup
    fi
  fi
else
  echo "Hermes install did not produce a 'hermes' command. Check the output above."
  exit 1
fi
