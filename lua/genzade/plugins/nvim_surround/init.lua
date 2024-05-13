local config = function()
  local ok, nvim_surround = pcall(require, 'nvim-surround')
  if not ok then
    return
  end

  nvim_surround.setup({
    keymaps = { visual = 's' },
    move_cursor = false,
    highlight = { duration = 5000 },
  })
end

return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  version = '*',
  config = config,
}
