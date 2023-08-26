local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
      {"<leader>ma", function() require('harpoon.mark').add_file() end, {noremap = true}},
      {"<leader>mc", function() require('harpoon.mark').clear_all() end, {noremap = true}},
      {"<leader>md", function() require('harpoon.mark').rm_file() end, {noremap = true}},

      {"<leader>mu", function() require('harpoon.ui').toggle_quick_menu() end, {noremap = true}},
      {"<leader>ml", function() require('harpoon.ui').nav_next() end, {noremap = true}},
      {"<leader>mh", function() require('harpoon.ui').nav_prev() end, {noremap = true}},

      {"<leader>m1", function () require('harpoon.ui').nav_file(1) end, {noremap = true}},
      {"<leader>m2", function () require('harpoon.ui').nav_file(2) end, {noremap = true}},
      {"<leader>m3", function () require('harpoon.ui').nav_file(3) end, {noremap = true}},
      {"<leader>m4", function () require('harpoon.ui').nav_file(4) end, {noremap = true}},
      {"<leader>m5", function () require('harpoon.ui').nav_file(5) end, {noremap = true}},
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
      require("telescope").load_extension("undo")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "vimdoc",
        "lua",

        -- general // development agnostic
        "sql",
        "dockerfile",
        "graphql",
        "proto",
        "thrift",
        "regex",

        -- tf
        "hcl",
        "terraform",

        -- files and readme
        "markdown",
        "markdown_inline",
        "toml",
        "yaml",
        "mermaid",

        -- git
        "git_config",
        "git_rebase",

        -- golang
        "go",
        "gomod",
        "gosum",
        "gowork",

        -- web 
        "html",
        "scss",
        "css",
        "json",
        "svelte",
        "vue",
        "tsx",
        "typescript",
        "javascript",

        -- rust
        "rust",

        -- others
        "python",
        "ruby",
        "cpp",
        "cuda",
      }
    }
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- golang 
        "gopls",
        "delve",
        "golangci-lint",
        "goimports",
        -- js/ts 
        "standardjs",
        "ts-standard",
        "svelte-language-server",
        "vetur-vls",
        "deno",
        "eslint-lsp",
        "css-lsp",
        "html-lsp",
        -- communication protocols
        "graphql-language-service-cli",
        "protolint",
        "buf",
        -- python
        "pydocstyle",
        "pyre",
        "black",
        "debugpy",

        -- rust
        "rust-analyzer",
        "rustfmt",
        "codelldb",
        -- misc
        "bash-language-server",
        "terraform-ls",
        "sqlfmt",
        "ruby-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("custom.configs.go_nvim").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function (_, opts)
      local dapui = require("dapui")
      dapui.setup(opts)
      dapui.open({})
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      enabled = true,
      enabled_commands = true,
    },
  },
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    config = function ()
      require("custom.configs.dadbod").setup()
    end
  },
  {
    "nanotee/sqls.nvim",
    module = { "sqls" },
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  },
  {
    "github/copilot.vim",
    cmd = "Copilot",
    ft = {
      "go",
      "gomod",
      "python",
      "typescript",
      "javascript",
      "rust",
      "ruby",
      "terraform",
      "gitcommit",
      "sql",
     },
    config = function ()
      require("custom.configs.copilot").setup()
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim"
    },
    cmd = {"DiffviewFileHistory", "DiffviewOpen", "DiffviewClose"}
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
        {
        "<leader>op",
            function()
            local peek = require("peek")
                if peek.is_open() then
            peek.close()
            else
            peek.open()
            end
        end,
        desc = "Peek (Markdown Preview)",
        },
    },
    opts = { theme = "dark", app = "browser" },
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  }
}

return plugins
