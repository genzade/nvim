-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = genzade.augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Run resize methods when window size is changed
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Run resize methods when window size is changes',
  group = genzade.augroup('resize_window'),
  callback = function()
    vim.cmd.wincmd('=')
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to last location when opening a buffer',
  group = genzade.augroup('last_location'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with `q`, add more filetypes as needed
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close some filetypes with `q`',
  group = genzade.augroup('quick_close'),
  pattern = {
    'checkhealth',
    'help',
    'notify',
    'qf',
    'notes',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = event.buf, silent = true })
  end,
})

local numbertoggle_augroup = genzade.augroup('numbertoggle')

vim.api.nvim_create_autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' },
  {
    pattern = '*',
    group = numbertoggle_augroup,
    callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
        vim.opt.relativenumber = true
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' },
  {
    pattern = '*',
    group = numbertoggle_augroup,
    callback = function()
      if vim.o.nu then
        vim.opt.relativenumber = false
        vim.cmd.redraw()
      end
    end,
  }
)

vim.api.nvim_create_autocmd('WinEnter', {
  desc = 'Resize windows back to default when moving from a zoomed window',
  callback = function()
    if vim.t.toggle_zoom then
      vim.cmd.wincmd('=')
      vim.t.toggle_zoom = false
    end
  end,
})
