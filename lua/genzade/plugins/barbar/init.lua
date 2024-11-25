local config = function()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    {
      mode = { 'n' },
      { '<Leader>x', '<CMD>BufferClose<CR>', desc = 'Close the buffer' },
      { '<C-TAB>', '<CMD>BufferPrevious<CR>', desc = 'Go to previous buffer' },
      { '<S-TAB>', '<CMD>BufferNext<CR>', desc = 'Go to next buffer' },
    },
  })

  local ok, bufferline_api = pcall(require, 'bufferline.api')
  if not ok then
    print('bufferline_api not ok ...........................')
    return
  end

  -- uncomment if you plan to go back to tree view
  --
  -- vim.api.nvim_create_autocmd('BufWinEnter', {
  --   pattern = '*',
  --   callback = function()
  --     if vim.bo.filetype == 'NvimTree' then
  --       bufferline_api.set_offset(FILETREE_WIDTH, 'FileTree')
  --     end
  --   end,
  -- })

  local utils = require('genzade.core.utils')
  local augroup = utils.create_augroup
  local autocmd = utils.create_autocmd

  autocmd('BufWinLeave', {
    group = augroup('bufferline_offset'),
    pattern = '*',
    callback = function()
      if vim.fn.expand('<afile>'):match('NvimTree') then
        bufferline_api.set_offset(0)
      end
    end,
  })
end

return {
  'romgrk/barbar.nvim',
  dependencies = { 'folke/which-key.nvim', 'kyazdani42/nvim-web-devicons' },
  config = config,
}
