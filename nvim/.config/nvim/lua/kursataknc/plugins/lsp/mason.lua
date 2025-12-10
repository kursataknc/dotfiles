return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Web Development (JS/TS/React)
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "emmet_ls",
        "eslint",

        -- JSON/GraphQL/Prisma
        "graphql",
        "prismals",
        "jsonls",

        -- Python
        "pyright",
        "ruff",

        -- Lua
        "lua_ls",

        -- Go
        "gopls",

        -- Shell
        "bashls",

        -- SQL
        "sqlls",

        -- DevOps/Infrastructure
        "dockerls",
        "docker_compose_language_service",
        "helm_ls",
        "yamlls",
        "terraformls",

        -- Documentation
        "marksman",

        -- Spelling/Typos
        "typos_lsp",

        -- Config Files
        "taplo", -- TOML
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "gofumpt",
        "goimports",
        "shfmt",
        "yamlfmt",
        "sql-formatter",
        "biome", -- Fast JS/TS formatter + linter

        -- Linters
        "eslint_d",
        "hadolint",
        "shellcheck",
        "markdownlint",
        "golangci-lint",

        -- DAP (Debug Adapters)
        "debugpy",
        "go-debug-adapter",
        "js-debug-adapter",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
}
