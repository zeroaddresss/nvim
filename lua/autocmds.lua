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

-- highlight on yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- lsp stuff
-- https://github.com/NvChad/NvChad/blob/b657b0ef84a6aa9a86ac05341d1bc1ab5f037ee7/lua/nvchad/configs/lspconfig.lua
-- nomap("n", "<leader>sh")
-- nomap("n", "<leader>wa")
-- nomap("n", "<leader>wr")
-- nomap("n", "<leader>wl")
-- nomap("n", "<leader>D")
-- nomap("n", "<leader>ra")
-- nomap("n", "<leader>ca")
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local keys_to_disable = {
        "<leader>wa",
        "<leader>wr",
        "<leader>wl",
        "<leader>D",
        "<leader>ra",
        "<leader>ca",
        "<leader>sh",
        -- "<leader>ph",
        -- "<leader>rh",
      }
      local function opts(desc)
        return { buffer = args.buf, desc = "LSP " .. desc }
      end
      for _, key in ipairs(keys_to_disable) do
        vim.keymap.del("n", key, { buffer = args.buf })
      end

      local map = vim.keymap.set
      map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
      map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
      map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
      map("n", "gr", vim.lsp.buf.references, opts "Show references")
      map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Show signature help")
      map("n", "<leader>la", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
      map("n", "<leader>lr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

      map("n", "<leader>ll", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts "List workspace folders")

      map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")

      map("n", "<leader>ln", function()
        require "nvchad.lsp.renamer"()
      end, opts "NvRenamer")

      map({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, opts "Code action")
    end)
  end,
})
-- -- vim.api.nvim_create_autocmd({ "UIEnter" }, {
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
