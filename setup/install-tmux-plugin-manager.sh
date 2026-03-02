#!/bin/bash

repo_url="git@github.com:tmux-plugins/tpm.git"
target_dir="$HOME/.config/tmux/plugins/tpm"

if [[ -d "$target_dir/.git" ]]; then
  echo "Repository already exists at $target_dir — skipping clone"
else
  git clone "$repo_url" "$target_dir"
fi

tmux run-shell ~/.config/tmux/plugins/tpm/bin/install_plugins
