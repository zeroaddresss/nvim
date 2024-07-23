local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shellcheck" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    python = { "ruff_format", "isort" },
    go = { "goimports", "gofmt" },
    solidity = { "solc", "solidity" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
