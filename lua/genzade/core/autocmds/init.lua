local utils = require('genzade.core.utils')
local augroup = utils.create_augroup
local autocmd = utils.create_autocmd

-- Highlight when yanking (copying) text
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Run resize methods when window size is changed
autocmd('VimResized', {
  desc = 'Run resize methods when window size is changes',
  group = augroup('resize_window'),
  callback = function()
    vim.cmd.wincmd('=')
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  desc = 'Go to last location when opening a buffer',
  group = augroup('last_location'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with `q`, add more filetypes as needed
autocmd('FileType', {
  desc = 'Close some filetypes with `q`',
  group = augroup('quick_close'),
  pattern = {
    'checkhealth',
    'help',
    'notify',
    'qf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = event.buf, silent = true })
  end,
})

-- Sets the current line's color based on the current mode
-- Equivalent to modicator but fast
local mode_hl_groups = {
  [''] = 'ModeVisual',
  v = 'ModeVisual',
  V = 'ModeVisual',
  ['\22'] = 'ModeVisual',
  n = 'ModeNormal',
  no = 'ModeNormal',
  i = 'ModeInsert',
  c = 'ModeCommand',
  s = 'ModeSelect',
  S = 'ModeSelect',
  R = 'ModeReplace',
  t = 'ModeTerminal',
  nt = 'ModeTerminal',
}
autocmd({ 'BufEnter', 'ModeChanged' }, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local mode_hl_group = mode_hl_groups[mode]
    if mode_hl_group == nil then
      mode_hl_group = mode_hl_groups['n']
    end
    local hl = vim.api.nvim_get_hl(0, { name = mode_hl_groups[mode], link = false })
    hl = vim.tbl_extend('force', { bold = true }, hl)
    vim.api.nvim_set_hl(0, 'CursorLineNr', hl)
  end,
})
