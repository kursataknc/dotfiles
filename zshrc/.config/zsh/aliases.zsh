# ==============================================================================
# SHARED ALIASES (Zsh)
# ==============================================================================
# Keep in sync with: nushell/.config/nushell/aliases.nu
# Shell-specific aliases belong in .zshrc itself (functions, OS hacks, etc.)

# ------------------------------------------------------------------------------
# Listing (eza-based)
# ------------------------------------------------------------------------------
alias l="eza -l --icons --git -a"
alias ll="ls -l"
alias lt="eza --tree --level=2 --long --icons --git"

# ------------------------------------------------------------------------------
# Editor / Tools
# ------------------------------------------------------------------------------
alias v="nvim"
alias py="python3"

# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gadd="git add"
alias ga="git add -p"
alias gcoall="git checkout -- ."
alias gr="git remote"
alias gre="git reset"

# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# ------------------------------------------------------------------------------
# Kubernetes
# ------------------------------------------------------------------------------
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs -f"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias ke="kubectl exec -it"
alias kc="kubectx"
alias kns="kubens"
alias kcns="kubectl config set-context --current --namespace"
