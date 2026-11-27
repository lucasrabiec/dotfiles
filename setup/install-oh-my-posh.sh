#!/bin/bash

yay -S --noconfirm --needed oh-my-posh-bin

# Remove a manually installed binary that would shadow the package in PATH
if [[ -f "$HOME/.local/bin/oh-my-posh" ]]; then
  echo "Removing manually installed $HOME/.local/bin/oh-my-posh..."
  rm "$HOME/.local/bin/oh-my-posh"
fi
