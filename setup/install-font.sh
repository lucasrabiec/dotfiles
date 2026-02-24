#!/bin/bash

set -euo pipefail

OM_BIN="$HOME/.local/share/omarchy/bin"

install_font() {
  local label="$1"
  local pkg="$2"
  local font="$3"

  echo "Installing ${label}..."
  "$OM_BIN/omarchy-pkg-add" "$pkg"
  sleep 1
  "$OM_BIN/omarchy-font-set" "$font"
}

install_font "JetBrains Mono" "ttf-jetbrains-mono-nerd" "JetBrainsMono Nerd Font"
