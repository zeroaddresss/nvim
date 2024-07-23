-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  nvdash = {
    load_on_startup = true,
    header = {
      "███▄    █ ██▒   █▓ ▄████▄   ██░ ██  ▄▄▄      ▓█████▄ ",
      "██ ▀█   █▓██░   █▒▒██▀ ▀█  ▓██░ ██▒▒████▄    ▒██▀ ██▌",
      "██  ▀█ ██▒▓██  █▒░▒▓█    ▄ ▒██▀▀██░▒██  ▀█▄  ░██   █▌",
      "██▒  ▐▌██▒ ▒██ █░░▒▓▓▄ ▄██▒░▓█ ░██ ░██▄▄▄▄██ ░▓█▄   ▌",
      "██░   ▓██░  ▒▀█░  ▒ ▓███▀ ░░▓█▒░██▓ ▓█   ▓██▒░▒████▓ ",
      " ▒░   ▒ ▒   ░ ▐░  ░ ░▒ ▒  ░ ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒▒▓  ▒ ",
      " ░░   ░ ▒░  ░ ░░    ░  ▒    ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ▒  ▒ ",
      "  ░   ░ ░     ░░  ░         ░  ░░ ░  ░   ▒    ░ ░  ░ ",
      "        ░      ░  ░ ░       ░  ░  ░      ░  ░   ░    ",
      "              ░   ░                           ░      ",
    },
    --
    -- header = {
    --   "                                                     █████     █████                                     ",
    --   "                                                     ░░███     ░░███                                     ",
    --   "  █████████  ██████  ████████   ██████   ██████    ███████   ███████  ████████   ██████   █████   █████  ",
    --   " ░█░░░░███  ███░░███░░███░░███ ███░░███ ░░░░░███  ███░░███  ███░░███ ░░███░░███ ███░░███ ███░░   ███░░   ",
    --   " ░   ███░  ░███████  ░███ ░░░ ░███ ░███  ███████ ░███ ░███ ░███ ░███  ░███ ░░░ ░███████ ░░█████ ░░█████  ",
    --   "   ███░   █░███░░░   ░███     ░███ ░███ ███░░███ ░███ ░███ ░███ ░███  ░███     ░███░░░   ░░░░███ ░░░░███ ",
    --   "  █████████░░██████  █████    ░░██████ ░░████████░░████████░░████████ █████    ░░██████  ██████  ██████  ",
    --   " ░░░░░░░░░  ░░░░░░  ░░░░░      ░░░░░░   ░░░░░░░░  ░░░░░░░░  ░░░░░░░░ ░░░░░      ░░░░░░  ░░░░░░  ░░░░░░   ",
    -- },

    -- header = {
    --   "⢀⡴⠑⡄⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀      ",
    --   "⠸⡇⠀⠿⡀⠀⠀⠀⣀⡴⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠑⢄⣠⠾⠁⣀⣄⡈⠙⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⢀⡀⠁⠀⠀⠈⠙⠛⠂⠈⣿⣿⣿⣿⣿⠿⡿⢿⣆⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⢀⡾⣁⣀⠀⠴⠂⠙⣗⡀⠀⢻⣿⣿⠭⢤⣴⣦⣤⣹⠀⠀⠀⢀⢴⣶⣆ ",
    --   "⠀⠀⢀⣾⣿⣿⣿⣷⣮⣽⣾⣿⣥⣴⣿⣿⡿⢂⠔⢚⡿⢿⣿⣦⣴⣾⠁⠸⣼⡿ ",
    --   "⠀⢀⡞⠁⠙⠻⠿⠟⠉⠀⠛⢹⣿⣿⣿⣿⣿⣌⢤⣼⣿⣾⣿⡟⠉⠀⠀⠀⠀⠀ ",
    --   "⠀⣾⣷⣶⠇⠀⠀⣤⣄⣀⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ ",
    --   " ⠉⠈⠉⠀⠀⢦⡈⢻⣿⣿⣿⣶⣶⣶⣶⣤⣽⡹⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⠀⠉⠲⣽⡻⢿⣿⣿⣿⣿⣿⣿⣷⣜⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣶⣮⣭⣽⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
    --   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⠿⠿⠛⠉             ",
    -- },
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },

      function()
        local stats = require("lazy").stats()
        local plugins = "  Loaded " .. stats.count .. " plugins in "
        local time = math.floor(stats.startuptime) .. " ms  "
        return plugins .. time
      end,
    },
  },
  hl_override = {
    CursorLine = { bg = "#363947" },
    CursorLineNr = { bg = "#363947" },
    LineNr = { fg = "#A9B1D6" },
    Comment = { fg = "#7A828E", italic = true },
    ["@comment"] = { fg = "#7A828E", italic = true },
    -- ["@punctuation.bracket"] = { fg = { "light_grey", 50 } }, -- Light grey parentheses

    NvDashAscii = {
      fg = "blue",
      bg = "none",
    },
  },
  theme = "catppuccin",
  transparency = true,

  telescope = { style = "bordered" },
  statusline = {
    theme = "default",
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "codeium_status",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
    modules = {
      codeium_status = function()
        local status, status_string = pcall(function()
          return vim.fn["codeium#GetStatusString"]()
        end)
        if not status then
          status_string = ""
        end
        return "{...} " .. status_string
      end,
    },
  },
}

return M
