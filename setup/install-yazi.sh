#!/bin/bash

yay -S --noconfirm --needed yazi

pkg_file="$HOME/.config/yazi/package.toml"
plugins=(
  "macydnah/office"
  "yazi-rs/plugins:full-border"
  "yazi-rs/plugins:git"
  "yazi-rs/plugins:smart-enter"
  "yazi-rs/plugins:chmod"
)

for plugin in "${plugins[@]}"; do
  if [[ ! -f "$pkg_file" ]]; then
    ya pkg add "$plugin"
    continue
  fi

  if grep -Fq "use = \"$plugin\"" "$pkg_file"; then
    echo "Plugin $plugin already present in $pkg_file — skipping"
  else
    ya pkg add "$plugin"
  fi
done
