#!/bin/bash

APP=xournalpp

if pacman -Qi "$APP" >/dev/null 2>&1; then
  yay -Rns --noconfirm $APP
else
  echo " -> $APP not found -- skipping"
fi
