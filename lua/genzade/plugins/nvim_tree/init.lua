local config = function()
  local ok, nvim_tree = pcall(require, 'nvim-tree')
  if not ok then
    return
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    { '<Leader>', group = 'NvimTree' },
    { '<Leader>e', '<CMD>NvimTreeFindFileToggle<CR>', desc = 'NvimTre[E] toggle' },
  })

  local defaults = require('genzade.plugins.nvim_tree.defaults')

  nvim_tree.setup({
    disable_netrw = true,
    on_attach = defaults.on_attach,
    view = defaults.float_view,
  })
end

return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    { 'folke/which-key.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
  },
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFileToggle' },
  event = 'BufEnter',
  config = config,
}
