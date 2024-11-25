local M = {}

M.default_dimmensions = {
  height = 0.9,
  width = 0.9,
  x = 0.5,
  y = 0.5,
}

M.term_setup = function(cmd)
  local term = require('FTerm.terminal')
  local lazygit = term:new():setup({
    dimensions = M.default_dimmensions,
    border = 'single', -- or 'double'
    cmd = cmd,
  })

  vim.api.nvim_get_current_buf()

  lazygit:toggle()
end

return M
