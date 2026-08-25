#!/bin/bash

# Install Tailscale, a zero-config mesh VPN. See https://tailscale.com/docs/install/linux
# After installation, authenticate with: sudo tailscale up
curl -fsSL https://tailscale.com/install.sh | sh

# Enable and start the daemon so the node comes up on boot
sudo systemctl enable --now tailscaled 2>/dev/null || true
