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

echo "Preparing generated/gitignored files..."

# Secrets files — gitignored, created empty if missing
mkdir -p "$HOME/.config/nushell"
touch "$HOME/.config/nushell/secrets.nu"  # nushell env.nu sources this
mkdir -p "$HOME/.config/zsh"
touch "$HOME/.config/zsh/secrets.zsh"     # .zshrc sources this if present

# Nushell starship init — generated, must exist for config.nu to parse
mkdir -p "$HOME/.cache/starship"
if command -v starship >/dev/null 2>&1; then
    starship init nu > "$HOME/.cache/starship/init.nu"
else
    # Empty placeholder so `use` in config.nu doesn't break parsing
    touch "$HOME/.cache/starship/init.nu"
fi

echo "Stowing packages from $DOTFILES_DIR..."

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "  -> $pkg"
        stow --restow "$pkg"
    else
        echo "  -- $pkg (not found, skipping)"
    fi
done

echo "Done!"
