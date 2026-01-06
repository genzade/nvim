-- local config = function()
-- local defaults = require('genzade.plugins.lspconfig.defaults')
-- local utils = require('genzade.core.utils')
-- local autocmd = utils.create_autocmd

-- local capabilities = blink_cmp.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

-- -- You can add other tools here that you want Mason to install
-- -- for you, so that they are available from within Neovim.
-- local ensure_installed = vim.tbl_keys(defaults.servers() or {})
-- vim.list_extend(ensure_installed, {
--   'erb-lint', -- Used to lint ERB files
--   'erb-formatter', -- Used to format ERB files
--   'eslint_d', -- Used to lint JavaScript and TypeScript files
--   'haml-lint', -- Used to lint HAML files
--   'hadolint', -- Used to lint Dockerfiles
--   'jsonlint', -- Used to lint JSON files
--   'standardjs', -- Used to format JavaScript, TypeScript, JSON, CSS, SCSS, HTML, and Markdown files
--   'rubocop', -- Used to lint Ruby files -- NOTE: Already included in asdf/.default-gems
--   'markdownlint', -- Used to lint Markdown files
--   'shellcheck', -- Used to lint shell scripts
--   'stylelint', -- Used to lint CSS and SCSS files
--   'stylua', -- Used to format Lua code
--   'htmlhint', -- Used to lint HTML files
--   'yamlfmt', -- Used to format YAML files
--   -- 'yamllint', -- Used to lint YAML files -- NOTE: need to add python3 to path
-- })

local config = {
  lsp = {
    servers = {
      'bashls',
      'cssls',
      'docker_compose_language_service',
      'dockerls',
      'lua_ls',
      'ruby_lsp',
      'terraformls',
      'yamlls',
    },
    formatters = {
      'prettierd',
      'shfmt',
      'standardjs',
      'stylua',
      'terraform',
    },
    linters = {
      'rubocop',
      'shellcheck',
      'stylelint',
    },
  },
}

return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = config.lsp.servers,
      automatic_enable = {
        exclude = { 'rubocop', 'shfmt', 'shellcheck' },
      },
    },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      {
        'neovim/nvim-lspconfig',
        dependencies = {
          'creativenull/efmls-configs-nvim',
        },
        init = function()
          local signs = { ERROR = '', HINT = '', INFO = '', WARN = '' }
          if vim.g.have_nerd_font then
            local diagnostic_signs = {}
            for sign_type, sign_icon in pairs(signs) do
              diagnostic_signs[vim.diagnostic.severity[sign_type]] = sign_icon
            end
            vim.diagnostic.config({ signs = { text = diagnostic_signs } })
          end

          vim.api.nvim_create_autocmd('CursorHold', {
            callback = function()
              vim.diagnostic.open_float(nil, {
                focus = false,
              })
            end,
          })

          vim.api.nvim_create_autocmd('LspAttach', {
            group = genzade.augroup('lsp_attach'),
            callback = function(event)
              -- The following two autocommands are used to highlight references of the
              -- word under your cursor when your cursor rests there for a little while.
              --    See `:help CursorHold` for information about when this is executed
              --
              -- When you move your cursor, the highlights will be cleared (the second autocommand).
              local client = vim.lsp.get_client_by_id(event.data.client_id)
              if
                client
                and client:supports_method(
                  vim.lsp.protocol.Methods.textDocument_documentHighlight,
                  event.buf
                )
              then
                local highlight_augroup = genzade.augroup('lsp_highlight', { clear = false })
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                  group = genzade.augroup('lsp_detach', { clear = true }),
                  callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({
                      group = 'genzade_lsp_highlight',
                      buffer = event2.buf,
                    })
                  end,
                })
              end

              if
                client
                and client:supports_method(
                  vim.lsp.protocol.Methods.textDocument_inlayHint,
                  event.buf
                )
              then
                local map = function(keys, func, desc, mode)
                  mode = mode or 'n'
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                end

                map(',h', function()
                  vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                  )
                end, '[T]oggle Inlay [H]ints')
              end
            end,
          })

          vim.lsp.config.lua_ls = {
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
        end,
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = vim
        .iter({ config.lsp.formatters, config.lsp.linters })
        :flatten()
        :totable(),
    },
  },
}
