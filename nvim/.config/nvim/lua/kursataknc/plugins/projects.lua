-- Snacks'in yerleşik "projects" picker'ı varsayılan olarak ~/dev ve ~/projects'i tarar.
-- Bizim projelerimiz ~/Developer altında yaşıyor, dotfiles ise ~/dotfiles'ta ayrı duruyor.
-- Bu override olmadan <leader>fp / dashboard'daki "p" hiçbir şey bulamıyordu.
-- Not: Snacks bu listedeki path'leri OLDUĞU GİBİ kullanıyor, tilde'yi kendi açmıyor
-- (dev listesini normalize ediyor ama projects listesini etmiyor). Açılmamış "~/..."
-- string'i, dev taramasının/oldfiles'ın ürettiği tam yoldan (/Users/kursataknc/...)
-- farklı sayılıp aynı proje iki kez listeleniyordu -- bu yüzden burada elle expand ediyoruz.
local function home(path)
  return vim.fn.expand(path)
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          projects = {
            dev = { "~/Developer" },
            -- .git yok bunlarda, dev taraması bulamaz -> elle listelendi
            projects = {
              home("~/dotfiles"),
              home("~/Developer/turkai"),
              home("~/Developer/tuseb"),
              home("~/Developer/claude-setup-bundle"),
            },
            max_depth = 2, -- ~/Developer/<proje>/.git iki seviye derinlikte
          },
        },
      },
    },
  },
}
