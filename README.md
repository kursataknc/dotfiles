# Dotfiles

A highly opinionated, performance-oriented macOS development environment configuration. This repository manages configuration files using **GNU Stow**, featuring a modern terminal workflow centered around **Tmux**, **Nushell**, **Ghostty**, and **Neovim (LazyVim)**.

![Badge](https://img.shields.io/badge/OS-macOS-white)
![Badge](https://img.shields.io/badge/Shell-Zsh%20%2F%20Nushell-green)
![Badge](https://img.shields.io/badge/Terminal-Ghostty-black)
![Badge](https://img.shields.io/badge/Multiplexer-Tmux-blue)
![Badge](https://img.shields.io/badge/Editor-Neovim-brightgreen)
![Badge](https://img.shields.io/badge/AI-Claude%20Code-blueviolet)
![Badge](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-pink)

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Stow Packages](#stow-packages)
- [Neovim Configuration](#neovim-configuration)
- [Tmux Configuration](#tmux-configuration)
- [Claude Code Configuration](#claude-code-configuration)
- [Shell Configuration](#shell-configuration)
- [Ghostty Terminal](#ghostty-terminal)
- [Cheatsheet](#cheatsheet)

---

## Prerequisites

### 1. Package Manager & Fonts

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install a Nerd Font (JetBrains Mono recommended)
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. Core Dependencies

```bash
# Core tools
brew install stow git fzf zoxide bat eza yq

# Shells
brew install nushell starship

# Tmux
brew install tmux

# Neovim
brew install neovim
```

---

## Installation

```bash
git clone https://github.com/kursataknc/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Or install individual packages:

```bash
stow nvim       # Neovim config
stow tmux       # Tmux config
stow claude     # Claude Code config
stow nushell    # Nushell config
stow ghostty    # Ghostty terminal
stow starship   # Starship prompt
stow zshrc      # Zsh config
stow karabiner  # Karabiner-Elements
stow linearmouse # LinearMouse
```

> **Note:** API tokens and other secrets live in gitignored files that mirror each shell's config:
> - Zsh: `~/.config/zsh/secrets.zsh` (sourced from `.zshrc` if present)
> - Nushell: `~/.config/nushell/secrets.nu` (sourced from `env.nu`)
>
> `install.sh` creates empty placeholders on first run. Add your `export FOO=...` (zsh) or `$env.FOO = "..."` (nu) entries after install.

---

## Stow Packages

| Package | Target | Description |
| :--- | :--- | :--- |
| `claude` | `~/.claude/` | Claude Code settings, agents, commands, hooks, skills |
| `ghostty` | `~/.config/ghostty/` | Ghostty terminal configuration |
| `karabiner` | `~/.config/karabiner/` | Keyboard remapping |
| `linearmouse` | `~/.config/linearmouse/` | Mouse configuration |
| `nushell` | `~/.config/nushell/` | Nushell shell config |
| `nvim` | `~/.config/nvim/` | Neovim (LazyVim) configuration |
| `starship` | `~/.config/starship.toml` | Cross-shell prompt |
| `tmux` | `~/.config/tmux/` | Tmux multiplexer config |
| `zshrc` | `~/.zshrc` | Zsh shell config |

---

## Neovim Configuration

Built on **LazyVim** with custom plugins. Uses `lazy.nvim` as the package manager.

### Key Bindings

Leader key: `Space`

| Key | Action |
| :--- | :--- |
| `Space` + `ee` | Toggle file explorer (nvim-tree) |
| `Space` + `ef` | Find current file in explorer |
| `Space` + `ff` | Find files (Telescope) |
| `Space` + `fg` | Live grep (Telescope) |
| `Space` + `sv` | Split window vertically |
| `Space` + `sh` | Split window horizontally |
| `Space` + `nh` | Clear search highlights |
| `Space` + `mp` | Format file |
| `Space` + `hs` | Stage git hunk |
| `Space` + `hp` | Preview git hunk |
| `jk` | Exit insert mode |

### LazyVim Extras

Language support: Python, TypeScript, Go, Lua, JSON, TOML, Markdown, Nushell, Typst, CMake, Docker, R, SQL, Tailwind

### Adding Plugins

Create a new file in `nvim/.config/nvim/lua/kursataknc/plugins/`:

```lua
return {
  "author/plugin-name",
  opts = {
    -- your options
  },
}
```

Or use `:LazyExtras` in Neovim to toggle curated plugin bundles.

### Treemux (File Explorer Sidebar)

Treemux runs nvim-tree in a **separate tmux pane** with an isolated nvim instance (`NVIM_APPNAME=nvim-treemux`). This keeps the file explorer independent from the main editor.

| Key | Action |
| :--- | :--- |
| `l` / `Enter` | Open file in main editor |
| `v` | Open in vertical split |
| `h` | Close node |
| `u` | Go up a directory |
| `a` | Create file (append `/` for folder) |
| `d` | Delete |
| `r` | Rename |
| `Space` + `o` | Toggle Oil.nvim |

---

## Tmux Configuration

### Core Features
- **Prefix:** `Ctrl + A`
- **Shell:** Nushell
- **Theme:** Catppuccin Mocha (status bar at top)
- **Mouse:** Enabled
- **Clipboard:** System clipboard integration
- **Auto-restore:** Sessions restored on tmux start (tmux-continuum)
- **Turkish Q friendly:** Bindings avoid AltGr-only keys

### Plugin Ecosystem (TPM)

| Plugin | Description |
| :--- | :--- |
| **tmux-resurrect** | Persist environment across restarts |
| **tmux-continuum** | Auto-save every 15 mins + auto-restore on start |
| **tmux-sessionx** | Session manager with preview |
| **treemux** | File tree explorer sidebar |
| **catppuccin** | Theme |
| **tmux-fzf** | Fuzzy finder menus |
| **tmux-fzf-url** | Open URLs from terminal |
| **tmux-yank** | System clipboard integration |
| **tmux-cpu/battery** | System stats in status bar |
| **tmux-now-playing** | Currently playing music |

First-time setup: open tmux and press `Prefix` + `I` to install plugins.

### Key Bindings

All keys below are pressed after `Prefix` (`Ctrl + A`).

#### Session & Window

| Key | Action |
| :--- | :--- |
| `c` | New window (current path) |
| `Ctrl+C` | New window (home dir) |
| `Ctrl+D` | Detach from session |
| `Ctrl+A` | Toggle last window |
| `H` / `L` | Previous / Next window |
| `"` | Choose window (interactive) |
| `w` / `Ctrl+W` | List windows |
| `r` | Rename current window |
| `R` | Reload tmux config |
| `S` | Choose session |
| `o` | SessionX (fuzzy session manager) |
| `Ctrl+X` | Lock server |

#### Pane Management

| Key | Action |
| :--- | :--- |
| `\|` | Split window (horizontal default) |
| `v` | Split horizontally (current path) |
| `s` | Split vertically (current path) |
| `h` `j` `k` `l` | Navigate panes (repeatable within 500ms) |
| `,` / `.` | Resize pane left / right (repeatable) |
| `-` / `=` | Resize pane down / up (repeatable) |
| `z` | Toggle pane zoom |
| `x` | Kill current pane |
| `X` | Swap pane down |
| `N` | Swap pane up |
| `e` | Toggle synchronize-panes (echo to all) |
| `P` | Toggle pane border status |
| `K` | Send `clear` + Enter |
| `Ctrl+L` | Refresh client |

#### Plugins & Utilities

| Key | Action |
| :--- | :--- |
| `Tab` | Toggle treemux sidebar |
| `Space` | Interactive menu (tmux-menus) |
| `F` | FZF menu (tmux-fzf) |
| `u` | Open URLs with FZF |
| `y` | Copy to system clipboard (in copy mode) |
| `Y` | Copy current pane's working directory |
| `:` | tmux command prompt |

> **Note on overrides:** `tmux-yank` plugin binds `Y` and `y` after your config loads, so those keys serve clipboard actions rather than the usual tmux defaults.

---

## Claude Code Configuration

Claude Code settings, agents, commands, hooks, and skills are managed via stow.

### What's Included

| Component | Count | Description |
| :--- | :--- | :--- |
| **Agents** | 8 | code-reviewer, debugger, test-engineer, etc. |
| **Commands** | 8 | /commit, /pr, /optimize, /push-all, etc. |
| **Hooks** | 8 | security-scan, format-code, context-tracker, etc. |
| **Skills** | 27 | refactor, code-review, mcp-builder, etc. |
| **Plugins** | 50+ | oh-my-claudecode, context7, superpowers, etc. |

### What's NOT Tracked

Session data, history, image cache, backups, and plugin cache are gitignored.

---

## Shell Configuration

Supports both **Zsh** and **Nushell** with **Starship** prompt.

### Aliases

Shared aliases live in two mirrored files (kept in sync manually):
- `~/.config/zsh/aliases.zsh`
- `~/.config/nushell/aliases.nu`

Both shells source these at startup. Shell-specific aliases and helper functions stay in the main config (`.zshrc` / `config.nu`).

| Alias | Scope | Description |
| :--- | :--- | :--- |
| `l` / `ll` / `lt` | both | `eza` based listing (long / plain / tree) |
| `v` | both | Open Neovim |
| `gc` / `gp` / `gst` / `glog` | both | Git commit / push / status / log |
| `k` / `kg` / `kd` | both | Kubectl, get, describe |
| `dco` / `dps` / `dx` | both | Docker compose / ps / exec |
| `..` / `...` / `....` | zsh | Navigate up directories |
| `cl` | zsh | Clear terminal |
| `c` | nu | Clear terminal |
| `cat` | zsh | `bat` (replaces `cat`) |

### Tools
- **Starship:** Cross-shell prompt
- **Zoxide:** Smarter `cd` (`z <dir>`)
- **Eza:** Modern `ls` replacement
- **Bat:** Modern `cat` with syntax highlighting

---

## Ghostty Terminal

- **Theme:** Catppuccin Mocha
- **Font:** JetBrains Mono Nerd Font (14px)
- **Shell:** Nushell

---

## Cheatsheet

### Essentials
- **Prefix:** `Ctrl + A`
- **Split Pane:** `|` (Horizontal) / `s` (Vertical)
- **Navigation:** `h` `j` `k` `l` (Panes) / `H` `L` (Windows)
- **Zoom Pane:** `z`
- **File Explorer:** `Space` + `ee` (nvim) / `Prefix` + `Tab` (tmux)
- **Find Files:** `Space` + `ff`
- **Live Grep:** `Space` + `fg`

### Power Tools
- **Session Manager:** `Prefix` + `o`
- **Command Menu:** `Prefix` + `Space`
- **FZF Menu:** `Prefix` + `F`
- **URL Opener:** `Prefix` + `u`
- **Format Code:** `Space` + `mp`
- **Git Hunks:** `Space` + `hs` (stage) / `Space` + `hp` (preview)
