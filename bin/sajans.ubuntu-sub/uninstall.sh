#!/bin/bash

# Uninstaller: present every component this provisioning repo can install and
# let the user pick which to remove. After removals, a final `apt autoremove`
# cleans up now-orphaned dependencies.
#
# Removals are the inverse of the install scripts under install/. Each selected
# item maps to a case below. Removing a package that isn't installed is harmless
# (apt reports "not installed" and moves on).

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/header.sh

COMPONENTS=(
  "Terminal tools (fzf, ripgrep, bat, eza, zoxide, plocate, fd-find, tldr, apache2-utils)"
  "Dev libraries (build-essential, clang, rustc, imagemagick, redis-tools, sqlite3, postgresql-client, ...)"
  "Docker"
  "mise (version manager)"
  "gum"
  "UFW firewall"
  "btop"
  "fastfetch"
  "starship"
  "Tailscale"
  "Pi"
  "Plannotator"
  "OpenCode"
  "Kitty terminal"
  "VLC"
  "VS Code"
  "Google Chrome"
  "GNOME Tweak Tool"
  "Obsidian"
  "Flameshot"
  "GNOME Sushi"
  "Flatpak + Flathub"
  "Ulauncher"
  "GNOME extensions"
  "CopyQ"
  "Syncthing"
  "Postman (snap)"
  "Signal"
  "Spotify"
  "Remmina"
  "LibreOffice"
  "YouTube Music (web app)"
  "WhatsApp (web app)"
  "AWS (web app)"
  "Hermes Agent"
)

# --- Build the selection (gum if available, plain numbered list otherwise) ---
if command -v gum >/dev/null 2>&1; then
  SELECTED=$(printf '%s\n' "${COMPONENTS[@]}" | gum choose --no-limit --height 40 --header "Select components to remove")
else
  echo "gum not found — select by number (space-separated, e.g. '1 3 5', or 'all'):"
  for i in "${!COMPONENTS[@]}"; do
    printf '%3d) %s\n' "$((i+1))" "${COMPONENTS[$i]}"
  done
  read -rp "Remove> " REPLY_CHOICE
  SELECTED=""
  if [ "${REPLY_CHOICE,,}" = "all" ]; then
    SELECTED=$(printf '%s\n' "${COMPONENTS[@]}")
  else
    for n in $REPLY_CHOICE; do
      idx=$((n-1))
      [ "$idx" -ge 0 ] && [ "$idx" -lt "${#COMPONENTS[@]}" ] && SELECTED+=$'\n'"${COMPONENTS[$idx]}"
    done
    SELECTED="${SELECTED#$'\n'}"
  fi
fi

[ -z "$SELECTED" ] && { echo "Nothing selected."; sleep 1; clear; source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu; }

