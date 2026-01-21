return {
  'genzade/ftm.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {},
  config = function()
    local ok, ftm = pcall(require, 'ftm')
    if not ok then
      return
    end

    vim.keymap.set({ 'n', 't' }, '<C-t>', function()
      ftm.toggle({ name = 'Main' })
    end, { desc = 'Toggle built in [T]erminal' })

    vim.keymap.set({ 'n', 't' }, '\\r', function()
      ftm.toggle({
        name = 'PRY console',
        cmd = 'pry',
      })
    end, { desc = 'Toggle [R]uby PRY repl' })

    vim.keymap.set({ 'n', 't' }, '\\g', function()
      ftm.toggle({
        name = 'Lazygit',
        cmd = 'lazygit',
      })
    end, { desc = 'Toggle Lazy[G]it' })

    vim.keymap.set('t', '<C-x>', function()
      ftm.close_all()
    end, { desc = 'Close any open terminal' })
  end,
}
