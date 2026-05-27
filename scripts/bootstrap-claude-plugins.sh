#!/usr/bin/env bash
# Bootstrap Claude Code marketplaces and plugins from manifests.
#
# Reads:
#   manifests/claude-marketplaces.txt — one source per line (URL/path/repo)
#   manifests/claude-plugins.txt      — one `plugin@marketplace` per line
#
# Idempotent: re-installing an existing plugin/marketplace is treated as success.
set -u

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MARKETPLACES_FILE="$DOTFILES_DIR/manifests/claude-marketplaces.txt"
PLUGINS_FILE="$DOTFILES_DIR/manifests/claude-plugins.txt"

if ! command -v claude >/dev/null 2>&1; then
    echo "claude CLI not found in PATH, skipping plugin bootstrap"
    exit 0
fi

read_manifest() {
    # Strip comments and blank lines; print remaining entries.
    grep -vE '^\s*(#|$)' "$1" 2>/dev/null || true
}

if [ -f "$MARKETPLACES_FILE" ]; then
    echo "Adding Claude Code marketplaces..."
    while IFS= read -r src; do
        [ -z "$src" ] && continue
        echo "  -> $src"
        if ! claude plugin marketplace add "$src" 2>&1 | grep -vE '^\s*$'; then
            echo "     (continuing — already present or non-fatal error)"
        fi
    done < <(read_manifest "$MARKETPLACES_FILE")
fi

if [ -f "$PLUGINS_FILE" ]; then
    echo "Installing Claude Code plugins..."
    while IFS= read -r spec; do
        [ -z "$spec" ] && continue
        echo "  -> $spec"
        if ! claude plugin install "$spec" 2>&1 | grep -vE '^\s*$'; then
            echo "     (continuing — already installed or non-fatal error)"
        fi
    done < <(read_manifest "$PLUGINS_FILE")
fi

echo "Claude Code plugin bootstrap done."
