local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Import LazyVim
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        -- Disable ai.copilot-native (requires Neovim >= 0.12)
        ai = { copilot = false },
      },
    },
    -- Import your plugins
    { import = "kursataknc.plugins" },
    { import = "kursataknc.plugins.lsp" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catppuccin" } },
  checker = {
    enabled = true 
  },
})