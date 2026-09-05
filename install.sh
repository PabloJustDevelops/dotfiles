#!/usr/bin/env bash
set -e
echo "Installing dotfiles with stow..."
for pkg in fastfetch starship fish zsh niri vesktop applications; do
  if [ -d "$pkg" ]; then
    echo "→ stow $pkg"
    stow -v -t ~ "$pkg" 2>&1 | head -5
  fi
done
echo "Done. Restart shell / Niri."
