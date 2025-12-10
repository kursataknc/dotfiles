# Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

A modern, feature-rich Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/) with custom enhancements for an optimal development experience.

**Colorscheme:** Catppuccin Mocha | **Plugin Manager:** lazy.nvim

</div>

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Plugin Overview](#plugin-overview)
- [Language Support](#language-support)
- [Keybindings](#keybindings)
  - [General](#general)
  - [File Explorer](#file-explorer)
  - [Telescope (Fuzzy Finder)](#telescope-fuzzy-finder)
  - [LSP](#lsp)
  - [Git](#git)
  - [Diagnostics & Trouble](#diagnostics--trouble)
  - [Tabs & Splits](#tabs--splits)
  - [Session Management](#session-management)
  - [Completion](#completion)
  - [Comments](#comments)
  - [Surround](#surround)
  - [Todo Comments](#todo-comments)
  - [Treesitter](#treesitter)
- [Configuration](#configuration)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

---

## Features

- 🚀 **LazyVim Base** - Built on top of LazyVim for a solid foundation
- 🎨 **Catppuccin Theme** - Beautiful and eye-friendly colorscheme (Mocha variant)
- 🤖 **GitHub Copilot** - AI-powered code completion and chat
- 📝 **LSP Support** - Full Language Server Protocol integration
- 🔍 **Telescope** - Powerful fuzzy finder for files, grep, and more
- 🌳 **Nvim-Tree** - File explorer with git integration
- ✨ **Treesitter** - Advanced syntax highlighting and code navigation
- 💾 **Auto Session** - Automatic session management
- 🔧 **Mason** - Easy LSP/DAP/Linter/Formatter installation
- 📊 **Lualine** - Beautiful and informative statusline
- 🔖 **Bufferline** - Tab-style buffer management
- 💬 **Which-Key** - Keybinding hints and discovery
- 🐙 **Git Integration** - Gitsigns, LazyGit, and more
- ⚡ **Format on Save** - Automatic code formatting with Conform
- 🔍 **Todo Comments** - Highlight and search TODO/FIXME/etc.

---

## Requirements

### Required

| Dependency | Version | Description |
|------------|---------|-------------|
| [Neovim](https://neovim.io/) | >= 0.10.0 | Text editor |
| [Git](https://git-scm.com/) | >= 2.19.0 | Version control |
| [Node.js](https://nodejs.org/) | >= 18.x | For LSP servers and Copilot |
| [npm](https://www.npmjs.com/) | >= 9.x | Package manager |

### Recommended

| Dependency | Description |
|------------|-------------|
| [Nerd Font](https://www.nerdfonts.com/) | For icons (e.g., JetBrainsMono Nerd Font) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | For Telescope live grep |
| [fd](https://github.com/sharkdp/fd) | For Telescope file finding |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal UI for git |
| [Python 3](https://www.python.org/) | For Python LSP and tools |
| [Go](https://go.dev/) | For Go language support |

### macOS Installation (Homebrew)

```bash
# Install required dependencies
brew install neovim git node

# Install recommended dependencies
brew install ripgrep fd lazygit python go

# Install a Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

### Ubuntu/Debian Installation

```bash
# Install required dependencies
sudo apt update
sudo apt install neovim git nodejs npm

# Install recommended dependencies
sudo apt install ripgrep fd-find python3 python3-pip

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

---

## Installation

### 1. Backup Existing Configuration (if any)

```bash
# Backup existing nvim config
mv ~/.config/nvim ~/.config/nvim.bak

# Backup existing nvim data
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone the Repository

```bash
# Clone the dotfiles repository
git clone https://github.com/kursataknc/dotfiles.git ~/dotfiles

# Create symlink to nvim config
ln -sf ~/dotfiles/nvim/.config/nvim ~/.config/nvim
```

### 3. Start Neovim

```bash
nvim
```

On first launch, Lazy.nvim will automatically:
1. Install itself
2. Install all configured plugins
3. Install LSP servers via Mason
4. Install formatters and linters

> **Note:** The first startup may take a few minutes. Please wait for all installations to complete.

### 4. Post-Installation

After the initial setup, run the following commands in Neovim:

```vim
" Check health status
:checkhealth

" Update all plugins
:Lazy update

" Sync Mason packages
:Mason

" Install/ensure Mason tools (formatters/linters/DAP)
:MasonToolsInstall
```

### 5. GitHub Copilot Setup (Optional)

If you want to use GitHub Copilot:

```vim
:Copilot auth
```

Follow the prompts to authenticate with your GitHub account.

---

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin version lock file
├── lazyvim.json               # LazyVim extras configuration
└── lua/
    └── kursataknc/
        ├── core/
        │   ├── init.lua       # Core module loader
        │   ├── keymaps.lua    # Custom keybindings
        │   └── options.lua    # Neovim options
        ├── lazy.lua           # Lazy.nvim setup
        └── plugins/
            ├── init.lua       # Base plugins
            ├── auto-session.lua
            ├── autopairs.lua
            ├── bufferline.lua
            ├── colorscheme.lua
            ├── comment.lua
            ├── dressing.lua
            ├── formatting.lua
            ├── gitsigns.lua
            ├── indent-blankline.lua
            ├── lazygit.lua
            ├── lualine.lua
            ├── nvim-cmp.lua
            ├── nvim-tree.lua
            ├── surround.lua
            ├── telescope.lua
            ├── todo-comments.lua
            ├── treesitter.lua
            ├── trouble.lua
            ├── vim-maximizer.lua
            ├── which-key.lua
            └── lsp/
                ├── lsp.lua        # LSP capabilities
                ├── lspconfig.lua  # LSP server configs
                └── mason.lua      # Mason setup
```

---

## Plugin Overview

### Core Plugins

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager |
| [LazyVim](https://github.com/LazyVim/LazyVim) | Neovim configuration framework |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility functions |

### UI & Appearance

| Plugin | Description |
|--------|-------------|
| [catppuccin](https://github.com/catppuccin/nvim) | Soothing pastel colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer/tab line |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI components |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |

### Navigation & Search

| Plugin | Description |
|--------|-------------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Tmux integration |
| [auto-session](https://github.com/rmagatti/auto-session) | Session management |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason LSP bridge |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua/Neovim API completions |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | Completion icons |

### Coding & Editing

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close/rename HTML tags |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto pairs |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO highlighting |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Split maximizer |

### Git Integration

| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |

### AI

| Plugin | Description |
|--------|-------------|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Copilot Chat |

---

## Language Support

### Pre-configured LSP Servers

| Language | Server | Description |
|----------|--------|-------------|
| TypeScript/JavaScript | `ts_ls` | TS/JS (React/JSX/TSX) |
| ESLint | `eslint` | Linting for TS/JS |
| HTML | `html` | HTML language server |
| CSS | `cssls` | CSS language server |
| Tailwind CSS | `tailwindcss` | Tailwind intellisense |
| Svelte | `svelte` | Svelte language server |
| GraphQL | `graphql` | GraphQL language server |
| Prisma | `prismals` | Prisma schema |
| Emmet | `emmet_ls` | Emmet abbreviations |
| JSON | `jsonls` | JSON language server |
| SQL | `sqlls` | SQL completion/diagnostics |
| YAML | `yamlls` | YAML language server |
| TOML | `taplo` | TOML language server |
| Markdown | `marksman` | Markdown language server |
| Lua | `lua_ls` | Lua language server |
| Python | `pyright` | Python type checker |
| Go | `gopls` | Go language server |
| Bash | `bashls` | Bash language server |
| Docker | `dockerls` | Dockerfile language server |
| Docker Compose | `docker_compose_language_service` | Compose files |
| Terraform | `terraformls` | Terraform language server |
| Helm | `helm_ls` | Helm charts |
| Spellcheck | `typos_lsp` | Typos/spell diagnostics |

### Formatters

| Formatter | Languages |
|-----------|-----------|
| Prettier | JS, TS, JSX, TSX, CSS, HTML, JSON, YAML, Markdown, GraphQL, Svelte |
| Biome | Fast formatter + linter for JS/TS/JSX/TSX/JSON |
| Stylua | Lua |
| gofumpt | Go formatting |
| goimports | Go imports/formatting |
| shfmt | Shell formatting |
| yamlfmt | YAML formatting |
| sql-formatter | SQL formatting |

### Treesitter Parsers

Automatically installed parsers:
- `json`, `javascript`, `typescript`, `tsx`
- `yaml`, `html`, `css`, `prisma`
- `markdown`, `markdown_inline`
- `svelte`, `graphql`
- `bash`, `lua`, `vim`
- `dockerfile`, `gitignore`
- `query`, `vimdoc`, `c`

---

## Keybindings

> **Leader Key:** `<Space>`

### General

| Keybinding | Mode | Description |
|------------|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number |
| `<leader>-` | Normal | Decrement number |

### File Explorer

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ee` | Normal | Toggle file explorer |
| `<leader>ef` | Normal | Toggle file explorer on current file |
| `<leader>ec` | Normal | Collapse file explorer |
| `<leader>er` | Normal | Refresh file explorer |

### Telescope (Fuzzy Finder)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fr` | Normal | Find recent files |
| `<leader>fs` | Normal | Find string (live grep) |
| `<leader>fc` | Normal | Find string under cursor |
| `<leader>ft` | Normal | Find TODOs |
| `<leader>fk` | Normal | Find keymaps |
| `<C-k>` | Insert (Telescope) | Move to previous result |
| `<C-j>` | Insert (Telescope) | Move to next result |
| `<C-q>` | Insert (Telescope) | Send to quickfix list |
| `<C-t>` | Insert (Telescope) | Open in Trouble |

### LSP

| Keybinding | Mode | Description |
|------------|------|-------------|
| `gR` | Normal | Show LSP references |
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Show LSP definitions |
| `gi` | Normal | Show LSP implementations |
| `gt` | Normal | Show LSP type definitions |
| `K` | Normal | Show hover documentation |
| `<leader>ca` | Normal, Visual | Code actions |
| `<leader>rn` | Normal | Smart rename |
| `<leader>D` | Normal | Show buffer diagnostics |
| `<leader>d` | Normal | Show line diagnostics |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `<leader>rs` | Normal | Restart LSP |

### Git

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>lg` | Normal | Open LazyGit |
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal, Visual | Stage hunk |
| `<leader>hr` | Normal, Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>hB` | Normal | Toggle line blame |
| `<leader>hd` | Normal | Diff this |
| `<leader>hD` | Normal | Diff this ~ |
| `ih` | Operator, Visual | Select hunk (text object) |

### Diagnostics & Trouble

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>xw` | Normal | Workspace diagnostics |
| `<leader>xd` | Normal | Document diagnostics |
| `<leader>xq` | Normal | Quickfix list |
| `<leader>xl` | Normal | Location list |
| `<leader>xt` | Normal | TODOs in Trouble |

### Tabs & Splits

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |
| `<leader>sm` | Normal | Maximize/minimize split |
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

### Session Management

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>wr` | Normal | Restore session for cwd |
| `<leader>ws` | Normal | Save session |

### Completion

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-k>` | Insert | Previous completion item |
| `<C-j>` | Insert | Next completion item |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |
| `<C-Space>` | Insert | Trigger completion |
| `<C-e>` | Insert | Abort completion |

### Comments

| Keybinding | Mode | Description |
|------------|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |
| `gc` | Visual | Toggle line comment |
| `gb` | Visual | Toggle block comment |

### Surround

| Keybinding | Mode | Description |
|------------|------|-------------|
| `ys{motion}{char}` | Normal | Add surround |
| `ds{char}` | Normal | Delete surround |
| `cs{target}{replacement}` | Normal | Change surround |
| `S{char}` | Visual | Surround selection |

**Examples:**
- `ysiw"` - Surround word with double quotes
- `ds"` - Delete surrounding double quotes
- `cs"'` - Change double quotes to single quotes
- `yss)` - Surround entire line with parentheses

### Todo Comments

| Keybinding | Mode | Description |
|------------|------|-------------|
| `]t` | Normal | Next TODO comment |
| `[t` | Normal | Previous TODO comment |

### Treesitter

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-space>` | Normal | Start incremental selection |
| `<C-space>` | Visual | Expand selection to next node |
| `<BS>` | Visual | Shrink selection to previous node |

### Formatting

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>mp` | Normal, Visual | Format file or selection |

---

## Configuration

### Editor Options

The configuration includes the following editor settings (defined in `lua/kursataknc/core/options.lua`):

```lua
-- Line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.number = true            -- Absolute line number on cursor line

-- Tabs & Indentation
vim.opt.tabstop = 2              -- 2 spaces for tabs
vim.opt.shiftwidth = 2           -- 2 spaces for indent
vim.opt.expandtab = true         -- Expand tabs to spaces
vim.opt.autoindent = true        -- Auto indent new lines

-- Search
vim.opt.ignorecase = true        -- Ignore case in search
vim.opt.smartcase = true         -- Smart case search

-- Appearance
vim.opt.termguicolors = true     -- True color support
vim.opt.background = "dark"      -- Dark background
vim.opt.signcolumn = "yes"       -- Always show sign column
vim.opt.cursorline = true        -- Highlight cursor line

-- Behavior
vim.opt.wrap = false             -- No line wrapping
vim.opt.swapfile = false         -- No swap files
vim.opt.clipboard = "unnamedplus" -- System clipboard
vim.opt.splitright = true        -- Split right
vim.opt.splitbelow = true        -- Split below
```

### LazyVim Extras

The following LazyVim extras are enabled (configured in `lazyvim.json`):

**AI:**
- `ai.copilot` - GitHub Copilot
- `ai.copilot-chat` - Copilot Chat

**Coding:**
- `coding.nvim-cmp` - Completion engine
- `coding.yanky` - Yank ring

**Editor:**
- `editor.dial` - Enhanced increment/decrement
- `editor.inc-rename` - Incremental rename
- `editor.snacks_picker` - Snacks picker
- `editor.telescope` - Telescope integration

**Formatting:**
- `formatting.prettier` - Prettier formatter

**Languages:**
- `lang.cmake`, `lang.git`, `lang.go`
- `lang.json`, `lang.markdown`
- `lang.nushell`, `lang.python`
- `lang.toml`, `lang.typescript`, `lang.typst`

**Linting:**
- `linting.eslint` - ESLint integration

**LSP:**
- `lsp.neoconf` - Neoconf support

**UI:**
- `ui.dashboard-nvim` - Dashboard
- `ui.indent-blankline` - Indent guides
- `ui.treesitter-context` - Treesitter context

**Utilities:**
- `util.dot` - Dotfile support
- `util.gh` - GitHub CLI
- `util.gitui` - GitUI integration
- `util.project` - Project management
- `util.startuptime` - Startup profiling

---

## Customization

### Adding New Plugins

Create a new file in `lua/kursataknc/plugins/`:

```lua
-- lua/kursataknc/plugins/my-plugin.lua
return {
  "author/plugin-name",
  event = { "BufReadPre", "BufNewFile" },  -- Lazy load on events
  dependencies = {
    "dependency/plugin",
  },
  config = function()
    require("plugin-name").setup({
      -- Your configuration
    })
  end,
}
```

### Adding New Keybindings

Edit `lua/kursataknc/core/keymaps.lua`:

```lua
local keymap = vim.keymap

keymap.set("n", "<leader>xx", "<cmd>YourCommand<CR>", { desc = "Description" })
```

### Changing Colorscheme

Edit `lua/kursataknc/plugins/colorscheme.lua` to change the theme or its settings.

### Adding LSP Servers

Edit `lua/kursataknc/plugins/lsp/mason.lua` to add more LSP servers:

```lua
ensure_installed = {
  -- Add your LSP server here
  "rust_analyzer",
}
```

---

## Troubleshooting

### Common Issues

#### Plugins Not Loading

```vim
:Lazy sync
:Lazy update
```

#### LSP Not Working

```vim
:LspInfo
:Mason
:checkhealth lsp
```

#### Icons Not Displaying

Make sure you have a [Nerd Font](https://www.nerdfonts.com/) installed and configured in your terminal.

#### Treesitter Errors

```vim
:TSUpdate
:TSInstall all
```

#### Copilot Not Working

```vim
:Copilot auth
:Copilot status
```

### Health Check

Run the following command to diagnose issues:

```vim
:checkhealth
```

### Clear Cache

If you encounter persistent issues:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

Then restart Neovim to reinstall everything.

---

## Credits

- [LazyVim](https://www.lazyvim.org/) - The amazing Neovim configuration framework
- [Folke Lemaitre](https://github.com/folke) - For lazy.nvim, which-key, trouble, and many other plugins
- [Catppuccin](https://github.com/catppuccin) - Beautiful colorscheme
- [Neovim Community](https://neovim.io/) - For all the amazing plugins

---

## License

This configuration is provided as-is for personal use. Feel free to fork and modify for your own needs.

---

<div align="center">

**Happy Coding! 🚀**

Made with ❤️ by [kursataknc](https://github.com/kursataknc)

</div>
