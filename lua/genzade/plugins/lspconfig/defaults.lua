local M = {}

M.setup_keymaps = function()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  local has_telescope_bltn, telescope_bltn = pcall(require, 'telescope.builtin')
  if not has_telescope_bltn then
    return
  end

  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end

  vim.api.nvim_create_user_command('AutoFormatToggle', function()
    if not vim.b.disable_autoformat then
      vim.b.disable_autoformat = true
      vim.notify('Autoformat-on-save disabled on buffer', 'info', { title = 'Conform' })
    -- I rarely need to disable globally so I'm commenting this out
    -- elseif vim.b.disable_autoformat and not vim.g.disable_autoformat then
    --   vim.g.disable_autoformat = true
    --   vim.notify('Autoformat-on-save disabled globally', 'info', { title = 'Conform' })
    else
      -- vim.g.disable_autoformat = false
      vim.b.disable_autoformat = false
      vim.notify('Autoformat-on-save re-enabled', 'info', { title = 'Conform' })
    end
  end, { desc = 'Toggle autoformat on save', bang = true })

  wk.add({
    {
      mode = { 'n' },
      { ',', group = 'LSP' },
      { ',D', telescope_bltn.lsp_type_definitions, desc = 'Type [D]efinition' },
      { ',ca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction' },
      { ',e', vim.diagnostic.open_float, desc = 'Op[E]n diagnostics' },
      -- { ',f',  vim.lsp.buf.format,                           desc = '[F]ormat file' },
      {
        ',F',
        function()
          vim.cmd.AutoFormatToggle()
        end,
        desc = 'Toggle auto[F]ormat',
      },
      { ',k', vim.lsp.buf.signature_help, desc = 'Signature help' },
      {
        ',q',
        vim.diagnostic.setloclist,
        desc = 'Create/replace location list for window',
      },
      { ',s', telescope_bltn.lsp_document_symbols, desc = 'Document [S]ymbols' },
      { ',rn', vim.lsp.buf.rename, desc = '[R]e[N]ame symbol' },
      { ',w', group = 'Workspace' },
      { ',wa', vim.lsp.buf.add_workspace_folder, desc = '[A]dd folder' },
      { ',ws', telescope_bltn.lsp_dynamic_workspace_symbols, desc = '[W]orkspace [S]ymbols' },
      {
        ',wl',
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = '[L]ist folders',
      },
      { ',wr', vim.lsp.buf.remove_workspace_folder, desc = '[R]emove folder' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { '[d', vim.diagnostic.goto_prev, desc = 'Previous [D]iagnostic' },
      { ']d', vim.diagnostic.goto_next, desc = 'Next [D]iagnostic' },
      { 'g', group = 'Goto' },
      { 'gD', vim.lsp.buf.declaration, desc = '[G]o to [D]eclaration' },
      { 'gd', telescope_bltn.lsp_definitions, desc = '[G]o to [D]efinition' },
      { 'gi', vim.lsp.buf.implementation, desc = '[G]o to [I]mplementation' },
      { 'gr', telescope_bltn.lsp_references, desc = '[G]o to [R]eferences' },
    },
    {
      mode = { 'n', 'v' },
      {
        ',f',
        function()
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          })
        end,
        desc = '[F]ormat file or range (VISUAL)',
      },
    },
  })
end

M.signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }

M.servers = function()
  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will
  --  automatically be installed.
  --
  --  Add any additional override configuration in the following tables.
  --  Available keys are:
  --  - cmd (table): Override the default command used to start the server
  --  - filetypes (table): Override the default list of associated filetypes
  --    for the server
  --  - capabilities (table): Override fields in capabilities. Can be used
  --    to disable certain LSP features.
  --  - settings (table): Override the default settings passed when initializing
  --    the server.
  --        For example, to see the options for `lua_ls`,
  --        you could go to: https://luals.github.io/wiki/settings/

  local schemastore_ok, schemastore = pcall(require, 'schemastore')
  if not schemastore_ok then
    return
  end

  return {
    bashls = {
      filetypes = { 'sh', 'zsh' },
    },
    clangd = {
      init_options = { clangdFileStatus = true },
      filetypes = { 'c' },
    },
    cssls = {
      server_capabilities = {
        documentFormattingProvider = false,
      },
    },
    dockerls = {},
    html = {},
    jsonls = {
      server_capabilities = {
        documentFormattingProvider = false,
      },
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
          diagnostics = { globals = { 'vim' } },
        },
      },
    },
    solargraph = {
      fileTypes = { 'ruby', 'erb', 'eruby', 'haml' },
      -- settings = {
      --   diagnostics = true,
      --   completion = true,
      --   formatting = true,
      -- },
    },
    tailwindcss = {
      init_options = {
        userLanguages = {
          eruby = 'erb',
        },
      },
      filetypes = {
        -- html
        'erb',
        'eruby', -- vim ft
        'haml',
        'handlebars',
        'hbs',
        'html',
        'liquid',
        'markdown',
        'mustache',
        'slim',
        -- css
        'css',
        'postcss',
        'sass',
        'scss',
        -- js
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        -- mixed
        'vue',
        'svelte',
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { 'class: ?"([^"]*)"', '([a-zA-Z0-9\\-:]+)' },
              { '(\\.[\\w\\-.]+)[\\n\\=\\{\\s]', '([\\w\\-]+)' },
            },
          },
          includeLanguages = {
            haml = 'html',
          },
        },
      },
    },
    taplo = {}, -- TOML
    terraformls = {},
    ts_ls = {
      root_dir = require('lspconfig').util.root_pattern('package.json'),
      single_file = false,
      server_capabilities = {
        documentFormattingProvider = false,
      },
    },
    yamlls = {
      settings = {
        yaml = {
          -- schemaStore = {
          --   enable = false,
          --   url = "",
          -- },
          schemas = schemastore.yaml.schemas(),
        },
      },
    },
  }
end

return M
