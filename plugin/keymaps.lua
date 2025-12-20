vim.t.toggle_zoom = false
vim.keymap.set('n', '<leader>z', function()
  if vim.t.toggle_zoom then
    vim.cmd.wincmd('=')
  else
    vim.cmd.wincmd('_')
    vim.cmd.wincmd('|')
  end
  vim.t.toggle_zoom = not vim.t.toggle_zoom
end, { desc = 'Toggle [Z]oom window splits' })

vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, ':', ';', { noremap = true })
vim.keymap.set('n', '<ESC>', function()
  vim.cmd.nohlsearch()
end, { noremap = true })

vim.keymap.set('n', 'tn', vim.cmd.tabnext, { desc = 'Go to [N]ext [T]ab' }) -- gt  - go to next tab
vim.keymap.set('n', 'tp', vim.cmd.tabprevious, { desc = 'Go to [P]revious [T]ab' }) -- gT  - go to previous tab
vim.keymap.set('n', 'tf', vim.cmd.tabfirst, { desc = 'Go to [F]irst [T]ab' }) -- 1gt - go to first tab
vim.keymap.set('n', 'tl', vim.cmd.tablast, { desc = 'Go to [L]ast [T]ab' }) -- 1gT - go to last tab
vim.keymap.set('n', 'tx', vim.cmd.tabclose, { desc = '[C]lose [T]ab' })
vim.keymap.set('n', 'to', vim.cmd.tabonly, { desc = 'Close all [O]ther [T]abs' })
vim.keymap.set('n', 'tN', ':tabnew ', { noremap = true, silent = false, desc = '[N]ew [T]ab' })
vim.keymap.set('n', 'T', function()
  vim.cmd.tabnew('%')
end, {
  noremap = true,
  silent = true,
  desc = 'Open current file in [N]ew [T]ab',
})
-- something to consider
-- gt    -   go to next tab
-- gT    -   go to previous tab
-- {i}gt -   go to tab in position i
-- 1gt   -   go to first tab
-- 1gT   -   go to last tab

-- keep cursor position centred
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')

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
vim.keymap.set('n', 'cp', copy_path, { desc = '[C]opy file [P]ath to clipboard' })
vim.keymap.set('n', 'cP', function()
  copy_path(true)
end, { desc = '[C]opy full file [P]ath to clipboard' })

vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostic [Q]uickfix list' }
)

vim.keymap.set('n', '<leader>N', function()
  -- open an existing file called .notes.md in a floating window without overwriting
  local notes_path = vim.fn.getcwd() .. '/.notes.md'
  local buf = vim.fn.bufadd(notes_path)
  vim.fn.bufload(buf)
  local width = math.floor(vim.o.columns * 0.95)
  local height = math.floor(vim.o.lines * 0.95)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local opts = {
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
  }
  vim.api.nvim_open_win(buf, true, opts) -- open buffer in floating window
  vim.api.nvim_buf_set_option(buf, 'filetype', 'notes')
end, { desc = 'Open [N]otes in floating window' })
