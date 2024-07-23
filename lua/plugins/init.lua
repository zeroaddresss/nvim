return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "github/copilot.vim",
    cmd = "Copilot",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gopls",
        "ruff",
        "ruff-lsp",
        "solidity",
        "solidity-ls",
        "typescript-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "javascript",
        "solidity",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "regex",
      },
      -- highlight and indent are enabled by default in native nvchad config
      fold = {
        enable = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = function()
        return 0
      end,
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "",
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")

      require("which-key").setup(opts)
      require("which-key").add {
        { "<leader>g", group = "Git", icon = "󰊢" },
        { "<leader>l", group = "LSP", icon = "" },
        { "<leader>f", group = "Find", icon = "" },
        -- { "<leader>b", group = "Buffer", icon = "" },
        { "<leader>t", group = "Terminal", icon = "" },
        { "<leader>n", group = "Neovim", icon = "" },
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      local actions = require "telescope.actions"
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
          },
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
          -- file_previewer = require("telescope.previewers").cat.new,
          -- grep_previewer = require("telescope.previewers").vimgrep.new,
          -- qflist_previewer = require("telescope.previewers").qflist.new,
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
    },
    config = function(_, opts)
      if opts then
        require("luasnip").config.setup(opts)
      end
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
      -- friendly-snippets - enable standardized comments snippets
      require("luasnip").filetype_extend("typescript", { "tsdoc" })
      require("luasnip").filetype_extend("javascript", { "jsdoc" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("python", { "pydoc" })
      require("luasnip").filetype_extend("cs", { "csharpdoc" })
      require("luasnip").filetype_extend("go", { "godoc" })
      require("luasnip").filetype_extend("java", { "javadoc" })
      require("luasnip").filetype_extend("c", { "cdoc" })
      require("luasnip").filetype_extend("cpp", { "cppdoc" })
      require("luasnip").filetype_extend("php", { "phpdoc" })
      require("luasnip").filetype_extend("kotlin", { "kdoc" })
      require("luasnip").filetype_extend("ruby", { "rdoc" })
      require("luasnip").filetype_extend("sh", { "shelldoc" })
    end,
  },
  -- Codeium AI (both inline code completion and Chat)
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<C-i>", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
      signature = {
        enabled = false,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
        enabled = false,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup {}
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "f-person/git-blame.nvim",
    init = function()
      vim.keymap.set(
        "n",
        "<leader>gO",
        "<cmd>GitBlameOpenCommitURL<cr>",
        { desc = "GitBlame | Open Commit Url", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gc",
        "<cmd>GitBlameCopyCommitURL<cr>",
        { desc = "GitBlame | Copy Commit Url", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gf",
        "<cmd>GitBlameOpenFileURL<cr>",
        { desc = "GitBlame | Open File Url", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gC",
        "<cmd>GitBlameCopyFileURL<cr>",
        { desc = "GitBlame | Copy File Url", silent = true }
      )
      vim.keymap.set("n", "<leader>gs", "<cmd>GitBlameCopySHA<cr>", { desc = "GitBlame | Copy SHA", silent = true })
      vim.keymap.set("n", "<leader>gt", function()
        if vim.g.gitblame_enabled ~= true then
          vim.cmd "GitBlameEnable"
          vim.g.gitblame_enabled = true
        else
          vim.cmd "GitBlameDisable"
          vim.g.gitblame_enabled = false
        end
      end, { desc = "GitBlame | Toggle Blame", silent = true })
    end,
    cmd = {
      "GitBlameToggle",
      "GitBlameEnable",
      "GitBlameOpenCommitURL",
      "GitBlameCopyCommitURL",
      "GitBlameOpenFileURL",
      "GitBlameCopyFileURL",
      "GitBlameCopySHA",
    },
    opts = {},
  },
  {
    "akinsho/toggleterm.nvim",
    init = function()
      vim.keymap.set(
        "n",
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        { desc = "ToggleTerm | Float Terminal", silent = true }
      )

      vim.keymap.set(
        "n",
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        { desc = "ToggleTerm | Horizontal Terminal", silent = true }
      )

      vim.keymap.set(
        "n",
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical<cr>",
        { desc = "ToggleTerm | Vertical Terminal", silent = true }
      )

      vim.keymap.set("n", "<leader>gg", function()
        local status_ok, _ = pcall(require, "toggleterm")
        if not status_ok then
          return vim.notify "toggleterm.nvim isn't installed!!!"
        end

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
        lazygit:toggle()
      end, { desc = "ToggleTerm | Lazygit", silent = true })
    end,
    cmd = {
      "ToggleTerm",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.4
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = false,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      autochdir = true,
      highlights = {
        NormalFloat = {
          link = "Normal",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      float_opts = {
        border = "rounded",
        height = math.ceil(vim.o.lines * 1.0 - 20),
        width = math.ceil(vim.o.columns * 1.0 - 20),
        winblend = 0,
      },
    },
  },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
  {
    "sindrets/diffview.nvim",
    init = function()
      vim.keymap.set("n", "<leader>gd", function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd "DiffviewOpen"
        else
          vim.cmd "DiffviewClose"
        end
      end, { desc = "Diffview | Toggle Diffview", silent = true })
    end,
    event = "User FilePost",
  },
  -- NOTE: Peek At Lines
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = true,
  },
  -- {
  --   "andweeb/presence.nvim",
  --   lazy = false,
  --   config = function()
  --     require("presence").setup()
  --   end,
  -- },
  -- {
  --   "IogaMaster/neocord",
  --   event = "VeryLazy",
  --   config = {
  --     main_image = "logo",
  --     logo = "https://raw.githubusercontent.com/github/explore/26674e638508ac4a4e113ee32d6755ebfa000569/topics/neovim/neovim.png",
  --     show_time = true,
  --     log_level = "debug",
  --   },
  -- },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "go", "lua", "python" },
    opts = function()
      require "configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    -- @type gopher.Config
    opts = {},
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require "cmp"

      local opts = {
        ignore_cmds = { "Man", "!" },
      }

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } }, -- doesn't seem to work?
          { { name = "cmdline", option = opts } }
        ),
      })
    end,
  },
  {
    "majutsushi/tagbar",
    keys = {
      { "<leader>tt", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" },
      { "<leader>tc", "<cmd>TagbarClose<cr>", desc = "Toggle Close" },
    },
  },
  { "liuchengxu/vista.vim" },
}
