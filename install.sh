#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES=(
    claude
    ghostty
    karabiner
    linearmouse
    nushell
    nvim
    starship
    tmux
    zshrc
)

echo "Stowing packages from $DOTFILES_DIR..."

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "  -> $pkg"
        stow "$pkg"
    else
        echo "  -- $pkg (not found, skipping)"
    fi
done

echo "Done!"
