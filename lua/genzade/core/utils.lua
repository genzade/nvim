M = {}

M.create_augroup = function(name, opts)
  return vim.api.nvim_create_augroup('genzade_' .. name, { clear = opts and opts.clear or true })
end

M.create_autocmd = function(...)
  return vim.api.nvim_create_autocmd(...)
end

M.sanitize_str = function(str)
  local indent = str:match('\n([ \t]*)%S')

  if not indent then
    return str
  end

  str = (str:gsub('\n' .. indent, '\n')):gsub('^%s+', '')

  return str
end

return M
