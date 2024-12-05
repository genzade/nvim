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

autocmd({ 'BufEnter', 'ModeChanged' }, {
  callback = function()
    -- not needed in NvimTree
    if vim.bo.filetype == 'NvimTree' then
      return
    end

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

-- Remove items from quickfix list.
-- `dd` to delete in Normal
-- `d` to delete Visual selection
local function delete_qf_items()
  local mode = vim.api.nvim_get_mode()['mode']

  local start_idx
  local count

  if mode == 'n' then
    -- Normal mode
    start_idx = vim.fn.line('.')
    count = vim.v.count > 0 and vim.v.count or 1
  else
    -- Visual mode
    local v_start_idx = vim.fn.line('v')
    local v_end_idx = vim.fn.line('.')

    start_idx = math.min(v_start_idx, v_end_idx)
    count = math.abs(v_end_idx - v_start_idx) + 1

    -- Go back to normal
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(
        '<esc>', -- what to escape
        true, -- Vim leftovers
        false, -- Also replace `<lt>`?
        true -- Replace keycodes (like `<esc>`)?
      ),
      'x', -- Mode flag
      false -- Should be false, since we already `nvim_replace_termcodes()`
    )
  end

  local qflist = vim.fn.getqflist()

  for _ = 1, count, 1 do
    table.remove(qflist, start_idx)
  end

  vim.fn.setqflist(qflist, 'r')
  vim.fn.cursor(start_idx, 1)
end

autocmd('FileType', {
  group = augroup('custom'),
  pattern = 'qf',
  callback = function()
    -- Do not show quickfix in buffer lists.
    vim.api.nvim_buf_set_option(0, 'buflisted', false)

    -- Escape closes quickfix window.
    vim.keymap.set('n', '<ESC>', function()
      return vim.cmd.cclose()
    end, { buffer = true, remap = false, silent = true })

    -- `dd` deletes an item from the list.
    vim.keymap.set('n', 'dd', delete_qf_items, { buffer = true })
    vim.keymap.set('x', 'd', delete_qf_items, { buffer = true })
  end,
  desc = 'Quickfix tweaks',
})

local numbertoggle_augroup = augroup('numbertoggle')

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = '*',
  group = numbertoggle_augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = numbertoggle_augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd.redraw()
    end
  end,
})
