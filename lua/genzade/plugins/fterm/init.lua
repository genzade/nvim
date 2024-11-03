local config = function()
  local default_dimmensions = require('genzade.plugins.fterm.defaults').default_dimmensions

  local ok, fterm = pcall(require, 'FTerm')
  if not ok then
    print('fterm not ok .....................................')
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
          local term = require('FTerm.terminal')
          local lazygit = term:new():setup({
            dimensions = default_dimmensions,
            border = 'single', -- or 'double'
            cmd = 'lazygit',
          })

          vim.api.nvim_get_current_buf()

          lazygit:toggle()
        end,
        desc = 'Open Lazy[G]it terminal',
      },
    },
    { '<C-t>', fterm.toggle, desc = 'Toggle built in [T]erminal', mode = 't' },
  })

  -- might not be need post migration
  vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'NONE' })
end

return {
  'numtostr/FTerm.nvim',
  dependencies = { 'folke/which-key.nvim' },
  config = config,
}
