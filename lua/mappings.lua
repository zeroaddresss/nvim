require "nvchad.mappings"

local cwd = vim.fn.stdpath "config" .. "/"
local config_dir = { cwd }
local map = vim.keymap.set
local nomap = vim.keymap.del

-- Disable mappings
-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
nomap("n", "<leader>h")
nomap("n", "<leader>v")

-- toggleable
nomap({ "n", "t" }, "<A-v>")
nomap({ "n", "t" }, "<A-h>")
nomap({ "n", "t" }, "<A-i>")

-- whichkey
nomap("n", "<leader>wK")

nomap("n", "<leader>wk")

-- blankline
nomap("n", "<leader>cc")

-- lsp stuff
-- https://github.com/NvChad/NvChad/blob/b657b0ef84a6aa9a86ac05341d1bc1ab5f037ee7/lua/nvchad/configs/lspconfig.lua
-- nomap("n", "<leader>sh")
-- nomap("n", "<leader>wa")
-- nomap("n", "<leader>wr")
-- nomap("n", "<leader>wl")
-- nomap("n", "<leader>D")
-- nomap("n", "<leader>ra")
-- nomap("n", "<leader>ca")
--
-- lsp diagnostic
nomap("n", "<leader>ds") -- remapped to <leader>ld (lsp diagnostic)

-- format files
nomap("n", "<leader>fm") -- remapped to <leader>lf (lsp format)

-- telescope
nomap("n", "<leader>ma")
nomap("n", "<leader>cm")
nomap("n", "<leader>gt")
nomap("n", "<leader>pt")
nomap("n", "<leader>th")

-- nvtree toggle window
nomap("n", "<leader>e")

-- misc
nomap("n", "<leader>n")
nomap("n", "<leader>rn")
nomap("n", "<leader>ch")

-- mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC> <cmd> w <cr>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Better Down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "General | Better Down", expr = true, silent = true })
-- Better Up
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "General | Better Up", expr = true, silent = true })

map("n", "c", '"ac', { desc = "Change and yank to register a" })
map("n", "d", '"ad', { desc = "Delete and yank to register a" })
map("v", "c", '"ac', { desc = "Change and yank to register a" })
map("v", "d", '"ad', { desc = "Delete and yank to register a" })
map("n", "<leader>q", "<cmd>qa!<cr>", { desc = "quit", silent = true })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "vsplit" })
map("n", "<leader>h", "<cmd>split<cr>", { desc = "split" })

-- Indent backward
map("n", "<", "<<", { desc = "General | Indent backward", silent = true })

-- Indent forward
map("n", ">", ">>", { desc = "General | Indent forward", silent = true })

-- Move the line up
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "General | Move the line up", silent = true })

-- Move the line down
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "General | Move the line down", silent = true })

-- Move the line up (Insert Mode)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "General | Move the line up", silent = true })

-- Move the line down (Insert Mode)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "General | Move the line down", silent = true })

-- Better Down (Visual Mode)
map("v", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "General | Better Down", expr = true, silent = true })

-- Better Up (Visual Mode)
map("v", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "General | Better Up", expr = true, silent = true })

-- Better Paste (Visual Mode)
map("v", "p", '"_dP', { desc = "General | Better Paste", silent = true })

-- Indent backward (Visual Mode)
map("v", "<", "<gv", { desc = "General | Indent backward", silent = true })

-- Indent forward (Visual Mode)
map("v", ">", ">gv", { desc = "General | Indent forward", silent = true })

-- Move the selected text up (Visual Mode)
map("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "General | Move the selected text up", silent = true })

-- Move the selected text down (Visual Mode)
map("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "General | Move the selected text down", silent = true })

-- Enter Insert Mode Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Insert Mode", silent = true })
-- Messages
map("n", "<leader>nm", "<cmd>messages<cr>", { desc = "Neovim | Messages", silent = true })

-- Health
map("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "Neovim | Health", silent = true })

-- Version
map("n", "<leader>nv", function()
  local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
end, { desc = "Neovim | Version", silent = true })

map("n", "<leader>fT", "<cmd>TodoLocList<cr>", { desc = "Todo List (compact)", silent = true })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todo List (Telescope)", silent = true })

map("n", "<leader>gO", "<cmd>GitBlameOpenCommitURL<cr>", { desc = "GitBlame | Open Commit Url", silent = true })
map("n", "<leader>gu", "<cmd>GitBlameCopyCommitURL<cr>", { desc = "GitBlame | Copy Commit Url", silent = true })
map("n", "<leader>gf", "<cmd>GitBlameOpenFileURL<cr>", { desc = "GitBlame | Open File Url", silent = true })
map("n", "<leader>gC", "<cmd>GitBlameCopyFileURL<cr>", { desc = "GitBlame | Copy File Url", silent = true })
map("n", "<leader>gS", "<cmd>GitBlameCopySHA<cr>", { desc = "GitBlame | Copy SHA", silent = true })
map("n", "<leader>gt", function()
  if vim.g.gitblame_enabled ~= true then
    vim.cmd "GitBlameEnable"
    vim.g.gitblame_enabled = true
  else
    vim.cmd "GitBlameDisable"
    vim.g.gitblame_enabled = false
  end
end, { desc = "GitBlame | Toggle Blame", silent = true })

map("n", "<leader>lf", function()
  require("configs.conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>tH", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>nt", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })

map("n", "<leader>nl", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>nr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>nc", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map(
  "n",
  "<leader>th",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { desc = "ToggleTerm | Horizontal Terminal", silent = true }
)

-- Find Config Files
map("n", "<leader>nf", function()
  require("telescope.builtin").find_files {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Find Config Files", silent = true })

-- Grep Config Files
map("n", "<leader>ng", function()
  require("telescope.builtin").live_grep {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Grep Config Files", silent = true })
