# ==============================================================================
# 1. ENVIRONMENT VARIABLES (GLOBAL)
# ==============================================================================
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="/opt/homebrew/bin/nvim" # Varsayılan editör
export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/.pyenv"
export KUBECONFIG=~/.kube/config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export NIX_CONF_DIR=$HOME/.config/nix

# Secrets (not tracked by git — mirrors nushell/secrets.nu pattern)
[ -f "$HOME/.config/zsh/secrets.zsh" ] && source "$HOME/.config/zsh/secrets.zsh"

# ==============================================================================
# 2. PATH SETTINGS
# ==============================================================================
# Tüm PATH eklemeleri burada toplanmıştır. Sıralama önemlidir (Soldakiler öncelikli).
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.local/opt/go/bin:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/run/current-system/sw/bin" # Nix binaries
export PATH="$PATH:$HOME/.vimpkg/bin"

# Envman (varsa)
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ==============================================================================
# 3. OH MY ZSH & PLUGINS
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"

# NOT: Starship kullanıyorsan buradaki temayı kapatabilirsin veya
# p10k kullanmak istersen burayı açıp aşağıdan Starship'i kapatmalısın.
# ZSH_THEME="powerlevel10k/powerlevel10k" 
ZSH_THEME="" # Starship kullanıldığı için boş bırakıldı

# Pluginler
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ZSH Autosuggestions (Manuel yükleme)
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^w' autosuggest-execute
    bindkey '^e' autosuggest-accept
    bindkey '^u' autosuggest-toggle
fi

# ==============================================================================
# 4. COMPLETIONS & KEYBINDINGS
# ==============================================================================
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive completion

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Harici tamamlamalar
if command -v kubectl &> /dev/null; then source <(kubectl completion zsh); fi
if command -v aws_completer &> /dev/null; then complete -C '/usr/local/bin/aws_completer' aws; fi

# Keybindings
bindkey -v # Vi modu aktif
bindkey jj vi-cmd-mode # 'jj' ile normal moda geçiş
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# ==============================================================================
# 5. PROMPT (STARSHIP)
# ==============================================================================
if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init zsh)"
fi

# ==============================================================================
# 6. TOOL INITIALIZATIONS
# ==============================================================================
# Pyenv
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide (cd replacement)
if command -v zoxide &> /dev/null; then eval "$(zoxide init zsh)"; fi

# Atuin (History replacement)
if command -v atuin &> /dev/null; then eval "$(atuin init zsh)"; fi

# Direnv
if command -v direnv &> /dev/null; then eval "$(direnv hook zsh)"; fi

# Nix Daemon
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# ==============================================================================
# 7. ALIASES
# ==============================================================================
# Shared aliases (git, kubernetes, docker, editor, listing) live in:
#   ~/.config/zsh/aliases.zsh
# Keep in sync with nushell/.config/nushell/aliases.nu
source ~/.config/zsh/aliases.zsh

# --- Zsh-specific ---

# Navigation (Nushell doesn't allow dotted alias names)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Shortcuts
alias cl='clear'
alias la=tree
alias cat=bat
alias ltree="eza --tree --level=2 --icons --git"

# Network
alias http="xh"

# Terminal fun (requires a running tmux session)
alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

# ==============================================================================
# 8. FUNCTIONS
# ==============================================================================
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=( command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall" )
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}
alias rr='ranger'

cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# ==============================================================================
# 9. FINAL HOOKS
# ==============================================================================
# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# zsh-syntax-highlighting — must be sourced LAST per upstream docs
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
