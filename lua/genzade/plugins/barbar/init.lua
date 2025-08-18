local config = function()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  local has_tbuiltin, tbuiltin = pcall(require, 'telescope.builtin')
  if not has_tbuiltin then
    return
  end

  local barbar_ok, barbar = pcall(require, 'barbar')
  if not barbar_ok then
    return
  end

  barbar.setup({
    icons = {
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
    },
  })

  wk.add({
    {
      mode = { 'n' },
      { '<Leader>x', '<CMD>BufferClose<CR>',     desc = 'Close the buffer' },
      { '<C-TAB>',   '<CMD>BufferPrevious<CR>',  desc = 'Go to previous buffer' },
      { '<S-TAB>',   '<CMD>BufferNext<CR>',      desc = 'Go to next buffer' },
      { '<Leader>b', group = 'Buffer operations' },
      {
        '<Leader>bP',
        '<CMD>BufferPickDelete<CR>',
        desc = 'Delete buffer [P]icker (enter jump-mode)',
      },
      { '<Leader>bd', '<CMD>BufferDelete<CR>',  desc = '[D]elete current buffer' },
      {
        '<Leader>bD',
        '<CMD>BufferCloseAllButCurrent<CR>',
        desc = '[D]elete all but current buffer',
      },
      { '<Leader>bl', tbuiltin.buffers,         desc = 'List opened [B]uffers (Telescope)' },
      { '<Leader>bp', '<CMD>BufferPick<CR>',    desc = 'Buffer [P]icker (enter jump-mode)' },
      { '<Leader>br', '<CMD>BufferRestore<CR>', desc = '[R]estore last deleted/closed buffer' },
    },
  })
end

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'folke/which-key.nvim',
    'lewis6991/gitsigns.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
  },
  config = config,
}
