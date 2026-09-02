-- Sadece renk temasını özelleştiriyoruz. Önceden bu dosya lualine'i tamamen
-- kendi config() fonksiyonuyla kuruyordu ve LazyVim'in zengin varsayılan
-- section'larını (git diff, diagnostics, dap durumu, noice, lazy update sayacı,
-- root_dir, pretty_path) tamamen eziyordu -- sadece 4 öğe kalmıştı, LazyVim'in
-- verdiği 10+ öğe yerine. `opts` fonksiyonu ile birleştirerek (config yerine)
-- hem kendi rengimizi hem LazyVim'in section'larını koruyoruz.
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = {
      normal = {
        a = { bg = "#65D1FF", fg = "#112638", gui = "bold" },
        b = { bg = "#112638", fg = "#c3ccdc" },
        c = { bg = "#112638", fg = "#c3ccdc" },
      },
      insert = {
        a = { bg = "#3EFFDC", fg = "#112638", gui = "bold" },
        b = { bg = "#112638", fg = "#c3ccdc" },
        c = { bg = "#112638", fg = "#c3ccdc" },
      },
      visual = {
        a = { bg = "#FF61EF", fg = "#112638", gui = "bold" },
        b = { bg = "#112638", fg = "#c3ccdc" },
        c = { bg = "#112638", fg = "#c3ccdc" },
      },
      command = {
        a = { bg = "#FFDA7B", fg = "#112638", gui = "bold" },
        b = { bg = "#112638", fg = "#c3ccdc" },
        c = { bg = "#112638", fg = "#c3ccdc" },
      },
      replace = {
        a = { bg = "#FF4A4A", fg = "#112638", gui = "bold" },
        b = { bg = "#112638", fg = "#c3ccdc" },
        c = { bg = "#112638", fg = "#c3ccdc" },
      },
      inactive = {
        a = { bg = "#2c3043", fg = "#c3ccdc", gui = "bold" },
        b = { bg = "#2c3043", fg = "#c3ccdc" },
        c = { bg = "#2c3043", fg = "#c3ccdc" },
      },
    }
  end,
}
