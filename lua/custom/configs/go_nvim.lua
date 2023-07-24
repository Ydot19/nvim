local M = {}

function M.setup()
  require("go").setup{
    gofmt = 'gofmt',
    icons = {
      breakpoint = '📍',
      currentpos = '➟'
    }
  }
end

return M
