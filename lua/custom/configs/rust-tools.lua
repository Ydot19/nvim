local on_attach = require("plugins.configs.lspconfig").on_attach
local capabalities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabalities = capabalities,
  }
}

return options
