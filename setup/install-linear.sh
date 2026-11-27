#!/bin/bash

# Linear web app launcher (Omarchy web app)
if [[ ! -f "$HOME/.local/share/applications/Linear.desktop" ]]; then
  omarchy-webapp-install "Linear" "https://linear.app" \
    "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/linear.png"
else
  echo "Linear web app already installed — skipping"
fi
