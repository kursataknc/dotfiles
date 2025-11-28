# Tmux Configuration

Minimalist tmux setup with Catppuccin theme, TPM plugin manager, and vim-style keybindings.

## Features

- **Prefix Key**: `Ctrl+A` (instead of default `Ctrl+B`)
- **Status Bar**: Top position with Catppuccin Mocha theme
- **Window Indexing**: Starts at 1 (not 0)
- **Vi Mode**: Vi-style keybindings for copy mode
- **Plugin Manager**: TPM (Tmux Plugin Manager)
- **Auto-restore**: Sessions automatically restore on tmux start

## Installation

1. **Install TPM**:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```

2. **Stow the configuration**:
   ```bash
   cd ~/dotfiles
   stow tmux
   ```

3. **Start tmux and install plugins**:
   ```bash
   tmux
   # Inside tmux, press: Ctrl+A + I (capital I)
   ```

## Key Bindings

> **Prefix**: `Ctrl+A` (press this before any command below)

### Sessions

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `d` | Detach from session |
| `Ctrl+A` + `S` | Choose session from list |
| `Ctrl+A` + `$` | Rename current session |
| `Ctrl+A` + `o` | SessionX: fuzzy session switcher |

### Windows

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `c` | Create new window (at HOME) |
| `Ctrl+A` + `Ctrl+C` | Create new window (at HOME) |
| `Ctrl+A` + `w` | List all windows |
| `Ctrl+A` + `Ctrl+W` | List all windows |
| `Ctrl+A` + `r` | Rename current window |
| `Ctrl+A` + `"` | Choose window from list |
| `Ctrl+A` + `H` | Previous window |
| `Ctrl+A` + `L` | Next window |
| `Ctrl+A` + `Ctrl+A` | Switch to last window |
| `Ctrl+A` + `[0-9]` | Switch to window by number |
| `Ctrl+A` + `&` | Kill current window |

### Panes (Splits)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `v` | Split vertically (side by side) |
| `Ctrl+A` + `s` | Split horizontally (top/bottom) |
| `Ctrl+A` + `\|` | Split window (default) |
| `Ctrl+A` + `h` | Move to left pane |
| `Ctrl+A` + `j` | Move to pane below |
| `Ctrl+A` + `k` | Move to pane above |
| `Ctrl+A` + `l` | Move to right pane |
| `Ctrl+A` + `Ctrl+L` | Refresh client |
| `Ctrl+A` + `z` | Toggle pane zoom (fullscreen) |
| `Ctrl+A` + `c` | Kill current pane |
| `Ctrl+A` + `x` | Swap pane down |
| `Ctrl+A` + `q` | Show pane numbers |

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
| `n` | Next search result |
| `N` | Previous search result |

### System

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `r` | Reload tmux config (main) |
| `Ctrl+A` + `R` | Reload tmux config (with reset) |
| `Ctrl+A` + `:` | Command prompt |
| `Ctrl+A` + `?` | List all key bindings |
| `Ctrl+A` + `Ctrl+X` | Lock server |
| `Ctrl+A` + `*` | Toggle pane synchronization |
| `Ctrl+A` + `P` | Toggle pane border status |
| `Ctrl+A` + `K` | Clear terminal |

### Plugins

| Shortcut | Description |
|----------|-------------|
| `Ctrl+A` + `I` | Install plugins (TPM) |
| `Ctrl+A` + `U` | Update plugins (TPM) |
| `Ctrl+A` + `alt+u` | Uninstall removed plugins |
| `Ctrl+A` + `p` | Floax: floating pane |
| `Ctrl+A` + `o` | SessionX: session manager |
| `Ctrl+A` + `u` | FZF URL: open URLs |
| `Ctrl+A` + `Space` | Thumbs: quick copy text |

## Plugins

- **[TPM](https://github.com/tmux-plugins/tpm)** - Tmux Plugin Manager
- **[tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)** - Basic tmux settings
- **[tmux-yank](https://github.com/tmux-plugins/tmux-yank)** - Copy to system clipboard
- **[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)** - Save/restore sessions
- **[tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)** - Auto-save sessions
- **[tmux-thumbs](https://github.com/fcsonline/tmux-thumbs)** - Quick text copying
- **[tmux-fzf](https://github.com/sainnhe/tmux-fzf)** - FZF integration
- **[tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url)** - Open URLs with FZF
- **[catppuccin-tmux](https://github.com/kursataknc/catppuccin-tmux)** - Catppuccin theme (custom fork)
- **[tmux-sessionx](https://github.com/kursataknc/tmux-sessionx)** - Session manager (custom fork)
- **[tmux-floax](https://github.com/kursataknc/tmux-floax)** - Floating panes (custom fork)

## Configuration Files

- `~/.config/tmux/tmux.conf` - Main configuration
- `~/.config/tmux/tmux.reset.conf` - Key bindings reset
- `~/.config/tmux/plugins/` - Plugins directory

## Settings

- **Terminal**: `screen-256color` with RGB support
- **Prefix**: `Ctrl+A`
- **Base Index**: 1 (windows and panes start at 1)
- **Escape Time**: 0ms (instant key response)
- **History Limit**: 1,000,000 lines
- **Mouse**: Enabled
- **Status Position**: Top
- **Vi Mode**: Enabled for copy mode
- **System Clipboard**: Enabled
- **Auto Renumber**: Windows renumber when closed
- **Detach on Destroy**: Off (don't exit when closing session)

## Troubleshooting

### Config not loading
```bash
# Test config for errors
tmux source-file ~/.config/tmux/tmux.conf

# Kill server and restart
tmux kill-server
tmux
```

### Plugins not working
```bash
# Check TPM installation
ls ~/.config/tmux/plugins/tpm/tpm

# Install/update plugins
# Inside tmux: Ctrl+A + I
```

### Prefix key not working
- Make sure you're pressing `Ctrl+A` not `Ctrl+B`
- Check if another program is intercepting the key

### Colors not working
- Ensure terminal supports 256 colors and RGB
- Check `$TERM` variable: `echo $TERM`
- Should be `screen-256color` or `tmux-256color`

## Tips

1. **Quick reload**: `Ctrl+A` + `r` to reload config after changes
2. **Zoom pane**: `Ctrl+A` + `z` to focus on one pane
3. **Pane sync**: `Ctrl+A` + `*` to type in all panes simultaneously
4. **Session switcher**: `Ctrl+A` + `o` for fuzzy session search
5. **Clear screen**: `Ctrl+A` + `K` to clear terminal

## Theme

Using **Catppuccin Mocha** theme with custom status line:
- Left: Session name
- Right: Current directory
- Window list in center with custom separators
- Active pane border: Magenta
- Inactive pane border: Bright black
