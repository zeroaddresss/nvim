return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- {
  --   "github/copilot.vim",
  --   cmd = "Copilot",
  -- },

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
        "prettierd",
        "gopls",
        "ruff",
        "ruff-lsp",
        "pyright",
        "solidity",
        "solidity-ls",
        "solhint",
        "nomicfoundation-solidity-language-server",
        "vscode-solidity-server",
        "typescript-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
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
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      fold = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["id"] = "@conditional.inner",
            ["ad"] = "@conditional.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["sp"] = "@parameter.inner",
          },
          swap_previous = {
            ["sP"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]o"] = "@loop.*",
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_next = {
            ["]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["[d"] = "@conditional.outer",
          },
        },
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
      -- require("nvim-treesitter.parsers").get_parser_configs().solidity = {
      --   install_info = {
      --     url = "https://github.com/JoranHonig/tree-sitter-solidity",
      --     files = { "src/parser.c" },
      --     requires_generate_from_grammar = true,
      --   },
      --   filetype = "solidity",
      -- }
    end,
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
        { "<leader>a", group = "AI", icon = "" },
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
          file_ignore_patterns = { ".git", ".DS_Store", "node_modules" },
          hidden = true,
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
      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-i>", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<c-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<c-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
        enabled = false,
        render = "compact",
        stages = "fade",
        top_down = false,
        -- timeout = 3000,
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
        --NOTE: Usage: https://github.com/kylechui/nvim-surround?tab=readme-ov-file#rocket-usage
      }
    end,
  },

  {
    --NOTE: "I" to toggle hidden files in nvim-tree
    -- Oil recipes for hidden files: https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#toggle-file-detail-view
    "stevearc/oil.nvim",
    lazy = false,
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
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
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
    version = "*", -- or branch = "dev", to use the latest commit
    cmd = "Screenkey",
    opts = {},
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

  {
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      require("presence").setup()
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "go", "lua", "python" },
    opts = function()
      require "configs.null-ls"
    end,
  },

  {
    "olexsmir/gopher.nvim",
    event = "BufEnter",
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
      local mappings = vim.tbl_extend("force", {}, require("cmp").mapping.preset.cmdline(), {
        ["<CR>"] = { c = require("cmp").mapping.confirm { select = true } },
      })
      require("cmp").setup.cmdline(":", {
        mapping = mappings,
        sources = {
          { name = "cmdline" },
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local config = require "nvchad.configs.cmp"
      config.mapping["<Tab>"] = nil
      config.mapping["<S-Tab>"] = nil
      config.performance = {
        debounce = 0,
        throttle = 0,
      }
      -- config.sources = {
      --   { name = "supermaven" },
      -- }
    end,
  },

  {
    "majutsushi/tagbar",
    keys = {
      { "<leader>tt", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" },
      { "<leader>tc", "<cmd>TagbarClose<cr>", desc = "Toggle Close" },
    },
  },

  {
    "liuchengxu/vista.vim",
    lazy = false,
    init = function()
      vim.keymap.set("n", "<leader>to", "<cmd>Vista!!<cr>", { desc = "Vista | Toggle Overview" })
    end,
  },

  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  --   lazy = false,
  -- },

  {
    "pwntester/octo.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end

        local map = vim.keymap.set

        map("n", "<leader>gH", gs.reset_hunk, opts "Reset Hunk")
        map("n", "<leader>gh", gs.preview_hunk, opts "Preview Hunk")
        map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
      end,
    },
  },

  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = false,
          keys = {
            { "t", mode = { "n", "x", "o" }, false },
            { "T", mode = { "n", "x", "o" }, false },
            { "f", mode = { "n", "x", "o" }, false },
            { "F", mode = { "n", "x", "o" }, false },
          },
        },
      },
    },
  -- stylua: ignore
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "stevearc/oil.nvim",
    vim.keymap.set("n", "<leader>e", function()
      require("oil").toggle_float "."
    end, { desc = "Open Explorer (Oil)" }),
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
      win_options = {
        wrap = true,
        winblend = 0,
      },
      keymaps = {
        ["<C-c>"] = false,
        ["q"] = "actions.close",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },

  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        quickfix = { win = { size = 30 } },
        diagnostics = { win = { size = 30 } },
        lsp = { win = { size = 100 } },
      },
      action_keys = {
        close = { "q", "<esc>" },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>lt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle Diagnostics (Trouble)",
      },
      {
        "<leader>lb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>lw",
        "<cmd>Trouble workspace_diagnostics toggle focus=true win.position=bottom<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<leader>ls",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>lr",
        "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
        desc = "LSP References (Trouble)",
      },
      {
        "<leader>lL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>lq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  { "wakatime/vim-wakatime", lazy = false },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup()
      require("telescope").load_extension "projects"
      vim.keymap.set("n", "<leader>fp", function()
        require("telescope").extensions.projects.projects {}
      end, { desc = "Find Project" })
    end,
  },

  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   lazy = false,
  --   branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --   },
  --   vim.keymap.set({ "n", "v" }, "<leader>ac", function()
  --     local chat = require "CopilotChat"
  --     chat.toggle()
  --   end, { desc = "CopilotChat Toggle" }),
  --
  --   vim.keymap.set({ "n", "v" }, "<leader>ax", function()
  --     local chat = require "CopilotChat"
  --     chat.reset()
  --   end, { desc = "CopilotChat Reset" }),
  --
  --   -- Quick chat with Copilot
  --   vim.keymap.set({ "n", "v" }, "<leader>aq", function()
  --     local input = vim.fn.input "Quick Chat: "
  --     if input ~= "" then
  --       require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  --     end
  --   end, { desc = "CopilotChat - Quick chat" }),
  --
  --   vim.keymap.set("n", "<leader>ah", function()
  --     local actions = require "CopilotChat.actions"
  --     require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  --   end, { desc = "CopilotChat - Help actions" }),
  --
  --   vim.keymap.set("n", "<leader>aA", function()
  --     local actions = require "CopilotChat.actions"
  --     require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  --   end, { desc = "CopilotChat - Prompt actions" }),
  --
  --   opts = {
  --     debug = true, -- Enable debugging
  --     prompts = {
  --       -- Code related prompts
  --       Explain = {
  --         prompt = "Please explain how the following code works.",
  --         mapping = "<leader>aE",
  --         description = "CopilotChat Explain Code",
  --       },
  --       Review = {
  --         prompt = "Please review the following code and provide suggestions for improvement.",
  --         mapping = "<leader>aR",
  --         description = "CopilotChat Review Code",
  --       },
  --
  --       Tests = {
  --         prompt = "Please provide unit tests for the following code.",
  --         mapping = "<leader>at",
  --         description = "CopilotChat Test Code",
  --       },
  --
  --       Refactor = {
  --         prompt = "Please refactor the following code to improve its clarity and readability.",
  --         mapping = "<leader>aR",
  --         description = "CopilotChat Refactor Code",
  --       },
  --
  --       FixCode = {
  --         prompt = "Please fix the following code to make it work as intended.",
  --         mapping = "<leader>af",
  --         description = "CopilotChat Fix Code",
  --       },
  --
  --       FixError = {
  --         prompt = "Please explain the error in the following text and provide a solution.",
  --         mapping = "<leader>aF",
  --         description = "CopilotChat Fix Error",
  --       },
  --
  --       BetterNamings = {
  --         prompt = "Please provide better names for the following variables and functions.",
  --         mapping = "<leader>an",
  --         description = "CopilotChat Better Namings",
  --       },
  --
  --       Documentation = {
  --         prompt = "Please provide documentation for the following code.",
  --         mapping = "<leader>ad",
  --         description = "CopilotChat Generate Documentation",
  --       },
  --
  --       -- Text related prompts
  --       Summarize = "Please summarize the following text.",
  --       Spelling = "Please correct any grammar and spelling errors in the following text.",
  --       Wording = "Please improve the grammar and wording of the following text.",
  --       Concise = "Please rewrite the following text to make it more concise.",
  --
  --       -- Custom prompts
  --       MyCustomPrompt = {
  --         prompt = "/MyCustomPrompt Include some additional context.",
  --       },
  --     },
  --
  --     -- nvim-cmp integration
  --     -- Registers copilot-chat source and enables it for copilot-chat filetype (so copilot chat window)
  --     -- require("CopilotChat.integrations.cmp").setup(),
  --
  --     mappings = {
  --       complete = {
  --         insert = "",
  --       },
  --     },
  --
  --     -- See Configuration section for rest
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },

  {
    "shortcuts/no-neck-pain.nvim",
    lazy = false,
    version = "*",
    config = function()
      require("no-neck-pain").setup {}
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    endpoint = "https://api.deepseek.com/beta",
    build = "make",
    opts = {
      default_bindings = false,
      provider = "deepseek",
      vendors = {
        ---@type AvanteProvider
        deepseek = {
          endpoint = "https://api.deepseek.com/chat/completions",
          model = "deepseek-coder",
          api_key_name = "DEEPSEEK_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
              },
              body = {
                model = opts.model,
                messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                temperature = 0,
                max_tokens = 4096,
                stream = true, -- this will be set by default.
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
          end,
        },
      },
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below is optional, make sure to setup it properly if you have lazy=true
        {
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
  },

  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("supermaven-nvim").setup {
  --       keymaps = {
  --         accept_suggestion = "<Tab>",
  --         clear_suggestion = "<C-x>",
  --         accept_word = "<C-j>", -- accept partial suggestion (word only)
  --       },
  --       ignore_filetypes = {},
  --       color = {
  --         suggestion_color = "#ffffff",
  --         cterm = 244,
  --       },
  --       log_level = "info", -- set to "off" to disable logging completely
  --       disable_inline_completion = false, -- disables inline completion for use with cmp
  --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --     }
  --   end,
  -- },

  -- {
  --   "olimorris/codecompanion.nvim",
  --   -- event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-telescope/telescope.nvim", -- Optional
  --     {
  --       "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
  --       opts = {},
  --     },
  --   },
  --   adapters = {
  --     deepseek = require("codecompanion.adapters").extend("openai", {
  --       env = {
  --         api_key = "cmd:gpg --decrypt ~/.deepseek-api-key.gpg 2>/dev/null",
  --       },
  --       url = "https://api.deepseek.com/beta/chat/completions",
  --       schema = {
  --         model = {
  --           default = "deepseek-coder",
  --           choices = {
  --             "deepseek-coder",
  --             -- "deepseek-chat",
  --           },
  --         },
  --         max_token = {
  --           default = 8192,
  --         },
  --         temperature = {
  --           default = 0,
  --         },
  --       },
  --     }),
  --   },
  -- },

  {
    "AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      { "nvim-telescope/telescope.nvim" },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require("neoclip").setup {
        history = 100,
        enable_persistent_history = true,
        keys = { telescope = { i = { select = "<c-y>", paste = "<cr>" } } },
      }
      vim.keymap.set({ "n", "v" }, "<leader>np", "<cmd>Telescope neoclip<cr>", { desc = "Neoclip | Paste" })
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },

  {
    -- text objects: https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#list-of-text-objects
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = { useDefaultKeymaps = true },
  },

  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md#default-config
  { "echasnovski/mini.ai", version = "*", event = "BufReadPost", opts = {} },

  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("neoscroll").setup {}
  --   end,
  -- },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup {
        -- default values
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 2, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },

  -- {
  --   "echasnovski/mini.indentscope",
  --   version = "*",
  --   event = "BufReadPre",
  --   opts = {
  --     -- Draw options
  --     draw = {
  --       -- Delay (in ms) between event and start of drawing scope indicator
  --       delay = 0,
  --
  --       -- Animation rule for scope's first drawing. A function which, given
  --       -- next and total step numbers, returns wait time (in ms). See
  --       -- |MiniIndentscope.gen_animation| for builtin options. To disable
  --       -- animation, use `require('mini.indentscope').gen_animation.none()`.
  --       -- animation = --<function: implements constant 20ms between steps>,
  --
  --       -- Symbol priority. Increase to display on top of more symbols.
  --       priority = 2,
  --     },
  --     -- Module mappings. Use `''` (empty string) to disable one.
  --     mappings = {
  --       -- Textobjects
  --       object_scope = "ii",
  --       object_scope_with_border = "ai",
  --
  --       -- Motions (jump to respective border line; if not present - body line)
  --       goto_top = "[i",
  --       goto_bottom = "]i",
  --     },
  --     -- Options which control scope computation
  --     options = {
  --       -- Type of scope's border: which line(s) with smaller indent to
  --       -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
  --       border = "both",
  --
  --       -- Whether to use cursor column when computing reference indent.
  --       -- Useful to see incremental scopes with horizontal cursor movements.
  --       indent_at_cursor = true,
  --
  --       -- Whether to first check input line to be a border of adjacent scope.
  --       -- Use it if you want to place cursor on function header to get scope of
  --       -- its body.
  --       try_as_border = true,
  --     },
  --
  --     -- Which character to use for drawing scope indicator
  --     symbol = "│",
  --   },
  -- },
  --
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          -- ...
        },
        indent = {
          enable = true,
          -- ...
        },
        line_num = {
          enable = true,
          -- ...
        },
        blank = {
          enable = true,
          -- ...
        },
      }
    end,
  },
}
