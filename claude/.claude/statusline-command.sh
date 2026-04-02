#!/usr/bin/env bash
# Claude Code status line - inspired by Starship Catppuccin Mocha theme

input=$(cat)

# Extract fields from JSON input
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Catppuccin Mocha palette (ANSI 256-color approximations via truecolor)
# We use printf with ANSI escape sequences
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"

# Colors (truecolor)
BLUE="\033[38;2;137;180;250m"       # blue #89b4fa
PURPLE="\033[38;2;203;166;247m"     # mauve #cba6f7
GREEN="\033[38;2;166;227;161m"      # green #a6e3a1
RED="\033[38;2;243;139;168m"        # red #f38ba8
YELLOW="\033[38;2;249;226;175m"     # yellow #f9e2af
TEXT="\033[38;2;205;214;244m"       # text #cdd6f4
SUBTEXT="\033[38;2;166;173;200m"    # subtext0 #a6adc8

# OS symbol (macOS)
OS_SYMBOL=""

# Shorten the directory path (show last 3 segments, like Starship truncation_length=3)
if [ -n "$cwd" ]; then
    home_replaced="${cwd/#$HOME/~}"
    IFS='/' read -ra parts <<< "$home_replaced"
    total=${#parts[@]}
    if [ "$total" -le 3 ]; then
        short_dir="$home_replaced"
    else
        short_dir="…/${parts[$((total-2))]}/${parts[$((total-1))]}"
    fi
else
    short_dir="~"
fi

# Git info (using --no-optional-locks to avoid lock conflicts)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        # Git status flags
        status_flags=""
        git_status=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
        if [ -n "$git_status" ]; then
            echo "$git_status" | grep -q "^M\|^A\|^D\|^R\|^C" && status_flags="${status_flags}+"
            echo "$git_status" | grep -q "^.M\|^.D" && status_flags="${status_flags}!"
            echo "$git_status" | grep -q "^??" && status_flags="${status_flags}?"
        fi
        # Ahead/behind
        ahead=$(git -C "$cwd" --no-optional-locks rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        behind=$(git -C "$cwd" --no-optional-locks rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
        [ "$ahead" -gt 0 ] 2>/dev/null && status_flags="${status_flags}⇡"
        [ "$behind" -gt 0 ] 2>/dev/null && status_flags="${status_flags}⇣"

        git_info=" ${branch}"
        [ -n "$status_flags" ] && git_info="${git_info} ${status_flags}"
    fi
fi

# Context usage indicator
ctx_info=""
if [ -n "$used_pct" ]; then
    pct_int=${used_pct%.*}
    if [ "$pct_int" -ge 80 ] 2>/dev/null; then
        ctx_color="$RED"
    elif [ "$pct_int" -ge 50 ] 2>/dev/null; then
        ctx_color="$YELLOW"
    else
        ctx_color="$GREEN"
    fi
    ctx_info=" ${pct_int}%"
fi

# Build the status line
printf "${BOLD}${TEXT}${OS_SYMBOL}${RESET} "
printf "${BOLD}${BLUE}${short_dir}${RESET}"
if [ -n "$git_info" ]; then
    printf " ${PURPLE}${git_info}${RESET}"
fi
if [ -n "$model" ]; then
    printf " ${SUBTEXT}${model}${RESET}"
fi
if [ -n "$ctx_info" ]; then
    printf " ${ctx_color}ctx:${pct_int}%%${RESET}"
fi
printf "\n"
