# ==============================================================================
# 1. INSTANT PROMPT (P10K)
# ==============================================================================
# Powerlevel10k kullanıyorsanız bu blok en üstte kalmalı. Starship kullanıyorsanız
# bu kısım etkisizdir ama durmasının zararı yoktur (cache varsa okur).
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. ENVIRONMENT VARIABLES (GLOBAL)
# ==============================================================================
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="/opt/homebrew/bin/nvim" # Varsayılan editör
export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/.pyenv"
export KUBECONFIG=~/.kube/config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export NIX_CONF_DIR=$HOME/.config/nix

# ==============================================================================
# 3. PATH SETTINGS
# ==============================================================================
# Tüm PATH eklemeleri burada toplanmıştır. Sıralama önemlidir (Soldakiler öncelikli).
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.local/opt/go/bin:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/run/current-system/sw/bin" # Nix binaries
export PATH="$PATH:/Users/kursataknc/.vimpkg/bin"

# Envman (varsa)
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ==============================================================================
# 4. OH MY ZSH & PLUGINS
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
# 5. COMPLETIONS & KEYBINDINGS
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
# 6. PROMPT & THEME (STARSHIP vs P10K)
# ==============================================================================
# --- OPTION A: STARSHIP (Aktif) ---
if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init zsh)"
fi

# --- OPTION B: POWERLEVEL10K (Pasif - Aktif etmek için üsttekini yorumla, burayı aç) ---
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================
# 7. TOOL INITIALIZATIONS
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

# iTerm2 Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Nix Daemon
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# ==============================================================================
# 8. ALIASES
# ==============================================================================
# General
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl='clear'
alias la=tree
alias cat=bat
alias py='python3'
alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

# Eza (ls replacement)
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# Vim / Editor
alias v="nvim" # PATH içinde Nix veya Brew nvim'i hangisi öncelikliyse o çalışır

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Kubernetes
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs -f" # Tekrar eden alias birleştirildi
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias ke="kubectl exec -it"
alias kc="kubectx"
alias kns="kubens"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

# Network & Security
alias http="xh"
alias nm="nmap -sC -sV -oN nmap"
alias gobust='gobuster dir --wordlist ~/security/wordlists/diccnoext.txt --wildcard --url'
alias dirsearch='python dirsearch.py -w db/dicc.txt -b -u'
alias massdns='~/hacking/tools/massdns/bin/massdns -r ~/hacking/tools/massdns/lists/resolvers.txt -t A -o S bf-targets.txt -w livehosts.txt -s 4000'
alias server='python -m http.server 4445'
alias tunnel='ngrok http 4445'
alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
alias grtools='~/go/src/github.com/tomnomnom/gf/gf' # Alias ismi çakışmaması için 'gr' -> 'grtools' yapıldı (gr git remote ile çakışıyor)

# ==============================================================================
# 9. FUNCTIONS
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
# 10. WARP & FINAL HOOKS
# ==============================================================================
# Auto-Warpify
[[ "$-" == *i* ]] && printf 'P$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "Darwin" }}?'
# Added by Antigravity
export PATH="/Users/kursataknc/.antigravity/antigravity/bin:$PATH"
