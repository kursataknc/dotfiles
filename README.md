# 🚀 Dotfiles

A highly opinionated, performance-oriented macOS development environment configuration. This repository manages configuration files (dotfiles) using **GNU Stow**, featuring a modern terminal workflow centered around **Tmux**, **Nushell**, and **Ghostty**.

![Badge](https://img.shields.io/badge/OS-macOS-white)
![Badge](https://img.shields.io/badge/Shell-Zsh%20%2F%20Nushell-green)
![Badge](https://img.shields.io/badge/Terminal-Ghostty-black)
![Badge](https://img.shields.io/badge/Multiplexer-Tmux-blue)
![Badge](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-pink)

---

## 📋 Table of Contents

- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Tmux Configuration](#-tmux-configuration)
    - [Core Features](#core-features)
    - [Plugin Ecosystem](#plugin-ecosystem)
    - [Key Bindings](#-key-bindings)
- [Shell Configuration](#-shell-configuration)
- [Ghostty Terminal](#-ghostty-terminal)
- [Cheatsheet](#-cheatsheet)

---

## 🛠 Prerequisites

Before installing the dotfiles, ensure your system has the necessary base tools. This setup relies heavily on **Homebrew**.

### 1. Package Manager & Fonts
First, install Homebrew and a Nerd Font (required for icons in Starship and Tmux).

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install a Nerd Font (JetBrains Mono recommended)
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. Core Dependencies
Install the essential CLI tools required for the configurations to work correctly.

```bash
# Core tools
brew install stow git fzf zoxide bat eza yq

# Shells
brew install nushell starship

# Tmux & Extensions
brew install tmux
brew install arl/arl/gitmux  # Required for Tmux status bar git info
```

---

## 📥 Installation

This repository uses **GNU Stow** to symlink configuration files to their target locations.

### 1. Clone the Repository
Clone this repo to your home directory (or wherever you prefer).

```bash
git clone https://github.com/kursataknc/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Apply Configurations
Use `stow` to symlink the packages.

```bash
# Install specific configurations
stow tmux        # Links .config/tmux
stow ghostty     # Links .config/ghostty
stow starship    # Links .config/starship.toml
stow nushell     # Links Nushell config
stow zshrc       # Links .zshrc

# OR install everything at once
stow */
```

---

## 🖥 Tmux Configuration

The heart of this setup is a highly customized **Tmux** environment designed for speed and keyboard-centric workflows.

### Core Features
- **Prefix:** `Ctrl + A` (Remapped from default `Ctrl + B` for ergonomics).
- **Shell:** Defaults to `Nushell` (`/opt/homebrew/bin/nu`).
- **Theme:** Catppuccin Mocha (Rounded style).
- **Position:** Status bar at the top (macOS style).
- **Mouse Support:** Enabled.
- **Clipboard:** System clipboard integration (`set-clipboard on`).

### Plugin Ecosystem
This setup uses **TPM (Tmux Plugin Manager)**.

| Plugin | Description |
| :--- | :--- |
| **tpm** | Manages plugins. |
| **tmux-sensible** | Standard, sane defaults for tmux. |
| **tmux-resurrect** | Persists tmux environment across system restarts. |
| **tmux-continuum** | Automatically saves environment every 15 mins. |
| **tmux-sessionx** | Supercharged session manager with preview (bind: `o`). |
| **catppuccin** | Beautiful, consistent theme. |
| **tmux-fzf** | Manage tmux via fzf menus. |
| **tmux-fzf-url** | Quickly open URLs from terminal. |
| **tmux-cpu/battery** | System stats in status bar. |
| **treemux** | File tree explorer sidebar for tmux. |
| **tmux-menus** | Interactive menus for common tasks. |

#### ⚡️ First-Time Setup
After stowing the tmux config, you must install the plugins:
1. Open Tmux: `tmux`
2. Press **Prefix** + **I** (Capital i) to fetch and install plugins.

### ⌨️ Key Bindings

The configuration uses a custom reset file to keep bindings clean. The **Prefix** is `Ctrl + A`.

#### Window & Pane Management
| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `^C` | Create new window |
| `Prefix` + `|` | Split window **horizontally** |
| `Prefix` + `s` | Split window **vertically** |
| `Prefix` + `z` | Zoom/Unzoom current pane |
| `Prefix` + `x` | Swap pane down |
| `Prefix` + `c` | Kill current pane |
| `Prefix` + `h/j/k/l` | Navigate panes (Vim style) |
| `Prefix` + `H` | Previous window |
| `Prefix` + `L` | Next window |
| `Prefix` + `w` | List windows |
| `Prefix` + `r` | Rename window |

#### Session Management
| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `S` | Choose session (Standard) |
| `Prefix` + `^D` | Detach session |

#### Utility & System
| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `r` | **Reload config** (Source tmux.conf) |
| `Prefix` + `K` | Clear screen |
| `Prefix` + `*` | Synchronize panes (Type in all panes at once) |

### 🧩 Plugin Key Bindings (Expand for details)

<details>
<summary><strong>👉 SessionX (Advanced Session Manager)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `o` | **Open SessionX** |
| `?` | Toggle help window |
| `Ctrl` + `u` | Scroll up in preview |
| `Ctrl` + `d` | Scroll down in preview |
| `Ctrl` + `y` | Create new window (from inside SessionX) |
| `Enter` | Switch to selected session |
</details>

<details>
<summary><strong>👉 Tmux Menus (Interactive UI)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `Space` | **Open Main Menu** |
| `\` | Open Split Menu |
| `-` | Open Window Menu |
| `=` | Open Layout Menu |
</details>

<details>
<summary><strong>👉 Tmux FZF (Fuzzy Finder)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `F` | **Open FZF Menu** (Commands, Panes, Windows, etc.) |
</details>

<details>
<summary><strong>👉 Treemux (File Explorer)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `Tab` | **Toggle File Tree** |
</details>

<details>
<summary><strong>👉 Tmux Resurrect (Save/Restore)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `Ctrl-s` | **Save** environment |
| `Prefix` + `Ctrl-r` | **Restore** environment |
</details>

<details>
<summary><strong>👉 Tmux FZF URL (Link Opener)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `Prefix` + `u` | **List URLs** in current pane to open |
</details>

<details>
<summary><strong>👉 Tmux Yank (Clipboard)</strong></summary>

| Key Binding | Action |
| :--- | :--- |
| `y` | Copy selection to system clipboard (in Copy Mode) |
| `Y` | Copy current line (in Copy Mode) |
</details>

---

## 🐚 Shell Configuration

This setup supports both **Zsh** and **Nushell**, with **Starship** providing a unified prompt experience.

### Common Aliases
These aliases are available in both shells (via `.zshrc` and `config.nu`).

| Alias | Command | Description |
| :--- | :--- | :--- |
| `l` | `ls -l` | List files (long format) |
| `la` | `ls -la` | List all files (including hidden) |
| `v` | `nvim` | Open Neovim |
| `c` | `clear` | Clear terminal screen |
| `..` | `cd ..` | Go up one directory |

### Tools
- **Starship:** Cross-shell prompt with custom presets.
- **Zoxide:** Smarter `cd` command. Usage: `z <dir>`.
- **Eza:** Modern replacement for `ls` (used in aliases if installed).
- **Bat:** Modern replacement for `cat` with syntax highlighting.

---

## 👻 Ghostty Terminal

**Ghostty** is the primary terminal emulator for this configuration.

- **Theme:** Catppuccin Mocha
- **Font:** JetBrains Mono Nerd Font (14px)
- **Keybindings:** Standard macOS (`Cmd+C`, `Cmd+V`, `Cmd+T`, etc.)
- **Shell:** Launches `nu` (Nushell) by default.

To reload Ghostty config: `Cmd + Shift + T`

---

## 📝 Cheatsheet

### 🚀 Essentials
- **Prefix:** `Ctrl + A` (All commands start with this)
- **Split Pane:** `|` (Horizontal) / `s` (Vertical)
- **Navigation:** `h` `j` `k` `l` (Panes) / `H` `L` (Windows)
- **Zoom Pane:** `z` (Toggle fullscreen)
- **New Window:** `Ctrl + C`
- **Close Pane:** `c`

### ⚡️ Power Tools
- **Session Manager:** `o` (SessionX - Switch projects fast)
- **File Tree:** `Tab` (Sidebar)
- **Command Menu:** `Space` (Interactive menu)
- **FZF Menu:** `F` (Search everything)
- **URL Opener:** `u` (Open links from terminal)

### 🔄 System
- **Reload Config:** `r`
- **Detach Session:** `Ctrl + D`

> **Note:** If you encounter `yq missing` errors in Tmux, ensure you have installed `yq` via Homebrew as listed in the prerequisites.
