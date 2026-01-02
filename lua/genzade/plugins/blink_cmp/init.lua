return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdLineEnter' },
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false }, menu = { border = 'rounded' } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'prefer_rust' },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { ghost_text = { enabled = true }, menu = { auto_show = true } },
    },
  },
  opts_extend = { 'sources.default' },
  init = function()
    local capabilities =
      require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
    vim.lsp.config('*', { capabilities = capabilities })
  end,
}
