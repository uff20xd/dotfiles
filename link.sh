#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

symlinkFile() {
  filename="$SCRIPT_DIR/$1"
  destination="$HOME/$2"
  if [ -L "$destination" ]; then
    echo "[WARNING] $filename already symlinked"
    return
  fi

  if [ -e "$destination" ]; then
    echo "[ERROR] $destination exists but it's not a symlink. Please fix that manually"
    exit 1
  fi
  mkdir -p "$(dirname "$destination")"

  ln -s "$filename" "$destination"
  echo "[OK] Linked: $filename -> $destination"
}

symlinkFile "neovim" ".config/nvim"
symlinkFile "tmux" ".config/tmux"
symlinkFile "saltz" ".config/saltz"
