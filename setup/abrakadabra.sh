#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "$SCRIPT_DIR/remove-preinstalled.sh"

. "$SCRIPT_DIR/install-7zip.sh"
. "$SCRIPT_DIR/install-arctis.sh"
. "$SCRIPT_DIR/install-claude.sh"
. "$SCRIPT_DIR/install-diff-so-fancy.sh"
. "$SCRIPT_DIR/install-discord.sh"
. "$SCRIPT_DIR/install-evolution.sh"
. "$SCRIPT_DIR/install-font.sh"
. "$SCRIPT_DIR/install-ghostty.sh"
. "$SCRIPT_DIR/install-hyprsession.sh"
. "$SCRIPT_DIR/install-lsd.sh"
. "$SCRIPT_DIR/install-rclone.sh"
. "$SCRIPT_DIR/install-teams.sh"
. "$SCRIPT_DIR/install-tmux-plugin-manager.sh"
. "$SCRIPT_DIR/install-yazi.sh"
