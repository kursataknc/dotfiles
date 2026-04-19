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

# Nushell tool init files — generated, must exist for config.nu to parse.
# Empty placeholders are created when the tool isn't installed so `use`
# doesn't break shell startup.

mkdir -p "$HOME/.cache/starship"
if command -v starship >/dev/null 2>&1; then
    starship init nu > "$HOME/.cache/starship/init.nu"
else
    touch "$HOME/.cache/starship/init.nu"
fi

mkdir -p "$HOME/.cache/zoxide"
if command -v zoxide >/dev/null 2>&1; then
    zoxide init nushell > "$HOME/.cache/zoxide/init.nu"
else
    touch "$HOME/.cache/zoxide/init.nu"
fi

mkdir -p "$HOME/.local/share/atuin"
if command -v atuin >/dev/null 2>&1; then
    atuin init nu > "$HOME/.local/share/atuin/init.nu"
else
    touch "$HOME/.local/share/atuin/init.nu"
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
