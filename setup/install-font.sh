#!/bin/bash

set -euo pipefail

OM_BIN="$HOME/.local/share/omarchy/bin"

install_font() {
  local label="$1"
  local pkg="$2"
  local font="$3"

  current_font="$("$OM_BIN/omarchy-font-current" || true)"

  if [[ "$current_font" == "$font" ]]; then
    echo "${label} is already the current font. Skipping installation."
    return
  fi

  echo "Installing ${label}..."
  "$OM_BIN/omarchy-pkg-add" "$pkg"
  sleep 1
  "$OM_BIN/omarchy-font-set" "$font"
}

install_font "Fira Code" "ttf-firacode-nerd" "FiraCode Nerd Font"
