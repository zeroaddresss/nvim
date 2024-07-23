require "nvchad.options"

-- add yours here!

local o = vim.opt

o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both"
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
