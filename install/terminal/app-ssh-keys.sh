#!/bin/bash

# SSH key generation (opt-in).
# Creates an ed25519 key only if the user explicitly asks. We keep this
# interactive (not forced) because on a restored machine the key should come
# from the backup rather than being regenerated.

if gum confirm "Generate a new SSH key (~/.ssh/id_ed25519)?" --affirmative "Generate" --negative "Skip"; then
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh

  # Suggest the git identity if it was captured earlier this run
  default_email="${SAJANS_UBUNTU_USER_EMAIL:-$USER@$HOSTNAME}"
  KEY_EMAIL=$(gum input --placeholder "email for the key comment" --value "$default_email" --prompt "Email> ")

  if [ -f ~/.ssh/id_ed25519 ]; then
    echo "~/.ssh/id_ed25519 already exists — leaving it untouched."
  else
    ssh-keygen -t ed25519 -C "$KEY_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    echo "SSH key created. Public key:"
    cat ~/.ssh/id_ed25519.pub
  fi
else
  echo "Skipped SSH key generation."
fi
