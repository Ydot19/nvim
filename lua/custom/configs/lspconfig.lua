local on_attach = require("plugins.configs.lspconfig").on_attach

local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"


lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
  settings = {
    gopls = {
      buildFlags = {"-tags=integration,unit,endtoendtest"},
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        useany = true,
      }
    }
  },
  root_dir = function(fname)
      -- see: https://github.com/neovim/nvim-lspconfig/issues/804
      if not mod_cache then
        local result = util.async_run_command 'go env GOMODCACHE'
        if result and result[1] then
          mod_cache = vim.trim(result[1])
        end
      end
      if fname:sub(1, #mod_cache) == mod_cache then
        local clients = vim.lsp.get_active_clients { name = 'gopls' }
        if #clients > 0 then
          return clients[#clients].config.root_dir
        end
      end
      return util.root_pattern('go.work', 'go.mod', '.git')(fname)
    end,
}
