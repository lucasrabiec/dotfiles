#!/bin/bash

set -e

APP_NAMES=("Alacritty" "Basecamp" "Dropbox" "Google Contacts" "Google Messages" "Google Photos" "Hey" "imv" "typora" "Zoom")

ICON_DIR="$HOME/.local/share/applications/icons"
DESKTOP_DIR="$HOME/.local/share/applications/"

for APP_NAME in "${APP_NAMES[@]}"; do
  rm -f "$DESKTOP_DIR/$APP_NAME.desktop"
  rm -f "$ICON_DIR/$APP_NAME.png"
  echo "Removed $APP_NAME"
done
