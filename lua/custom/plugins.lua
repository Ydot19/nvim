local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "deno",
        "delve",

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
    ft = {"go", "gomod", "sql"},
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
  }
}

return plugins
