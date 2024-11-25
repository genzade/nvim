local config = function()
  local defaults = require('genzade.plugins.fterm.defaults')
  local default_dimmensions = defaults.default_dimmensions

  local ok, fterm = pcall(require, 'FTerm')
  if not ok then
    return
  end

  fterm.setup({
    dimensions = default_dimmensions,
    border = 'single', -- or 'double'
  })

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    {
      mode = { 'n' },
      { '<C-t>', fterm.toggle, desc = 'Toggle built in [T]erminal' },
      {
        '<Leader>g',
        function()
          defaults.term_setup('lazygit')
        end,
        desc = 'Open Lazy[G]it terminal',
      },
      {
        '<Leader>G',
        function()
          defaults.term_setup('tig')
        end,
        desc = 'Open ti[G] terminal',
      },
    },
    { '<C-t>', fterm.toggle, desc = 'Toggle built in [T]erminal', mode = 't' },
  })

  vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'NONE' })
end

return {
  'numtostr/FTerm.nvim',
  dependencies = { 'folke/which-key.nvim' },
  config = config,
}
