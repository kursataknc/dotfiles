return {
  -- Explicitly enable nvim-cmp (LazyVim includes it by default)
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "onsails/lspkind.nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- Custom mappings
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
      })

      -- lspkind formatting
      opts.formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      }

      return opts
    end,
  },
}