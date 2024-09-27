local config = function()
  local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_status_ok then
    return
  end

  require('luasnip.loaders.from_vscode').lazy_load()

  luasnip.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
  })

  luasnip.filetype_extend('ruby', { 'rails' })
end

return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*',
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = config,
}
