-- Show hidden (dotfile) entries by default everywhere Snacks lists files --
-- explorer, file finder, live grep. Without this, a directory whose only
-- content is a dotfolder (e.g. dotfiles/ghostty/.config) looks empty until
-- you manually press `H` inside the explorer.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { hidden = true },
          files = { hidden = true },
          grep = { hidden = true },
        },
      },
    },
  },
}
