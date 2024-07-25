local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ruff", "gopls", "solidity", "solidity_ls", "prettier_d" }
local util = require "lspconfig/util"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- go
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      -- staticcheck = true,
    },
  },
}

-- solidity
lspconfig.solidity_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "solidity" },
  root_dir = lspconfig.util.root_pattern("hardhat.config.*", ".git"),
}

local solhint = require "efmls-configs.linters.solhint"
local prettier_d = require "efmls-configs.formatters.prettier_d"

-- configure efm server
lspconfig.efm.setup {
  filetypes = {
    "solidity",
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  settings = {
    languages = {
      solidity = { solhint, prettier_d },
    },
  },
}
