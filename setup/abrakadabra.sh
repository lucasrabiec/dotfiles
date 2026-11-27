#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

bash "$SCRIPT_DIR/remove-preinstalled.sh"

bash "$SCRIPT_DIR/install-7zip.sh"
bash "$SCRIPT_DIR/install-arctis.sh"
bash "$SCRIPT_DIR/install-diff-so-fancy.sh"
bash "$SCRIPT_DIR/install-discord.sh"
bash "$SCRIPT_DIR/install-evolution.sh"
bash "$SCRIPT_DIR/install-font.sh"
bash "$SCRIPT_DIR/install-ghostty.sh"
bash "$SCRIPT_DIR/install-linear.sh"
bash "$SCRIPT_DIR/install-lsd.sh"
bash "$SCRIPT_DIR/install-oh-my-posh.sh"
bash "$SCRIPT_DIR/install-rclone.sh"
bash "$SCRIPT_DIR/install-teams.sh"
bash "$SCRIPT_DIR/install-zsh-antidote.sh"
bash "$SCRIPT_DIR/install-yazi.sh"
