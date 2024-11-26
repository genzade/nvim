local config = function()
  local defaults = require('genzade.plugins.lspconfig.defaults')
  local utils = require('genzade.core.utils')
  local augroup = utils.create_augroup
  local autocmd = utils.create_autocmd

  autocmd('LspAttach', {
    group = augroup('lsp_attach'),
    callback = function(event)
      defaults.setup_keymaps()

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight
          ) then
        local highlight_augroup = augroup('lsp_highlight', { clear = false })
        autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        autocmd('LspDetach', {
          group = augroup('lsp_detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'lsp_highlight', buffer = event2.buf })
          end,
        })
      end

      if client and
          client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map(',h', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  if vim.g.have_nerd_font then
    local diagnostic_signs = {}
    for sign_type, sign_icon in pairs(defaults.signs) do
      diagnostic_signs[vim.diagnostic.severity[sign_type]] = sign_icon
    end
    vim.diagnostic.config { signs = { text = diagnostic_signs } }
  end

  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if not cmp_nvim_lsp_ok then
    return
  end

  local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    cmp_nvim_lsp.default_capabilities()
  )

  local lspc_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspc_ok then
    return
  end

  -- Ensure the servers and tools from defaults (servers) are installed
  --  To check the current status of installed tools and/or manually install
  --  other tools, you can run
  --    :Mason
  --
  --  You can press `g?` for help in this menu.
  local mason_ok, mason = pcall(require, 'mason')
  if not mason_ok then
    return
  end

  mason.setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })

  -- You can add other tools here that you want Mason to install
  -- for you, so that they are available from within Neovim.
  local ensure_installed = vim.tbl_keys(defaults.servers() or {})
  vim.list_extend(ensure_installed, {
    'erb-lint',   -- Used to lint ERB files
    'haml-lint',  -- Used to lint HAML files
    'hadolint',   -- Used to lint Dockerfiles
    'rubocop',    -- Used to lint Ruby files -- NOTE: Already included in asdf/.default-gems
    'shellcheck', -- Used to lint shell scripts
    'stylua',     -- Used to format Lua code
    -- 'yamllint', -- Used to lint YAML files -- NOTE: need to add python3 to path
  })

  local mason_installer_ok, mason_installer = pcall(require, 'mason-tool-installer')
  if not mason_installer_ok then
    return
  end
  mason_installer.setup({ ensure_installed = ensure_installed })

  local mason_lspc_ok, mason_lspc = pcall(require, 'mason-lspconfig')
  if not mason_lspc_ok then
    return
  end

  mason_lspc.setup({
    handlers = {
      function(server_name)
        local server = defaults.servers()[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for ts_ls)
        server.capabilities = vim.tbl_deep_extend(
          'force',
          {},
          capabilities,
          server.capabilities or {}
        )
        lspconfig[server_name].setup(server)
      end,
    },
  })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'hrsh7th/cmp-nvim-lsp',
    'b0o/schemastore.nvim',
    {
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      config = function()
        require("lsp_lines").setup()
        -- Disable virtual_text since it's redundant due to lsp_lines.
        vim.diagnostic.config({
          virtual_text = false,
        })

        -- -- https://github.com/folke/lazy.nvim/issues/620
        -- vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns)
      end,
    },
    { 'folke/lazydev.nvim', ft = 'lua' },
  },
  config = config,
}
