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
- **Tools**: fzf, eza, bat, zoxide, atuin, direnv

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
  direnv

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
brew install zoxide atuin tmux

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

# Atuin (enhanced history)
eval "$(atuin init zsh)"

# Already configured in .zshrc, just verify they work
z <directory>  # test zoxide
atuin search   # test atuin
```

#### For Nushell

```bash
# Generate integration files (run once)
zoxide init nushell | save -f ~/.zoxide.nu
atuin init nu | save -f ~/.local/share/atuin/init.nu
starship init nu | save -f ~/.cache/starship/init.nu

# Uncomment these lines in ~/.config/nushell/config.nu:
# source ~/.zoxide.nu
# source ~/.local/share/atuin/init.nu
```

### 2. Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "nvim"
```

### 3. Set Default Shell (Optional)

```bash
# If you want to use Nushell as default
echo $(which nu) | sudo tee -a /etc/shells
chsh -s $(which nu)

# Or keep using Zsh (already default on macOS)
```

### 4. Ghostty Terminal

- Open Ghostty
- Theme will auto-load (Catppuccin Mocha)
- Default shell is set to Nushell in config

### 5. Karabiner-Elements

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

**Maintained by**: [Your Name](https://github.com/YOUR_USERNAME)
