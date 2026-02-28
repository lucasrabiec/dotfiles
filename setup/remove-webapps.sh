#!/bin/bash
set -e

APP_NAMES=("Alacritty" "Basecamp" "Dropbox" "Google Contacts" "Google Messages" "Google Photos" "Hey" "imv" "typora" "Zoom")

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
