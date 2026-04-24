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

# ==============================================================================
# macOS shell integration — make nushell the login shell system-wide.
# Safe to re-run: each step is idempotent.
# ==============================================================================
NU_PATH="/opt/homebrew/bin/nu"

if [ -x "$NU_PATH" ]; then
    echo "Configuring macOS shell integration..."

    # 1. Register nu in /etc/shells so chsh accepts it
    if ! grep -qx "$NU_PATH" /etc/shells 2>/dev/null; then
        echo "  -> Adding $NU_PATH to /etc/shells (sudo required)"
        echo "$NU_PATH" | sudo tee -a /etc/shells >/dev/null
    fi

    # 2. Change login shell if not already nu
    current_shell=$(dscl . -read ~ UserShell 2>/dev/null | awk '{print $2}')
    if [ "$current_shell" != "$NU_PATH" ]; then
        echo "  -> Setting login shell to $NU_PATH"
        chsh -s "$NU_PATH"
    fi

    # 3. Set $SHELL at launchd level so GUI-launched apps (Ghostty, tmux) inherit it
    launchctl setenv SHELL "$NU_PATH"

    # 4. Persist across reboots via a LaunchAgent that runs at login
    AGENT_PLIST="$HOME/Library/LaunchAgents/com.user.shellenv.plist"
    mkdir -p "$(dirname "$AGENT_PLIST")"
    cat > "$AGENT_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.shellenv</string>
    <key>ProgramArguments</key>
    <array>
        <string>sh</string>
        <string>-c</string>
        <string>launchctl setenv SHELL $NU_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST
    launchctl unload "$AGENT_PLIST" 2>/dev/null || true
    launchctl load "$AGENT_PLIST"
else
    echo "Nushell not found at $NU_PATH, skipping shell setup"
fi

echo "Done!"
