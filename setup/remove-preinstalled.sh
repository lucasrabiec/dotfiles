#!/bin/bash
set -e

APP_NAMES=("Alacritty" "Basecamp" "Discord" "Dropbox" "Google Contacts" "Google Messages" "Google Photos" "Hey" "imv" "Zoom")

ICON_DIR="$HOME/.local/share/applications/icons"
DESKTOP_DIR="$HOME/.local/share/applications"

for APP in "${APP_NAMES[@]}"; do
  removed=0

  for FILE in \
    "$DESKTOP_DIR/$APP.desktop" \
    "$ICON_DIR/$APP.png"; do
    if [[ -f "$FILE" ]]; then
      rm "$FILE"
      removed=1
    fi
  done

  if ((removed)); then
    echo "Removed $APP"
  fi
done

if pacman -Q typora >/dev/null 2>&1; then
  echo "Removing typora..."
  yay -Rns --noconfirm typora
else
  echo "typora not installed, skipping"
fi
