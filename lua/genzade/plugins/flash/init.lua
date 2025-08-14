local defaults = require('genzade.plugins.flash.defaults')

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = defaults.keys,
}
