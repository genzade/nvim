vim.opt.list = true

local defaults = require('genzade.plugins.ibl.defaults')

local config = function()
  local has_indent_ibl, ibl = pcall(require, 'ibl')
  if not has_indent_ibl then
    return
  end

  local hooks = require('ibl.hooks')
  local wtspc = hooks.type.WHITESPACE
  local builtin = hooks.builtin

  hooks.register(wtspc, builtin.hide_first_space_indent_level)
  hooks.register(wtspc, builtin.hide_first_tab_indent_level)

  -- create the highlight groups in the highlight setup hook,
  -- so they are reset every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for _, color in ipairs(defaults.rainbow_colors) do
      local name = color[1]
      local hex = color[2]
      vim.api.nvim_set_hl(0, name, { fg = hex })
    end
  end)

  ibl.setup(defaults.opts)
end

return {
  'lukas-reineke/indent-blankline.nvim',
  config = config,
  enabled = true,
  event = 'BufReadPre',
  main = 'ibl',
  opts = defaults.opts,
}
