local M = {}

M.opts = function()
  return {
    draw = {
      delay = 25,
      priority = 2,
    },
    options = {
      try_as_border = false,
      try_as_border_hl = true,
    },
    symbol = '│',
  }
end

return M
