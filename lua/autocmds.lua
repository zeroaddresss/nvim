vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.opt_local.number = true
  end,
  desc = "Enable Line Number in Telescope Preview",
})

-- format on save (conform): https://github.com/stevearc/conform.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})
-- vim.api.nvim_create_autocmd({ "UIEnter" }, {
--   callback = function()
--     local handle = io.popen "pgrep nvim | wc -l"
--     local output = handle:read "*a"
--     handle:close()
--
--     if tonumber(output) == 2 then
--       require("lazy").load {
--         plugins = {
--           "presence.nvim",
--         },
--       }
--     end
--   end,
-- })
