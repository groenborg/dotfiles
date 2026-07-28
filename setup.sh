#!/bin/zsh
set -euo pipefail

DOTFILES="${0:A:h}"

# Seed per-machine files (untracked) before symlinking
if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$DOTFILES/templates/zshrc.local.example" "$HOME/.zshrc.local"
  echo "✓ created ~/.zshrc.local from template"
fi

# Back up any real files that would block stow
for f in .zshrc .zprofile; do
  if [[ -f "$HOME/$f" && ! -L "$HOME/$f" ]]; then
    mv "$HOME/$f" "$HOME/$f.backup.$(date +%Y%m%d%H%M%S)"
    echo "✓ backed up existing ~/$f"
  fi
done

stow -t ~/ zsh
stow -t ~/.config .config

echo "Symlinks in place. Machine-specific config: ~/.zshrc.local"
