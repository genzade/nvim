local config = function()
  local default_length = 100

  vim.g['overlength#default_overlength'] = 0 -- disable everywhere
  vim.g['overlength#highlight_to_end_of_line'] = false

  local ol_filetype_config = {
    css = default_length,
    haml = 120,
    html = 120,
    javascript = default_length,
    lua = default_length,
    markdown = default_length,
    ruby = default_length,
    scss = default_length,
    sh = default_length,
  }

  for ft, length in pairs(ol_filetype_config) do
    vim.fn['overlength#set_overlength'](ft, length)
  end
end

return { 'tjdevries/overlength.vim', config = config }
