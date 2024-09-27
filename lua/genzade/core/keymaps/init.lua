-- TODO: use which-key here
-- Keymaps
-- Leader
local map = vim.keymap.set

map('n', '<Space>', '<NOP>')

vim.g.mapleader = ' '
vim.g.loaded_ruby_provider = 0

-- No more shift. one less keystroke
-- map({ 'n', 'v' }, ';', ':', { noremap = true })
map({ 'n', 'v' }, ';', ':')
map({ 'n', 'v' }, ':', ';', { noremap = true })

-- Remove highlight search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Tab navigation
map('n', 'tn', vim.cmd.tabnext, { desc = 'Go to [N]ext [T]ab' })
map('n', 'tp', vim.cmd.tabprevious, { desc = 'Go to [P]revious [T]ab' })
map('n', 'tl', vim.cmd.tablast, { desc = 'Go to [L]ast [T]ab' })
map('n', 'tf', vim.cmd.tabfirst, { desc = 'Go to [F]irst [T]ab' })
map('n', 'tx', vim.cmd.tabclose, { desc = '[C]lose [T]ab' })
map('n', 'to', vim.cmd.tabonly, { desc = 'Close all [O]ther [T]abs' })
map('n', 'tN', ':tabnew ', { noremap = true, silent = false, desc = '[N]ew [T]ab' })
map(
  'n',
  'T',
  ':tabnew %<CR>',
  { noremap = true, silent = true, desc = 'Open current file in [N]ew [T]ab' }
)

-- something to consider
-- gt    -   go to next tab
-- gT    -   go to previous tab
-- {i}gt -   go to tab in position i
-- 1gt   -   go to first tab
-- 1gT   -   go to last tab

local function copy_path(full)
  full = full or false

  local path

  if not full then
    path = vim.fn.expand('%')
  else
    path = vim.fn.expand('%:p')
  end

  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end

-- -- copy filename to clipboard
map('n', 'cp', copy_path, { desc = '[C]opy file [P]ath to clipboard' })
map('n', 'cP', function()
  copy_path(true)
end, { desc = '[C]opy full file [P]ath to clipboard' })

-- close all buffers but current
map('n', '<leader>bd', function()
  -- vim.cmd('bd|e#')
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if buf ~= vim.api.nvim_get_current_buf() then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = '[B]uffer [D]elete' })

-- keep cursor position centred
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')
