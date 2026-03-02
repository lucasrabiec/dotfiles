#!/bin/bash

yay -S --noconfirm --needed yazi

pkg_file="$HOME/.config/yazi/package.toml"
plugin_office='macydnah/office'

if [[ ! -f "$pkg_file" ]]; then
  ya pkg add "$plugin_office"
  exit 0
fi

if grep -Fq "use = \"$plugin_office\"" "$pkg_file"; then
  echo "Plugin $plugin_office already present in $pkg_file — skipping"
else
  ya pkg add "$plugin_office"
fi
