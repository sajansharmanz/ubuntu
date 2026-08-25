#!/bin/bash

# Firewall: enable UFW with sane defaults.
# Blocks all incoming by default (except already-established connections) and
# leaves outgoing open. Safe on a desktop / media box; SSH is allowed so remote
# access isn't locked out. Pair this with Tailscale for private networking.

sudo apt-get install -y ufw

# Default policy: deny incoming, allow outgoing
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH so we never lock ourselves out of a remote box
sudo ufw allow OpenSSH

# Enable (non-interactive). The --force avoids the "command may disrupt" prompt.
sudo ufw --force enable
