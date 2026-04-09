#!/bin/bash

# https://github.com/elegos/Linux-Arctis-Manager

# Check if linux-arctis-manager is installed
if ! pacman -Q linux-arctis-manager &>/dev/null; then
  # First time installation
  yay -S --noconfirm --needed linux-arctis-manager

  # Run initial setup commands
  lam-cli udev write-rules --force --reload
  lam-cli desktop write
  cp ~/.local/share/applications/ArctisManagerSystray.desktop ~/.config/autostart/
else
  # Already installed, just ensure it's up to date
  yay -S --noconfirm --needed linux-arctis-manager
fi
