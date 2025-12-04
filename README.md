# 🏠 Dotfiles

Modern macOS development environment dotfiles, managed with GNU Stow.

## 📦 What's Inside

- **Shell**: Zsh + Oh My Zsh, Nushell
- **Prompt**: Starship (cross-shell)
- **Terminal**: Ghostty (GPU-accelerated)
- **Editor**: Neovim
- **Theme**: Catppuccin (Mocha)
- **Font**: JetBrainsMono Nerd Font
- **Keyboard**: Karabiner-Elements
- **Mouse**: LinearMouse
- **Tools**: fzf, eza, bat, zoxide, direnv

## 🚀 Quick Start

### Prerequisites

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install GNU Stow
brew install stow
```

### Installation

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install individual packages with stow
stow zshrc       # Zsh configuration
stow nushell     # Nushell configuration
stow starship    # Starship prompt
stow ghostty     # Ghostty terminal
stow tmux        # Tmux terminal multiplexer
stow karabiner   # Keyboard remapping
stow linearmouse # Mouse settings

# Or install everything at once
stow */
```

## 📚 Dependencies

### Essential Tools

```bash
# Core utilities
brew install \
  neovim \
  starship \
  fzf \
  fd \
  ripgrep \
  eza \
  bat \
  tree \
  git-delta

# Shell enhancements
brew install \
  zsh-autosuggestions \
  direnv \
  tmux

# Development tools
brew install \
  pyenv \
  nushell \
  go \
  rust
```

### Terminal & UI

```bash
# Terminal emulator
brew install --cask ghostty

# Font
brew install --cask font-jetbrains-mono-nerd-font

# System tools
brew install --cask karabiner-elements
brew install --cask linearmouse
```

### Optional Tools (Install After Setup)

```bash
# History & Navigation (recommended)
brew install zoxide

# Cloud & DevOps
brew install kubectl kubectx helm
brew install --cask docker

# Nix package manager (optional)
curl -L https://nixos.org/nix/install | sh
```

## ⚙️ Post-Installation Setup

### 1. Initialize Tool Integrations

#### For Zsh

```bash
# Reload your shell first
source ~/.zshrc

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# Already configured in .zshrc, just verify it works
z <directory>  # test zoxide
```

#### For Nushell

```bash
# Generate integration files (run once)
zoxide init nushell | save -f ~/.zoxide.nu
starship init nu | save -f ~/.cache/starship/init.nu

# Uncomment these lines in ~/.config/nushell/config.nu:
# source ~/.zoxide.nu
```

#### Customizing Nushell Config Location

By default, Nushell looks for config files in `~/.config/nushell/`. To use a custom location (e.g., from this dotfiles repo), set environment variables:

```bash
# In your shell profile (~/.zshrc or ~/.bashrc), add:
export NU_CONFIG_FILE="$HOME/dotfiles/nushell/.config/nushell/config.nu"
export NU_ENV_FILE="$HOME/dotfiles/nushell/.config/nushell/env.nu"

# Or set them before launching Nushell:
NU_CONFIG_FILE=~/dotfiles/nushell/.config/nushell/config.nu nu
```

