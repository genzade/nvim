vim.cmd.compiler('ruby')

local opt = vim.opt_local

-- Include more chars when deleting words
opt.iskeyword:append('?')
opt.iskeyword:append('!')
opt.iskeyword:append('$')

local function is_binding_line(line)
  return string.match(line, 'pry') or string.match(line, 'binding.pry')
end

local function add_binding()
  local pos = vim.api.nvim_win_get_cursor(0)
  local cur_line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], true)[1]
  local indent = cur_line:match('^%s*') or ''
  local text = indent .. "require 'pry'; binding.pry"
  vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[1] - 1, true, { text })
end

local function remove_bindings()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local new_lines = {}
  for _, line in ipairs(lines) do
    if not is_binding_line(line) then
      table.insert(new_lines, line)
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, new_lines)
end

local opts = { silent = true, noremap = true }
vim.keymap.set(
  'n',
  '<Leader>k',
  add_binding,
  { desc = 'Add pry breakpoint', buffer = vim.api.nvim_get_current_buf() }
)
vim.keymap.set(
  'n',
  '<Leader>K',
  remove_bindings,
  opts,
  { desc = 'Remove all pry breakpoint', buffer = vim.api.nvim_get_current_buf() }
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
