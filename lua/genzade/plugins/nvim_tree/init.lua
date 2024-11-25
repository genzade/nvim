local config = function()
  local ok, nvim_tree = pcall(require, 'nvim-tree')
  if not ok then
    return
  end

  local utils = require('genzade.core.utils')
  local augroup = utils.create_augroup
  local autocmd = utils.create_autocmd
  local set_hl = vim.api.nvim_set_hl

  -- TODO: possibly move to after folder
  autocmd('Colorscheme', {
    pattern = '*',
    group = augroup('nvimtree_colorscheme', { clear = false }),
    callback = function()
      set_hl(0, 'NvimTreeNormal', { bg = '#21252B', fg = '#9da5b3' })
      set_hl(0, 'NvimTreeBg', { bg = '#2B4252', fg = nil })
    end,
  })

  autocmd('FileType', {
    pattern = 'NvimTree',
    group = augroup('nvimtree_filetype', { clear = false }),
    callback = function()
      vim.api.nvim_win_set_option(0, 'winhighlight', 'Normal:NvimTreeBg')
    end,
  })

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
