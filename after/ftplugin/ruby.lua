vim.cmd.compiler('ruby')

local opt = vim.opt_local

-- Include more chars when deleting words
opt.iskeyword:append('?')
opt.iskeyword:append('!')
opt.iskeyword:append('$')

local function start_of_line(line)
  local stripped = string.gsub(line, '^%s*(.-)$', '%1')
  return string.len(line) - string.len(stripped)
end

local function is_binding_line(line)
  return string.match(line, 'pry') or string.match(line, 'binding.pry')
end

local function add_binding()
  local pos = vim.api.nvim_win_get_cursor(0)
  local cur_line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], true)[1]
  local start = start_of_line(cur_line)
  local text = string.rep(' ', start) .. "require 'pry'; binding.pry"
  vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[1] - 1, true, { text })
end

local function remove_bindings()
  local deleted_count = 0
  for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, true)) do
    if is_binding_line(line) then
      vim.api.nvim_buf_set_lines(0, i - 1 - deleted_count, i - deleted_count, false, {})
      deleted_count = deleted_count + 1
    end
  end
end

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<Leader>9', add_binding, opts, { desc = 'Add pry debugger statement' })
vim.keymap.set(
  'n',
  '<Leader>0',
  remove_bindings,
  opts,
  { desc = 'Remove all pry debugger statement' }
)

----Surround
local ok, nvim_surround = pcall(require, 'nvim-surround')
if not ok then
  return
end

---@diagnostic disable-next-line: missing-fields
nvim_surround.buffer_setup({
  surrounds = {
    ---@diagnostic disable-next-line: missing-fields
    ['#'] = {
      add = { '#{', '}' },
      find = '(#{)[^}]-(})',
      delete = '(#{)()[^}]-(})()',
    },
  },
})
