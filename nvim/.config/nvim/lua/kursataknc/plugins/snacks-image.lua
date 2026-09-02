-- Inline image/PDF preview (markdown vb. içinde). Ghostty + tmux zaten
-- destekliyor (checkhealth ile doğrulandı), sadece üst düzey `enabled`
-- bayrağı kapalıydı. `doc.enabled`/`formats` (png, pdf dahil) zaten varsayılan.
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
      },
    },
  },
}
