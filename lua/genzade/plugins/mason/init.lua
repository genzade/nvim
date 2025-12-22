local config = function()
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

  local signs = { ERROR = '', HINT = '', INFO = '', WARN = '' }
  if vim.g.have_nerd_font then
    local diagnostic_signs = {}
    for sign_type, sign_icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[sign_type]] = sign_icon
    end
    vim.diagnostic.config({ signs = { text = diagnostic_signs } })
  end

  local mason_installer_ok, mason_installer = pcall(require, 'mason-tool-installer')
  if not mason_installer_ok then
    return
  end

  local ensure_installed = {
    -- 'clangd',
    'lua-language-server',
    'ruby-lsp',
    -- 'rust_analyzer',
    -- 'erb-formatter', -- Used to format ERB files
    -- 'erb-lint', -- Used to lint ERB files
    'eslint_d', -- Used to lint JavaScript and TypeScript files
    'hadolint', -- Used to lint Dockerfiles
    'haml-lint', -- Used to lint HAML files
    'htmlhint', -- Used to lint HTML files
    'jsonlint', -- Used to lint JSON files
    'markdownlint', -- Used to lint Markdown files
    'rubocop', -- Used to lint Ruby files -- NOTE: Already included in asdf/.default-gems
    'shellcheck', -- Used to lint shell scripts
    -- 'standardjs', -- Used to format JavaScript, TypeScript, JSON, CSS, SCSS, HTML, and Markdown files
    'stylelint', -- Used to lint CSS and SCSS files
    'stylua', -- Used to format Lua code
    -- 'yamlfmt', -- Used to format YAML files
  }

  mason_installer.setup({ ensure_installed = ensure_installed })
end

return {
  'mason-org/mason.nvim',
  opts = {},
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = config,
  -- enabled = false,
}
