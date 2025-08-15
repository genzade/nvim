local config = function()
  local utils = require('genzade.core.utils')
  local autocmd = utils.create_autocmd
  local augroup = utils.create_augroup

  autocmd('ColorScheme', {
    group = augroup('custom_highlights_sonokai'),
    pattern = 'sonokai',
    callback = function()
      local config = vim.fn['sonokai#get_configuration']()
      local palette = vim.fn['sonokai#get_palette'](config.style, config.colors_override)
      local set_hl = vim.fn['sonokai#highlight']

      set_hl('NormalFloat', palette.fg, palette.none)
      set_hl('FloatBorder', palette.none, palette.none)
      set_hl('FloatTitle', palette.red, palette.none, 'bold')

      set_hl('Visual', palette.none, palette.grey_dim)
      set_hl('IncSearch', palette.bg0, palette.yellow)
      set_hl('Search', palette.none, palette.bg_yellow)

      set_hl('BlinkCmpMenu', palette.fg, palette.none)
      set_hl('BlinkCmpMenuBorder', palette.green, palette.none)
      set_hl('BlinkCmpMenuSelection', palette.bg0, palette.yellow, 'bold')
      set_hl('BlinkCmpDocBorder', palette.green, palette.none)
      set_hl('BlinkCmpDoc', palette.none, palette.none, 'italic')
      set_hl('BlinkCmpDocSeparator', palette.green, palette.none)
      set_hl('BlinkCmpLabelDescription', palette.blue, palette.none, 'italic')
    end,
  })

  -- Optionally configure and load the colorscheme
  -- directly inside the plugin declaration.

  -- sonokai_style can be one of 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
  vim.g.sonokai_style = 'default'
  vim.g.sonokai_enable_italic = 0
  vim.g.sonokai_transparent_background = 1
  vim.g.sonokai_better_performance = 1

  vim.cmd.colorscheme('sonokai')
end

return {
  'sainnhe/sonokai',
  lazy = false,
  priority = 1000,
  config = config,
}
