# Dotfiles

An opinionated, performance-oriented **macOS** development environment managed with **GNU Stow**. Centered around a modern terminal workflow built from **Ghostty**, **Tmux**, **Nushell**/**Zsh**, **Neovim (LazyVim)**, and **Claude Code**.

![macOS](https://img.shields.io/badge/OS-macOS-white)
![Shell](https://img.shields.io/badge/Shell-Zsh%20%2F%20Nushell-green)
![Terminal](https://img.shields.io/badge/Terminal-Ghostty-black)
![Multiplexer](https://img.shields.io/badge/Multiplexer-Tmux-blue)
![Editor](https://img.shields.io/badge/Editor-Neovim-brightgreen)
![AI](https://img.shields.io/badge/AI-Claude%20Code-blueviolet)
![Theme](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-pink)

---

## Table of Contents

1. [What You Get](#what-you-get)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [First-Time Setup](#first-time-setup)
5. [Repository Layout](#repository-layout)
6. [Packages](#packages)
7. [Shell Configuration](#shell-configuration)
8. [Keybinding Reference](#keybinding-reference)
9. [Customization](#customization)
10. [Troubleshooting](#troubleshooting)
11. [Architecture Notes](#architecture-notes)

---

## What You Get

- **Terminal:** Ghostty with Catppuccin Mocha + JetBrains Mono Nerd Font
- **Multiplexer:** Tmux with auto-save/restore, fuzzy session manager, treemux sidebar
- **Shells:** Zsh **and** Nushell — unified workflow (same aliases, same history, same `Ctrl+R`)
- **Prompt:** Starship with language/cloud/git context
- **Editor:** Neovim on LazyVim with ~40 extras + custom plugins
- **History:** Atuin (shared sqlite DB across both shells)
- **Dir jumping:** Zoxide (`z <name>`)
- **Fuzzy picker:** FZF inside shells, inside tmux, inside Neovim
- **AI:** Claude Code with 50+ plugins, agents, commands, hooks, and skills
- **Keyboard:** Karabiner-Elements for Turkish Q → ANSI remapping
- **Mouse:** LinearMouse for per-device acceleration profiles

---

## Prerequisites

### 1. Homebrew + Nerd Font

```bash
# Install Homebrew (skip if already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# JetBrains Mono Nerd Font (required for icons in tmux/nvim)
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. Core Dependencies

```bash
# Stow manager + git
brew install stow git

# Terminal + multiplexer + editor
brew install --cask ghostty
brew install tmux neovim

# Shells + prompt
brew install nushell starship zsh-syntax-highlighting

# Shell productivity
brew install atuin zoxide fzf fd ripgrep bat eza yq gh lazygit

# Optional niceties (used by some aliases / helpers)
brew install direnv pyenv gitmux

# macOS apps (optional, only if you use these hardware features)
brew install --cask karabiner-elements linearmouse
```

### 3. Shell Setup

```bash
# Add Nushell as a login shell so Ghostty can launch it
echo "$(which nu)" | sudo tee -a /etc/shells

# (Zsh is shipped with macOS; no action needed)
```

---

## Installation

### Clone and run the installer

```bash
git clone https://github.com/kursataknc/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` does two things:

1. **Creates gitignored placeholders** that the shell configs source:
   - `~/.config/nushell/secrets.nu`
   - `~/.config/zsh/secrets.zsh`
   - `~/.cache/starship/init.nu`, `~/.cache/zoxide/init.nu`, `~/.local/share/atuin/init.nu`
2. **Stows every package** via `stow --restow` (idempotent — safe to re-run).

### Stow individual packages

If you only want a subset:

```bash
cd ~/dotfiles
stow --restow nvim       # Neovim config
stow --restow tmux       # Tmux config
stow --restow nushell    # Nushell
stow --restow zshrc      # Zsh
stow --restow starship   # Prompt
stow --restow ghostty    # Ghostty terminal
stow --restow claude     # Claude Code
stow --restow karabiner  # Keyboard (optional)
stow --restow linearmouse # Mouse (optional)
```

> **Conflict?** `stow` refuses to overwrite a **regular file** at the target path. Back it up and delete it first:
> ```bash
> mv ~/.zshrc ~/.zshrc.bak
> stow --restow zshrc
> ```

---

## First-Time Setup

Run these once after `./install.sh` completes:

### 1. Add your secrets

```bash
# Zsh
cat >> ~/.config/zsh/secrets.zsh <<'EOF'
export GITHUB_TOKEN="..."
export OPENAI_API_KEY="..."
EOF

# Nushell
cat >> ~/.config/nushell/secrets.nu <<'EOF'
$env.GITHUB_TOKEN = "..."
$env.OPENAI_API_KEY = "..."
EOF
```

### 2. Import shell history into Atuin

```bash
atuin import auto        # picks up existing .zsh_history
```

After this, `Ctrl+R` in either shell surfaces the same history.

### 3. Install Tmux plugins

```bash
tmux                     # open tmux
# inside tmux:
Prefix + I               # that's Ctrl+A then capital-I
```

TPM clones every plugin listed in `tmux.conf`. Wait for the "installed" message, then reload: `Prefix + R`.

### 4. Install Neovim plugins

```bash
nvim                     # lazy.nvim auto-bootstraps and installs
# wait for ":Lazy" UI to finish, then :qa
```

### 5. (Optional) Mason LSPs in Neovim

```bash
nvim
:Mason                   # pick and install language servers as needed
```

---

## Repository Layout

```
~/dotfiles/
├── claude/          # ~/.claude/              – Claude Code config
├── ghostty/         # ~/.config/ghostty/      – Terminal
├── karabiner/       # ~/.config/karabiner/    – Keyboard remapping
├── linearmouse/     # ~/.config/linearmouse/  – Mouse profiles
├── nushell/         # ~/.config/nushell/      – Nu shell + aliases
├── nvim/            # ~/.config/nvim/         – Neovim (LazyVim)
├── starship/        # ~/.config/starship.toml – Prompt
├── tmux/            # ~/.config/tmux/         – Tmux + plugins
├── zshrc/           # ~/.zshrc + ~/.config/zsh/ – Zsh + shared aliases
├── docs/            # (local-only, .git/info/exclude) – design notes
├── install.sh       # Stow wrapper + placeholder creation
└── .stowrc          # Stow defaults
```

Each top-level directory is a **Stow package**. Stow creates symlinks from `~/dotfiles/<package>/<path>` → `~/<path>`.

### Stow model used

| Package | Link granularity | Why |
| :--- | :--- | :--- |
| `nvim`, `ghostty`, `nushell`, `karabiner`, `linearmouse` | **Directory symlink** (`~/.config/<pkg>` → repo) | Whole config tree tracked; gitignore handles runtime files |
| `tmux` | **File symlinks** inside a real `~/.config/tmux/` | TPM writes into `~/.config/tmux/plugins/` — must be a real dir so those writes don't leak into the repo |
| `zshrc`, `starship` | **File symlinks** in `$HOME` / `~/.config/` | Single files, no enclosing dir needed |
| `claude` | **Directory symlink** at `~/.claude/` | Same rationale as nvim; runtime dirs already ignored |

---

## Packages

### Claude Code (`claude/`)

| Component | Count | Notes |
| :--- | :--- | :--- |
| Agents | 8 | code-reviewer, debugger, test-engineer, etc. |
| Commands | 8 | `/commit`, `/pr`, `/optimize`, `/push-all`, … |
| Hooks | 8 | security-scan, format-code, context-tracker, … |
| Skills | 27 | refactor, code-review, mcp-builder, … |
| Plugins | 50+ | oh-my-claudecode, context7, superpowers, … |

**Not tracked:** sessions, history, projects, plugin cache, installed-plugins state, mcp auth cache (all gitignored). `settings.json` is the source of truth — `enabledPlugins` lists intent; Claude Code reinstalls from that on each machine.

### Ghostty (`ghostty/`)

- Catppuccin Mocha theme, JetBrains Mono Nerd Font at 14px
- Ligatures off (`font-feature = -calt, -liga`)
- Launches `nu --login` as the default shell
- macOS-style keybindings: `⌘C/V/N/T/W`

### Karabiner (`karabiner/`)

- Remaps `` ` `` → `non_us_backslash` on a specific Turkish-Q-on-ANSI keyboard (hardware-specific, idle on other keyboards)
- Ignores a second identified keyboard entirely
- No other global rewrites — keep it minimal

### LinearMouse (`linearmouse/`)

Per-device acceleration/speed profiles for three mice (WLMOUSE 1K receiver + ProClickM wired/wireless). If you use different hardware, LinearMouse falls back to OS defaults — the config does nothing harmful.

### Nushell (`nushell/`)

- `config.nu` — themes, keybindings, menus, tool integrations
- `env.nu` — `$env.PATH`, `$env.EDITOR`, pyenv shims, direnv hook
- `aliases.nu` — shared aliases (mirror of the zsh file)
- `secrets.nu` — gitignored, sourced by `env.nu`
- Prompt, directory jumping, history, fuzzy picker all wired to the same tools zsh uses (see [Shell Parity](#shell-parity))

### Neovim (`nvim/`)

Built on **LazyVim** with language/plugin extras defined in `lazyvim.json`:

- **Languages:** Python, TypeScript (+ biome/oxc/tsgo), Go, Lua, JSON, TOML, Markdown, Nushell, Typst, CMake, Docker, R, SQL, Tailwind
- **AI:** `claudecode`, `copilot-chat` (copilot-native disabled pending NVIM 0.12)
- **Editing:** dial, inc-rename, mini-comment, yanky, snacks_picker, telescope
- **Formatting:** prettier
- **Linting:** eslint
- **UI:** dashboard, treesitter-context, indent-blankline, mini-hipatterns

Custom overrides in `lua/kursataknc/plugins/`: colorscheme, cmp, telescope, lspconfig, nvim-tree, auto-session, lualine, bufferline, surround, todo-comments, trouble, dressing, which-key, gitsigns, treesitter, autopairs, vim-maximizer, lazygit.

### Starship (`starship/`)

Cross-shell prompt with a shared `starship.toml`. Catppuccin Mocha palette. Shows directory, git, Python/Node/Go/Rust version, Docker/Kubernetes/AWS context, Nix shell marker, elapsed command time on long commands.

### Tmux (`tmux/`)

- Prefix: `Ctrl+A`
- Catppuccin Mocha theme, status bar at top
- TPM-managed plugins (resurrect, continuum, sessionx, treemux, catppuccin, fzf, fzf-url, yank, cpu, battery, now-playing, weather, ip-address, net-speed)
- See [Keybinding Reference](#tmux-keys) for the full binding list
- Turkish-Q friendly (no AltGr-only bindings)

### Zsh (`zshrc/`)

- `.zshrc` — env, PATH, oh-my-zsh + autosuggestions + starship init + tool hooks
- `.config/zsh/aliases.zsh` — shared aliases (mirror of the nu file)
- `.config/zsh/secrets.zsh` — gitignored, sourced from `.zshrc`
- `zsh-syntax-highlighting` loaded last per upstream requirement

---

## Shell Configuration

### Shell Parity

Switching between `nu` and `zsh` preserves workflow — the following are identical in both:

| Feature | Zsh | Nushell |
| :--- | :---: | :---: |
| Prompt (Starship) | ✓ | ✓ |
| Catppuccin theme | ✓ | ✓ |
| Vi edit mode | ✓ | ✓ |
| Autosuggestions | ✓ | ✓ (built-in) |
| Inline syntax highlighting | ✓ (plugin) | ✓ (built-in) |
| Shared aliases | ✓ | ✓ |
| Direnv | ✓ | ✓ |
| Atuin `Ctrl+R` | ✓ | ✓ |
| Zoxide `z <dir>` | ✓ | ✓ |
| FZF `Ctrl+T` / `Alt+C` | ✓ | ✓ |

Full plan: `docs/shell-parity.md` (local-only, not tracked).

### Aliases

Shared aliases live in two mirrored files (kept in sync manually):
- `~/.config/zsh/aliases.zsh`
- `~/.config/nushell/aliases.nu`

Shell-specific aliases stay in the main config.

| Alias | Scope | Expands to |
| :--- | :--- | :--- |
| `l` / `ll` / `lt` | both | eza listing (long / plain / tree) |
| `v` | both | `nvim` |
| `py` | both | `python3` |
| `gc` / `gca` | both | `git commit -m` / `git commit -a -m` |
| `gp` / `gpu` | both | `git push origin HEAD` / `git pull origin` |
| `gst` / `glog` / `gdiff` | both | Git status / graph log / diff |
| `gco` / `gb` / `gba` | both | `git checkout` / `branch` / `branch -a` |
| `gadd` / `ga` / `gcoall` / `gr` / `gre` | both | Staging / reset helpers |
| `dco` / `dps` / `dpa` / `dl` / `dx` | both | `docker compose` / `ps` / `exec -it` |
| `k` / `ka` / `kg` / `kd` / `kdel` | both | `kubectl` + apply/get/describe/delete |
| `kl` / `ke` / `kgpo` / `kgd` | both | kubectl logs -f / exec / get pod / deployments |
| `kc` / `kns` / `kcns` | both | `kubectx` / `kubens` / set namespace |
| `..` / `...` / `....` | zsh | Navigate up 1/2/3 |
| `cl` / `c` | zsh / nu | Clear |
| `la` | zsh | `tree` |
| `cat` | zsh | `bat` |
| `http` | zsh | `xh` |
| `mat` | zsh | Matrix screensaver in new tmux window |
| `hms` / `asr` | nu | `home-manager switch` / `atuin scripts run` |

### Secrets pattern

API tokens live in gitignored files that mirror each shell's config.

```bash
# Zsh
~/.config/zsh/secrets.zsh           # sourced conditionally from .zshrc

# Nushell
~/.config/nushell/secrets.nu        # sourced from env.nu
```

Add `export FOO=...` (zsh) or `$env.FOO = "..."` (nu). `install.sh` creates empty placeholders on first run.

> **Rotating a leaked secret:** if you accidentally commit a token, *rotate it first*, then rewrite history if needed. Git history retains the value until force-pushed over.

---

## Keybinding Reference

### Tmux Keys

All keys below are pressed after `Prefix` (`Ctrl+A`).

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
| `$` | Rename current session (tmux default) |
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

> `tmux-yank` binds `Y` / `y` after your config loads — those keys are clipboard actions, not tmux defaults.

### Neovim Keys

Leader: `Space`

#### General

| Key | Action |
| :--- | :--- |
| `jk` (insert) | Exit to normal mode |
| `<leader>nh` | Clear search highlights |
| `<leader>+` / `<leader>-` | Increment / decrement number under cursor |

#### Windows & Tabs

| Key | Action |
| :--- | :--- |
| `<leader>sv` / `<leader>sh` | Split vertical / horizontal |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>to` / `<leader>tx` | Open / close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>tf` | Open current buffer in new tab |

#### Files & Search (Telescope)

| Key | Action |
| :--- | :--- |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>fc` | Find string under cursor |
| `<leader>ft` | Find todos |
| `<leader>fk` | Find keymaps |

#### LSP (buffer-local on attach)

| Key | Action |
| :--- | :--- |
| `gd` | Go to definition |
| `gR` | Show references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename |

#### LazyVim Extras (partial)

| Key | Action |
| :--- | :--- |
| `<leader>ee` / `<leader>ef` | Toggle / locate in file explorer |
| `<leader>mp` | Format buffer |
| `<leader>hs` / `<leader>hp` | Stage / preview git hunk |

#### Treemux (sidebar nvim-tree)

| Key | Action |
| :--- | :--- |
| `l` / `Enter` | Open file in main editor |
| `v` | Open in vertical split |
| `h` | Close node |
| `u` | Go up a directory |
| `a` | Create file (suffix `/` for folder) |
| `d` / `r` | Delete / rename |
| `<Space>o` | Toggle Oil.nvim |

### Shell Keys (both zsh and nu)

| Key | Action |
| :--- | :--- |
| `Ctrl+R` | Atuin history search |
| `Ctrl+T` | FZF file picker → insert path into commandline |
| `Alt+C` | FZF directory picker → `cd` |
| `z <frag>` | Zoxide: jump to frecent directory |
| `Tab` | Completion menu |
| `Ctrl+N` (nu) | IDE-style completion menu |
| `jj` (zsh insert) | Exit to normal mode (nu limitation: not supported) |

---

## Customization

### Add a new shared alias

Edit both files (they must stay in sync):

```bash
# ~/.config/zsh/aliases.zsh
alias gpush="git push --force-with-lease"

# ~/.config/nushell/aliases.nu
alias gpush = git push --force-with-lease
```

### Add a Neovim plugin

Create `nvim/.config/nvim/lua/kursataknc/plugins/<name>.lua`:

```lua
return {
  "author/plugin-name",
  opts = function(_, opts)
    -- extend LazyVim defaults rather than replacing
    opts.some_option = "value"
  end,
  keys = {
    { "<leader>xy", "<cmd>PluginCommand<cr>", desc = "Do thing" },
  },
}
```

Then `:Lazy sync` inside nvim. **Prefer `opts = function(_, opts)` over `config = function()`** so LazyVim's own config is merged, not overwritten.

Or use `:LazyExtras` to toggle curated bundles (updates `lazyvim.json`).

### Add a Tmux plugin

Append to `tmux.conf`:

```bash
set -g @plugin 'author/plugin-name'
```

Reload (`Prefix + R`) and `Prefix + I` to install.

### Modify the prompt

Edit `starship/.config/starship.toml`. Changes apply to both shells.

### Enable a disabled Claude plugin

Edit `claude/.claude/settings.json` → `enabledPlugins` → flip `false` → `true`. Claude Code installs on next launch.

---

## Troubleshooting

### `stow` refuses to link

```
WARNING! stowing zshrc would cause conflicts: ...cannot stow over existing target .zshrc
```

The target is a regular file, not a symlink. Move it out of the way:

```bash
mv ~/.zshrc ~/.zshrc.bak
cd ~/dotfiles && stow --restow zshrc
```

### Icons show as boxes in tmux / nvim

Terminal font isn't a Nerd Font. Install JetBrains Mono Nerd Font (see [Prerequisites](#prerequisites)) and set it in Ghostty:

```
# ~/.config/ghostty/config
font-family = "JetBrainsMono Nerd Font Mono"
```

### Nushell won't start: "source file not found: secrets.nu"

The placeholder wasn't created. Run:

```bash
mkdir -p ~/.config/nushell && touch ~/.config/nushell/secrets.nu
```

Or rerun `./install.sh`.

### Atuin `Ctrl+R` shows empty history

Import existing shell history:

```bash
atuin import auto
```

### Tmux status bar missing icons / sections

Reload plugins (`Prefix + I` to install, `Prefix + U` to update, `Prefix + R` to reload config).

### Neovim errors about missing plugins

```vim
:Lazy sync
:Lazy clean
:Mason
```

### Claude plugin state drifts into git status

This was the old setup. `installed_plugins.json` and `known_marketplaces.json` are now gitignored. If you still see them staged, run `git rm --cached` and commit.

---

## Architecture Notes

### Why two stow styles?

Stow "folds" a package by default: if the target directory doesn't exist, stow creates a single symlink to the package's directory. Otherwise it symlinks each file individually.

- **Directory symlink** (`~/.config/nushell` → `repo/nushell/.config/nushell`) means any file nushell writes (history, cache) lands inside the repo directory. Gitignore handles it.
- **File-level symlinks** (`~/.config/tmux/tmux.conf` is a symlink, but `~/.config/tmux/` is a real dir) is used for tmux because TPM writes plugins into `~/.config/tmux/plugins/` — a directory symlink would put the entire TPM plugin tree inside the repo.

### Parse-time vs runtime config files

Nushell's `source` and `use` are parse-time: if the sourced file doesn't exist, the whole shell fails to start. That's why `install.sh` creates empty placeholders for `secrets.nu` and `~/.cache/*/init.nu` before doing anything else — even a fresh machine with the tool uninstalled still parses cleanly.

### Why atuin instead of shell-native history?

Atuin gives:
- **Single sqlite DB** shared across zsh, nu, bash, fish
- Per-command metadata (exit code, duration, working directory, session)
- Fuzzy filter UI, host/session filtering, optional sync

`Ctrl+R` in either shell hits the same store — switching shells doesn't break muscle memory.

### Why LazyVim extras + custom plugin files?

LazyVim provides curated defaults via extras (`lazyvim.json`). Custom files in `lua/kursataknc/plugins/` layer modifications on top:

- **Use `opts = function(_, opts)`** when extending LazyVim's config.
- **Avoid `config = function()`** — it fully replaces LazyVim's own config for that plugin.
- The `keys = {...}` table is the idiomatic way to bind keys; it loads the plugin on first press.

---

## License

Personal dotfiles. Feel free to fork and adapt.
