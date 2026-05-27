#!/usr/bin/env bash
# Bootstrap Claude Code marketplaces and plugins for the current machine.
#
# Sources:
#   manifests/claude-marketplaces.txt — one source per line (URL/path/repo)
#   claude/.claude/settings.json      — enabledPlugins.<spec>=true is installed
#
# settings.json's enabledPlugins is the cross-platform source of truth for
# plugins. Marketplaces stay in a separate manifest because settings.json
# doesn't record their clone sources.
#
# Idempotent: re-installing existing plugins/marketplaces is treated as
# success; plugins missing from the marketplace are reported and skipped.
set -u

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MARKETPLACES_FILE="$DOTFILES_DIR/manifests/claude-marketplaces.txt"
SETTINGS_FILE="$DOTFILES_DIR/claude/.claude/settings.json"

if ! command -v claude >/dev/null 2>&1; then
    echo "claude CLI not found in PATH, skipping plugin bootstrap"
    exit 0
fi

if [ -f "$MARKETPLACES_FILE" ]; then
    echo "Adding Claude Code marketplaces..."
    while IFS= read -r src; do
        [ -z "$src" ] && continue
        echo "  -> $src"
        claude plugin marketplace add "$src" 2>&1 | sed 's/^/     /' || true
    done < <(grep -vE '^\s*(#|$)' "$MARKETPLACES_FILE")
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "jq not found; cannot read enabledPlugins from $SETTINGS_FILE. Install jq and re-run."
    exit 0
fi

if [ -f "$SETTINGS_FILE" ]; then
    echo "Installing enabled plugins from settings.json..."
    while IFS= read -r spec; do
        [ -z "$spec" ] && continue
        echo "  -> $spec"
        claude plugin install "$spec" 2>&1 | sed 's/^/     /' || true
    done < <(jq -r '.enabledPlugins // {} | to_entries[] | select(.value == true) | .key' "$SETTINGS_FILE")
fi

echo "Claude Code plugin bootstrap done."