These environment variables override the default paths. See the [Nushell configuration documentation](https://www.nushell.sh/book/configuration.html) for more details.

### 2. Tmux Setup

```bash
# 1. Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# 2. Stow tmux configuration
cd ~/dotfiles
stow tmux

# 3. Start tmux
tmux

# 4. Inside tmux, press: Ctrl+A + I (capital I) to install all plugins
# Wait for plugins to download and install (you'll see a success message)
# Press Ctrl+A + r to reload config after installation
```

**Important:** TPM only installs the plugin manager itself. You **must** press `Ctrl+A + I` inside tmux to install all plugins from your config. This will download all plugins to `~/.config/tmux/plugins/`.

**Features:**
- Prefix key: `Ctrl+A` (instead of default `Ctrl+B`)
- Catppuccin Mocha theme on top status bar
- Vi-style keybindings in copy mode
- Auto-restore sessions on restart
- Custom plugins for session management (SessionX), floating panes (Floax), and URL handling

**Key plugins:**
- TPM (plugin manager), tmux-sensible, tmux-yank
- tmux-resurrect & tmux-continuum (session persistence)
  - Sessions auto-save every 15 minutes
  - Manual save: `Ctrl+A` + `Ctrl+S`
  - Manual restore: `Ctrl+A` + `Ctrl+R`
  - "No resurrect file" means no session saved yet
- tmux-thumbs (quick text copying), tmux-fzf-url (URL opener)
- catppuccin-tmux, tmux-sessionx, tmux-floax (custom forks)

### 3. Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "nvim"
```

### 4. Set Default Shell (Optional)

```bash
# If you want to use Nushell as default
echo $(which nu) | sudo tee -a /etc/shells
chsh -s $(which nu)

# Or keep using Zsh (already default on macOS)
```

### 5. Ghostty Terminal

- Open Ghostty
- Theme will auto-load (Catppuccin Mocha)
- Default shell is set to Nushell in config

### 6. Karabiner-Elements

- Open Karabiner-Elements
- Grant necessary permissions in System Settings
- Configuration will auto-load

## 🎨 Customization

### Starship Prompt

Edit `~/.config/starship.toml`:
- Left prompt: OS icon, directory, character
- Right prompt: Git, languages, time, battery, etc.

### Zsh

Edit `~/.zshrc`:
- Section 2: Environment variables
- Section 3: PATH configuration
- Section 8: Aliases
- Section 9: Custom functions

### Nushell

- `~/.config/nushell/config.nu`: Main configuration, aliases, keybindings
- `~/.config/nushell/env.nu`: Environment variables, PATH

### Ghostty

Edit `~/.config/ghostty/config`:
- Change theme: `theme = catppuccin-latte` (or frappe, macchiato, mocha)
- Font size: `font-size = 12`
- Opacity: `background-opacity = 0.9`

## 📁 Structure

```
dotfiles/
├── ghostty/          # Terminal config
│   └── .config/ghostty/
├── karabiner/        # Keyboard remapping
│   └── .config/karabiner/
├── linearmouse/      # Mouse settings
│   └── .config/linearmouse/
├── nushell/          # Nushell shell
│   └── .config/nushell/
├── starship/         # Starship prompt
│   └── .config/
├── zshrc/            # Zsh shell
│   ├── .zshrc
│   └── .p10k.zsh
├── .gitignore
├── .stowrc
└── README.md
```

## 🔧 Maintenance

### Update

```bash
cd ~/dotfiles
git pull

# Re-stow if needed
stow --restow */
```

### Backup Current Configs

```bash
# Before installing, backup existing configs
mkdir -p ~/dotfiles-backup
cp -r ~/.config ~/dotfiles-backup/
cp ~/.zshrc ~/dotfiles-backup/
```

### Uninstall

```bash
cd ~/dotfiles
stow -D */  # Unstow all packages
```

## 💡 Tips

- **Zsh Keybindings**:
  - `jj` → Exit insert mode (vi mode)
  - `Ctrl+w` → Execute suggestion
  - `Ctrl+e` → Accept suggestion
  - `Ctrl+u` → Toggle suggestions

- **Aliases**:
  - `l` → `eza -l --icons --git -a` (better ls)
  - `v` → `nvim`
  - `gc` → `git commit -m`
  - `k` → `kubectl`

- **Nushell**:
  - Tab completion is powerful
  - `help commands` → List all commands
  - `config reload` → Reload config without restart

---

## ⌨️ Keyboard Shortcuts & Aliases

Complete reference for all shortcuts, aliases, and keybindings across the system.

<details>
<summary><b>📂 Navigation & File Management</b></summary>

### Shell Aliases (Zsh & Nushell)

| Alias | Command | Description |
|-------|---------|-------------|
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `....` | `cd ../../..` | Go up three directories |
| `l` | `eza -l --icons --git -a` | List all files with icons |
| `ll` | `ls -l` (nu) / `eza` (zsh) | Long list format |
| `lt` | `eza --tree --level=2 --long --icons --git` | Tree view (2 levels) |
| `ltree` | `eza --tree --level=2 --icons --git` | Tree view without details |
| `la` | `tree` | Tree view (all files) |

### Custom Functions

| Function | Usage | Description |
|----------|-------|-------------|
| `cx <dir>` | `cx ~/projects` | Change directory and list contents |
| `fcd` | `fcd` | Fuzzy find and cd into directory |
| `fv` | `fv` | Fuzzy find and open file in nvim |
| `f` | `f` | Fuzzy find file and copy path to clipboard |
| `rr` | `rr` | Launch Ranger file manager |
| `ff` | `ff` (nu only) | Fuzzy find window (Aerospace) |

</details>

<details>
<summary><b>📝 Editor & Tools</b></summary>

| Alias | Command | Description |
|-------|---------|-------------|
| `v` | `nvim` | Open Neovim |
| `cl` | `clear` | Clear terminal |
| `c` | `clear` | Clear terminal (Nushell) |
| `cat` | `bat` | Better cat with syntax highlighting |
| `py` | `python3` | Python 3 shortcut |

</details>

<details>
<summary><b>🔧 Git Shortcuts</b></summary>

### Basic Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `gst` | `git status` | Show working tree status |
| `ga` | `git add -p` | Interactive staging |
| `gadd` | `git add` | Add files to staging |
| `gc` | `git commit -m` | Commit with message |
| `gca` | `git commit -a -m` | Commit all changes with message |
| `gp` | `git push origin HEAD` | Push current branch |
| `gpu` | `git pull origin` | Pull from origin |

### Branch Management

| Alias | Command | Description |
|-------|---------|-------------|
| `gb` | `git branch` | List branches |
| `gba` | `git branch -a` | List all branches (including remote) |
| `gco` | `git checkout` | Switch branches |
| `gcoall` | `git checkout -- .` | Discard all changes |

### Viewing & Inspection

| Alias | Command | Description |
|-------|---------|-------------|
| `glog` | `git log --graph --pretty` | Beautiful git log with graph |
| `gdiff` | `git diff` | Show changes |
| `gr` | `git remote` | Show remote repositories |
| `gre` | `git reset` | Reset current HEAD |

</details>

<details>
<summary><b>🐳 Docker Shortcuts</b></summary>

| Alias | Command | Description |
|-------|---------|-------------|
| `dco` | `docker compose` | Docker Compose shortcut |
| `dps` | `docker ps` | List running containers |
| `dpa` | `docker ps -a` | List all containers |
| `dl` | `docker ps -l -q` | Get last container ID |
| `dx` | `docker exec -it` | Execute interactive command in container |

</details>

<details>
<summary><b>☸️ Kubernetes Shortcuts</b></summary>

### Basic Commands

| Alias | Command | Description |
|-------|---------|-------------|
| `k` | `kubectl` | Kubernetes CLI |
| `ka` | `kubectl apply -f` | Apply configuration |
| `kg` | `kubectl get` | Get resources |
| `kd` | `kubectl describe` | Describe resources |
| `kdel` | `kubectl delete` | Delete resources |
| `kl` | `kubectl logs -f` | Follow logs |

### Resource Shortcuts

| Alias | Command | Description |
|-------|---------|-------------|
| `kgpo` | `kubectl get pod` | List pods |
| `kgd` | `kubectl get deployments` | List deployments |
| `ke` | `kubectl exec -it` | Execute command in pod |

### Context Management

| Alias | Command | Description |
|-------|---------|-------------|
| `kc` | `kubectx` | Switch Kubernetes context |
| `kns` | `kubens` | Switch namespace |
| `kcns` | `kubectl config set-context --current --namespace` | Set namespace for current context |

</details>

<details>
<summary><b>🔐 Network & Security Tools</b></summary>

| Alias | Command | Description |
|-------|---------|-------------|
| `http` | `xh` | Modern HTTP client |
| `nm` | `nmap -sC -sV -oN nmap` | Nmap scan with scripts |
| `server` | `python -m http.server 4445` | Start local HTTP server |
| `tunnel` | `ngrok http 4445` | Expose local server with ngrok |
| `fuzz` | `ffuf -w ... -mc all -u` | Web fuzzing |
| `gobust` | `gobuster dir --wordlist ...` | Directory bruteforcing |

</details>

<details>
<summary><b>⌨️ Terminal Keybindings</b></summary>

### Zsh (Vi Mode)

| Keys | Action | Description |
|------|--------|-------------|
| `jj` | Normal mode | Exit insert mode (alternative to ESC) |
| `^L` | Forward word | Jump to next word |
| `^k` | Previous line | Move up in history |
| `^j` | Next line | Move down in history |
| `^w` | Execute suggestion | Run suggested command |
| `^e` | Accept suggestion | Accept and insert suggestion |
| `^u` | Toggle suggestions | Enable/disable suggestions |

### Ghostty Terminal

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Cmd+C` | Copy | Copy selected text |
| `Cmd+V` | Paste | Paste from clipboard |
| `Cmd+N` | New window | Open new terminal window |
| `Cmd+T` | New tab | Open new tab |
| `Cmd+W` | Close | Close current tab/window |
| `Cmd+Shift+T` | Reload config | Reload Ghostty configuration |

</details>

<details>
<summary><b>🪟 Tmux Shortcuts</b></summary>

> **Prefix Key**: `Ctrl+A` (press this before any command below)

### Sessions

```bash
tmux                        # Start new session
tmux new -s <name>         # Named session
tmux ls                    # List sessions
tmux attach -t <name>      # Attach to session
tmux kill-session -t <name> # Kill session
```

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `Ctrl+D` | Detach from session |
| `Ctrl+A` + `S` | Choose session from list |
| `Ctrl+A` + `$` | Rename current session |
| `Ctrl+A` + `o` | SessionX: fuzzy session switcher |

### Windows

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `Ctrl+C` | Create new window (at HOME) |
| `Ctrl+A` + `w` or `Ctrl+W` | List all windows |
| `Ctrl+A` + `r` | Rename current window |
| `Ctrl+A` + `"` | Choose window from list |
| `Ctrl+A` + `H` | Previous window |
| `Ctrl+A` + `L` | Next window |
| `Ctrl+A` + `Ctrl+A` | Switch to last window |

### Panes (Splits)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `v` | Split vertically (side by side) |
| `Ctrl+A` + `s` | Split horizontally (top/bottom) |
| `Ctrl+A` + `\|` | Split window (default) |
| `Ctrl+A` + `h/j/k/l` | Navigate panes (vim-style) |
| `Ctrl+A` + `Ctrl+L` or `l` | Refresh client |
| `Ctrl+A` + `z` | Toggle pane zoom (fullscreen) |
| `Ctrl+A` + `c` | Kill current pane |
| `Ctrl+A` + `x` | Swap pane down |
| `Ctrl+A` + `*` | Synchronize panes (toggle) |
| `Ctrl+A` + `P` | Toggle pane border status |

### Pane Resizing

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `,` | Resize pane left (20 cols) |
| `Ctrl+A` + `.` | Resize pane right (20 cols) |
| `Ctrl+A` + `-` | Resize pane down (7 rows) |
| `Ctrl+A` + `=` | Resize pane up (7 rows) |

### Copy Mode (Vi-style)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `[` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Copy selection and exit |
| `q` | Exit copy mode |
| `/` | Search forward |
| `?` | Search backward |

### Plugins & System

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `I` | Install plugins (TPM) |
| `Ctrl+A` + `U` | Update plugins (TPM) |
| `Ctrl+A` + `r` | Reload tmux config (with message) |
| `Ctrl+A` + `R` | Reload tmux config (silent) |
| `Ctrl+A` + `Ctrl+X` | Lock server |
| `Ctrl+A` + `p` | Floax: floating pane |
| `Ctrl+A` + `u` | FZF URL: open URLs |
| `Ctrl+A` + `Space` | Thumbs: quick copy text |
| `Ctrl+A` + `K` | Clear terminal |
| `Ctrl+A` + `:` | Command prompt |
| `Ctrl+A` + `?` | List all key bindings |

</details>

<details>
<summary><b>🔄 History & Smart Navigation</b></summary>

### Zoxide (Smart CD)
- `z <query>` → Jump to directory matching query
- `zi` → Interactive directory selection
- `z -` → Go to previous directory

### FZF Integration
- `Ctrl+T` → Fuzzy find files
- `Ctrl+R` → Fuzzy find history (if no Atuin)
- `Alt+C` → Fuzzy find and cd into directory

</details>

<details>
<summary><b>💡 Pro Tips & Workflows</b></summary>

### Command Combinations

```bash
# Quick commit and push
gc "feat: add feature" && gp

# Kubernetes pod logs
kgpo | fzf | xargs kubectl logs -f

# Development workflow
cx ~/projects/myapp  # cd and list
v .                  # open nvim
gst                  # check status
```

### Nushell Specific
- `config reload` → Reload Nushell config
- `help commands` → List all commands
- `which <command>` → Show command location
- `$env` → Show all environment variables

### Zsh Specific
- `source ~/.zshrc` → Reload Zsh config
- `bindkey` → Show all keybindings
- `alias` → Show all aliases

</details>

---

## 🐛 Troubleshooting

### Starship not showing git info in Nushell

Check `$env.STARSHIP_CONFIG` path:
```bash
echo $env.STARSHIP_CONFIG  # Should be ~/.config/starship.toml
```

### Zsh completions not working

```bash
rm -f ~/.zcompdump
autoload -Uz compinit && compinit
```

### Permissions issues with Karabiner

Go to System Settings → Privacy & Security → Input Monitoring and grant access.

## 📝 Notes

- **Nushell history** is gitignored by default
- Starship config works for both Zsh and Nushell
- P10k config is included but disabled (Starship is active)
- Some paths may need adjustment based on your username

## 📄 License

MIT

---

**Maintained by**: [Your Name](https://github.com/kursataknc)
