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
      { '<Leader>b', group = 'Buffers' },
      { '<Leader>x', vim.cmd.BufferClose, desc = 'Close the buffer' },
      { '<C-TAB>', vim.cmd.BufferPrevious, desc = 'Go to previous buffer' },
      { '<S-TAB>', vim.cmd.BufferNext, desc = 'Go to next buffer' },
      { '<Leader>bP', vim.cmd.BufferPickDelete, desc = 'Delete buffer [P]icker (jump-mode)' },
      { '<Leader>bd', vim.cmd.BufferDelete, desc = '[D]elete current buffer' },
      { '<Leader>bD', vim.cmd.BufferCloseAllButCurrent, desc = '[D]elete all but current buffer' },
      { '<Leader>bl', tbuiltin.buffers, desc = 'List opened [B]uffers (Telescope)' },
      { '<Leader>bp', vim.cmd.BufferPick, desc = 'Buffer [P]icker (enter jump-mode)' },
      { '<Leader>br', vim.cmd.BufferRestore, desc = '[R]estore last deleted/closed buffer' },
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
