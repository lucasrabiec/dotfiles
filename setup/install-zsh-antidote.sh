#!/bin/bash

target_dir="${ZDOTDIR:-$HOME}/.antidote"

if [ ! -d "$target_dir" ]; then
  echo "Cloning antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$target_dir"
else
  echo "Repository already exists at $target_dir — skipping clone"
fi
