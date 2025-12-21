local config = function()
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end

  local stylua_config = vim.fn.stdpath('config') .. '/stylua.toml'
  -- local fmt_config = vim.fn.stdpath('config') .. '/lua/genzade/plugins/conform/fmt_configs/yamlfmt.yml'

  conform.setup({
    formatters_by_ft = {
      -- erb
      eruby = { 'erb_formatter', 'erb_lint' },
      -- hadolint
      dockerfile = { 'hadolint' },
      -- prettierd
      css = { 'prettierd' },
      html = { 'prettierd' },
      javascript = { 'standardjs' },
      json = { 'prettierd' },
      markdown = { 'prettierd' },
      scss = { 'prettierd' },
      typescript = { 'prettierd' },
      -- rubocop
      ruby = { 'rubocop' },
      -- stylua
      lua = { 'stylua' },
      -- yamlfmt
      yaml = { 'yamlfmt' },
    },
    formatters = {
      erb_formatter = {
        command = 'erb-format',
        args = { '--stdin' },
      },
      rubocop = {
        command = 'bin/rubocop',
      },
      stylua = {
        append_args = { '--config-path', vim.fn.expand(stylua_config) },
      },
      yamlfmt = {
        prepend_args = { '-conf', vim.fn.expand(fmt_config) },
      },
    },

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        async = false,
        lsp_fallback = true,
        timeout_ms = 500,
      }
    end,
  })
end

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = config,
}
