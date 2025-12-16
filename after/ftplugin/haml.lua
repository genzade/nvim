local function is_binding_line(line)
  return string.match(line, 'pry') or string.match(line, 'binding.pry')
end

local function add_binding()
  local pos = vim.api.nvim_win_get_cursor(0)
  local cur_line = vim.api.nvim_get_current_line()
  local indent = cur_line:match('^%s*') or ''
  local text = indent .. '- binding.pry'
  vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[1] - 1, true, { text })
  vim.cmd('silent! write') -- Save the file silently
end

local function remove_bindings()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local new_lines = vim.tbl_filter(function(line)
    return not is_binding_line(line)
  end, lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, true, new_lines)
  vim.cmd('silent! write') -- Save the file silently
end

local wk_ok, wk = pcall(require, 'which-key')
if not wk_ok then
  return
end

wk.add({
  {
    mode = { 'n' },
    {
      '<Leader>k',
      add_binding,
      desc = 'Add pry breakpoint',
      buffer = true,
      remap = false,
    },
    {
      '<Leader>K',
      remove_bindings,
      desc = 'Remove all pry breakpoint',
      buffer = true,
      remap = false,
    },
  },
})
