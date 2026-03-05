#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "$SCRIPT_DIR/remove-webapps.sh"

. "$SCRIPT_DIR/install-hyprsession.sh"
. "$SCRIPT_DIR/install-lsd.sh"
. "$SCRIPT_DIR/install-7zip.sh"
. "$SCRIPT_DIR/install-yazi.sh"
. "$SCRIPT_DIR/install-rclone.sh"
. "$SCRIPT_DIR/install-diff-so-fancy.sh"
. "$SCRIPT_DIR/install-tmux-plugin-manager.sh"

# TMP
# . "$SCRIPT_DIR/install-kitty.sh"
