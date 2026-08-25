#!/bin/bash

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/header.sh

command -v openssl >/dev/null 2>&1 || { echo "openssl is required but not installed."; exit 1; }

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
ENCRYPTED_FILE="$HOME/sajans-backup-$TIMESTAMP.tar.gz.enc"

INCLUDES=()
add_rel() {
  local full="$1"
  [ -e "$full" ] || return
  INCLUDES+=("${full#$HOME/}")
}

add_rel "$HOME/.ssh"
add_rel "$HOME/repos"

for f in .bashrc .bash_aliases .profile .npmrc .gitconfig .gitignore .inputrc \
         .config .local/share/sajans.ubuntu; do
  add_rel "$HOME/$f"
done

for f in "$HOME"/*; do
  base=$(basename "$f")
  case "$base" in
    local_to_*|sync_*|.env|*.env) add_rel "$f" ;;
  esac
done

if [ "${#INCLUDES[@]}" -eq 0 ]; then
  echo "Nothing found to back up. Aborting."
  exit 1
fi

echo "The following will be included in the backup:"
printf '  %s\n' "${INCLUDES[@]}"

TMP_TAR="/tmp/sajans-backup-$TIMESTAMP.tar.gz"
tar -czf "$TMP_TAR" -C "$HOME" \
  --exclude='*/node_modules' \
  --exclude='*/.git/objects' \
  "${INCLUDES[@]}"

if [ ! -s "$TMP_TAR" ]; then
  echo "Failed to create backup archive."
  rm -f "$TMP_TAR"
  exit 1
fi

# Ask for an encryption password and confirm it (so a typo doesn't quietly
# produce a backup the user can't restore). Falls back to a plain read if gum
# isn't available.
PASS=""
while [ -z "$PASS" ]; do
  if command -v gum >/dev/null 2>&1; then
    PASS=$(gum input --password --prompt "Encryption password> " --placeholder "Enter a password for the backup")
    CONFIRM=$(gum input --password --prompt "Confirm password> " --placeholder "Re-enter the password")
  else
    read -rsp "Encryption password: " PASS; echo
    read -rsp "Confirm password: " CONFIRM; echo
  fi
  if [ "$PASS" != "$CONFIRM" ]; then
    echo "Passwords do not match. Please try again."
    PASS=""
  fi
done

openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
  -in "$TMP_TAR" -out "$ENCRYPTED_FILE" \
  -pass "pass:$PASS"

# Scrub the in-memory copy of the password
unset PASS CONFIRM
rm -f "$TMP_TAR"

if [ -s "$ENCRYPTED_FILE" ]; then
  echo "Backup created: $ENCRYPTED_FILE"
else
  echo "Encryption failed."
  exit 1
fi

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/menu.sh
