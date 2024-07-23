vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.g.vista_default_executive = "nvim_lsp"
-- e.g., more compact: ["▸ ", ""]
vim.g.vista_icon_indent = {
  "╰─▸ ",
  "├─▸ ",
}

vim.g.vista_fzf_preview = "right:60%"
--
-- -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
-- vim.g.vista#renderer#enable_icon = 1
--
-- vim.g.vista#renderer#icons = {
--   function = "\uf794",
--   variable = "\uf71b",
-- }
