local config = function()
  local ok, neoclip = pcall(require, 'neoclip')
  if not ok then
    return
  end

  neoclip.setup({
    initial_mode = 'normal',
  })
end

return {
  'AckslD/nvim-neoclip.lua',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = config,
}
