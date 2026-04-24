#!/usr/bin/env bash
# Git clean filter for Claude Code plugin state.
#
# Strips volatile fields that change every Claude Code session
# (scope toggling user<->project, timestamps, projectPath) so the
# repo only records meaningful plugin list changes.
#
# Wired up via .gitattributes:
#   claude/.claude/plugins/installed_plugins.json filter=normalize-plugins
#   claude/.claude/plugins/known_marketplaces.json filter=normalize-plugins
#
# Registered per-repo in install.sh:
#   git config --local filter.normalize-plugins.clean <path-to-this-script>

set -euo pipefail

# Fall back to identity if jq is missing so the repo doesn't wedge.
if ! command -v jq >/dev/null 2>&1; then
    cat
    exit 0
fi

input=$(cat)

if jq -e '.plugins' <<<"$input" >/dev/null 2>&1; then
    jq '.plugins |= with_entries(
          .value |= map(
                .scope = "user"
              | del(.lastUpdated)
              | del(.projectPath)
          )
        )' <<<"$input"
elif jq -e 'to_entries | .[0].value.installLocation // empty' <<<"$input" >/dev/null 2>&1; then
    # known_marketplaces.json — top-level object keyed by marketplace name.
    jq 'with_entries(.value |= del(.lastUpdated))' <<<"$input"
else
    echo "$input"
fi
