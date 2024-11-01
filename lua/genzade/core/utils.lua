M = {}

M.create_augroup = function(name)
  return vim.api.nvim_create_augroup('genzade_' .. name, { clear = true })
end

M.sanitize_str = function(str)
  str = str:gsub('^%s*\n', '')

  -- Find the minimum leading whitespace
  local min_indent = nil
  for line in str:gmatch('([^\n]*)\n?') do
    local leading_spaces = line:match('^(%s*)')
    if #leading_spaces < #line then -- Ignore empty lines
      min_indent = min_indent and math.min(min_indent, #leading_spaces) or #leading_spaces
    end
  end

  -- Remove the common leading whitespace
  if min_indent then
    local pattern = string.rep(' ', min_indent)
    str = str:gsub('\n' .. pattern, '\n')
    str = str:gsub('^' .. pattern, '')
  end

  return str
end

return M
