local config = function()
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end

  local stylua_config = vim.fn.stdpath('config') .. '/stylua.toml'
  -- local fmt_config = vim.fn.stdpath('config') .. '/lua/genzade/plugins/conform/fmt_configs/yamlfmt.yml'

  conform.setup({
    formatters_by_ft = {
      -- -- erb
      -- eruby = { 'erb_formatter', 'erb_lint' },
      -- -- hadolint
      -- dockerfile = { 'hadolint' },
      -- -- prettierd
      -- css = { 'prettierd' },
      -- html = { 'prettierd' },
      -- javascript = { 'standardjs' },
      -- json = { 'prettierd' },
      -- markdown = { 'prettierd' },
      -- scss = { 'prettierd' },
      -- typescript = { 'prettierd' },
      -- rubocop
      ruby = { 'rubocop' },
      -- stylua
      lua = { 'stylua' },
      -- yamlfmt
      -- yaml = { 'yamlfmt' },
    },
    formatters = {
      -- erb_formatter = {
      --   command = 'erb-format',
      --   args = { '--stdin' },
      -- },
      rubocop = {
        -- cwd = require("conform.util").root_file({ ".rubocop.yml", "Gemfile" }),
        command = './bin/bundle',
        args = {
          'exec',
          'rubocop',
          '--autocorrect',
          '--stdin',
          '$FILENAME', -- current filename to format
          '--format',
          'emacs', -- emacs format is easy for tools to parse, can also use "json"
          '--stderr', -- Sends non-code output (warnings, errors) to stderr
        },
        stdin = true,
        cwd = require('conform.util').root_file({ 'Gemfile', '.rubocop.yml' }),
        -- https://github.com/faun/dotfiles/blob/166803fa556b799a5433a331006e02c6ff321c1f/config/nvim/lua/plugins/formatting.lua#L17
      },
      stylua = {
        prepend_args = { '--config-path', vim.fn.expand(stylua_config) },
      },
      -- yamlfmt = {
      --   prepend_args = { '-conf', vim.fn.expand(fmt_config) },
      -- },
    },

    -- format_on_save = function(bufnr)
    --   -- Disable with a global or buffer-local variable
    --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    --     return
    --   end

    --   return {
    --     -- async = true,
    --     lsp_fallback = true,
    --     timeout_ms = 1000,
    --   }
    -- end,
    format_after_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        lsp_fallback = true,
        timeout_ms = 500,
      }
    end,
  })

  vim.api.nvim_create_user_command('AutoFormatToggle', function()
    if not vim.b.disable_autoformat then
      vim.b.disable_autoformat = true
      vim.notify('Autoformat-on-save disabled on buffer', { title = 'Conform' })
      -- I rarely need to disable globally so I'm commenting this out
      -- elseif vim.b.disable_autoformat and not vim.g.disable_autoformat then
      --   vim.g.disable_autoformat = true
      --   vim.notify('Autoformat-on-save disabled globally', 'info', { title = 'Conform' })
    else
      -- vim.g.disable_autoformat = false
      vim.b.disable_autoformat = false
      vim.notify('Autoformat-on-save re-enabled', { title = 'Conform' })
    end
  end, { desc = 'Toggle autoformat on save', bang = true })

  vim.keymap.set('n', ',F', function()
    vim.cmd.AutoFormatToggle()
  end, { desc = 'Toggle auto[F]ormat' })
end

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = config,
}