remove_component() {
  case "$1" in
    "Terminal tools"*)
      sudo apt-get remove -y fzf ripgrep bat eza zoxide plocate apache2-utils fd-find tldr ;;
    "Dev libraries"*)
      sudo apt-get remove -y build-essential pkg-config autoconf bison clang rustc \
        libssl-dev libreadline-dev zlib1g-dev libyaml-dev libncurses5-dev libffi-dev \
        libgdbm-dev libjemalloc2 libvips imagemagick libmagickwand-dev mupdf mupdf-tools \
        sqlite3 libsqlite3-0 libmysqlclient-dev libpq-dev postgresql-client postgresql-client-common ;;
    "Docker")
      sudo apt-get remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
        docker-compose-plugin docker-ce-rootless-extras
      sudo rm -f /etc/apt/sources.list.d/docker.list /etc/apt/keyrings/docker.asc
      sudo gpasswd -d "${USER}" docker 2>/dev/null || true ;;
    "mise"*)
      sudo apt-get remove -y mise
      sudo rm -f /etc/apt/sources.list.d/mise.list /etc/apt/keyrings/mise-archive-keyring.gpg
      rm -rf ~/.local/share/mise ~/.config/mise ;;
    "gum")
      sudo apt-get remove -y gum
      sudo rm -f /etc/apt/sources.list.d/charm.list /etc/apt/keyrings/charm.gpg ;;
    "UFW"*)
      sudo ufw --force disable 2>/dev/null || true
      sudo apt-get remove -y ufw ;;
    "btop")
      sudo apt-get remove -y btop
      rm -rf ~/.config/btop ;;
    "fastfetch")
      sudo apt-get remove -y fastfetch
      sudo add-apt-repository -y --remove ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
      rm -f ~/.config/fastfetch/config.jsonc ;;
    "starship")
      rm -f ~/.local/bin/starship ~/.config/starship.toml ;;
    "Tailscale")
      sudo apt-get remove -y tailscale
      sudo systemctl disable --now tailscaled 2>/dev/null || true ;;
    "Pi")
      npm uninstall -g pi 2>/dev/null || true
      rm -f ~/.local/bin/pi ;;
    "Plannotator")
      npm uninstall -g plannotator 2>/dev/null || true
      rm -f ~/.local/bin/plannotator ;;
    "OpenCode")
      npm uninstall -g opencode 2>/dev/null || true
      rm -f ~/.local/bin/opencode
      rm -rf ~/.local/share/opencode ~/.config/opencode 2>/dev/null || true ;;
    "Kitty"*)
      rm -rf ~/.local/kitty.app ~/.local/bin/kitty ~/.local/bin/kitten \
             ~/.config/kitty ~/.local/share/applications/kitty.desktop ;;
    "VLC")
      sudo apt-get remove -y vlc ;;
    "VS Code")
      sudo apt-get remove -y code
      rm -rf ~/.config/Code ;;
    "Google Chrome"*)
      sudo apt-get remove -y google-chrome-stable
      sudo rm -f /etc/apt/sources.list.d/google-chrome.list 2>/dev/null || true ;;
    "GNOME Tweak Tool")
      sudo apt-get remove -y gnome-tweak-tool ;;
    "Obsidian")
      sudo apt-get remove -y obsidian ;;
    "Flameshot")
      sudo apt-get remove -y flameshot ;;
    "GNOME Sushi")
      sudo apt-get remove -y gnome-sushi ;;
    "Flatpak"*)
      sudo apt-get remove -y flatpak gnome-software-plugin-flatpak
      sudo flatpak remote-delete flathub 2>/dev/null || true ;;
    "Ulauncher")
      sudo apt-get remove -y ulauncher
      sudo rm -f /etc/apt/sources.list.d/ulauncher-noble.list /usr/share/keyrings/ulauncher-archive-keyring.gpg ;;
    "GNOME extensions")
      gsettings reset org.gnome.shell enabled-extensions 2>/dev/null || true
      rm -rf ~/.local/share/gnome-shell/extensions 2>/dev/null || true ;;
    "CopyQ")
      sudo apt-get remove -y copyq
      rm -rf ~/.config/copyq ;;
    "Syncthing")
      systemctl --user disable --now syncthing.service 2>/dev/null || true
      sudo apt-get remove -y syncthing syncthing-gtk
      rm -rf ~/.config/syncthing ;;
    "Postman"*)
      sudo snap remove postman 2>/dev/null || true ;;
    "Signal")
      sudo apt-get remove -y signal-desktop
      sudo rm -f /etc/apt/sources.list.d/signal-desktop.sources /usr/share/keyrings/signal-desktop-keyring.gpg ;;
    "Spotify")
      sudo apt-get remove -y spotify-client
      sudo rm -f /etc/apt/sources.list.d/spotify.list /etc/apt/trusted.gpg.d/spotify.gpg ;;
    "Remmina")
      sudo apt-get remove -y remmina remmina-plugin-rdp remmina-plugin-secret
      sudo add-apt-repository -y --remove ppa:remmina-ppa-team/remmina-next 2>/dev/null || true ;;
    "LibreOffice")
      sudo apt-get remove -y libreoffice ;;
    "YouTube Music"*)
      rm -f ~/.local/share/applications/YoutubeMusic.desktop ;;
    "WhatsApp"*)
      rm -f ~/.local/share/applications/WhatsApp.desktop ;;
    "AWS"*)
      rm -f ~/.local/share/applications/AWS.desktop ;;
    "Hermes Agent")
      rm -rf ~/.hermes/hermes-agent ~/.local/bin/hermes
      rm -rf ~/.config/Hermes 2>/dev/null || true ;;
  esac
}

echo ""
echo "Removing selected components..."
while IFS= read -r item; do
  [ -z "$item" ] && continue
  echo ""
  echo ">>> $item"
  remove_component "$item"
done <<< "$SELECTED"

# Clean up orphaned dependencies left behind by the removals above.
echo ""
echo "Running apt autoremove to clean up orphaned dependencies..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo ""
echo "Uninstall steps completed."
sleep 1
clear
source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu
