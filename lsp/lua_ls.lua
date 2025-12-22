return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }, -- Recognize 'vim' as a global variable
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Include Neovim runtime files
      },
      telemetry = {
        enable = false, -- Disable telemetry
      },
    },
  },
}

-- vim.lsp.config['lua_ls'] = {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = { '.luarc.json', '.luarc.jsonc' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       -- diagnostics = {
--       --   globals = { 'vim' }, -- Recognize 'vim' as a global variable
--       -- },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true), -- Include Neovim runtime files
--       },
--       telemetry = {
--         enable = false, -- Disable telemetry
--       },
--     },
--   },
-- }

-- vim.lsp.enable('lua_ls')
