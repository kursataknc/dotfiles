#!/usr/bin/env bash
# Linux installer — sibling to install.sh. Skips macOS-only packages and
# replaces the launchctl/dscl/chsh dance with /etc/shells + chsh -s.
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES=(
    claude
    ghostty
    nushell
    nvim
    starship
    tmux
    zshrc
)

echo "Preparing generated/gitignored files..."

# Secrets files — gitignored, created empty if missing
mkdir -p "$HOME/.config/nushell"
touch "$HOME/.config/nushell/secrets.nu"
mkdir -p "$HOME/.config/zsh"
touch "$HOME/.config/zsh/secrets.zsh"

# Nushell tool init files — generated, must exist for config.nu to parse.
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

# Git clean filter — normalizes Claude Code plugin state files on commit
if [ -d "$DOTFILES_DIR/.git" ] && command -v jq >/dev/null 2>&1; then
    echo "Registering git clean filter for plugin state..."
    git -C "$DOTFILES_DIR" config --local filter.normalize-plugins.clean \
        "$DOTFILES_DIR/scripts/normalize-plugins.sh"
fi

# Linux shell integration — register nu in /etc/shells and chsh to it.
NU_PATH="$(command -v nu || true)"

if [ -n "$NU_PATH" ] && [ -x "$NU_PATH" ]; then
    echo "Configuring Linux shell integration..."

    if ! grep -qx "$NU_PATH" /etc/shells 2>/dev/null; then
        echo "  -> Adding $NU_PATH to /etc/shells (sudo required)"
        echo "$NU_PATH" | sudo tee -a /etc/shells >/dev/null
    fi

    current_shell="$(getent passwd "$USER" | cut -d: -f7)"
    if [ "$current_shell" != "$NU_PATH" ]; then
        echo "  -> Setting login shell to $NU_PATH (chsh)"
        chsh -s "$NU_PATH"
    fi
else
    echo "Nushell not found in PATH, skipping shell setup"
fi

echo "Done!"
