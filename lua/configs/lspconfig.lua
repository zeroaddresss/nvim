local on_attach = require("nvchad.configs.lspconfig").on_attach
-- https://github.com/NvChad/NvChad/blob/b657b0ef84a6aa9a86ac05341d1bc1ab5f037ee7/lua/nvchad/configs/lspconfig.lua
-- local map = vim.keymap.set
-- local on_attach = function(_, bufnr)
--   local function opts(desc)
--     return { buffer = bufnr, desc = "LSP " .. desc }
--   end
--
-- map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
-- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
-- map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
-- map("n", "gr", vim.lsp.buf.references, opts "Show references")
-- map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Show signature help")
-- map("n", "<leader>la", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
-- map("n", "<leader>lr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
--
-- map("n", "<leader>ll", function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, opts "List workspace folders")
--
-- map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")
--
-- map("n", "<leader>ln", function()
--   require "nvchad.lsp.renamer"()
-- end, opts "NvRenamer")
--
-- map({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, opts "Code action")
-- end
--
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ruff", "gopls", "solidity", "solc" }
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
