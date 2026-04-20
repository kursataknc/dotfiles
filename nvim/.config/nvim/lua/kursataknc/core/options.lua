-- Overrides on top of LazyVim defaults. Anything LazyVim already sets
-- (tabstop, number, ignorecase, cursorline, termguicolors, etc.) has been
-- removed to avoid drift.

vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Force dark background (prevents colorschemes that auto-switch from
-- flipping to light).
opt.background = "dark"

-- No swap files
opt.swapfile = false

-- Session options for auto-session (extends LazyVim's smaller default)
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
