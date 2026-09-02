-- Snacks only takes over `vim.ui.select` (e.g. code action menus, LSP rename
-- targets) when explicitly opted in -- no LazyVim extra sets this by default.
-- Without it, `:checkhealth` flags `vim.ui.select is not set to
-- Snacks.picker.select` and you get Neovim's plain built-in select instead.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        ui_select = true,
      },
    },
  },
}
