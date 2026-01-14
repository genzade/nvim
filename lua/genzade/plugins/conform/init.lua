local config = function()
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end

  local function has_rubocop_binstub(ctx)
    return vim.fs.find({
      'bin/rubocop',
    }, {
      upward = true,
      path = ctx.dirname,
      stop = vim.fs.find({ '.git' }, { upward = true, path = ctx.dirname })[1],
    })[1] ~= nil
  end

  local stylua_config = vim.fn.stdpath('config') .. '/stylua.toml'
  -- local fmt_config = vim.fn.stdpath('config') .. '/lua/genzade/plugins/conform/fmt_configs/yamlfmt.yml'

  conform.setup({
    formatters_by_ft = {
      -- eruby = { 'erb_formatter', 'erb_lint' },
      -- dockerfile = { 'hadolint' },
      css = { 'prettierd' },
      html = { 'prettierd' },
      javascript = { 'standardjs' },
      json = { 'prettierd' },
      markdown = { 'prettierd' },
      -- scss = { 'standardjs' },
      scss = { 'prettierd' },
      sh = { 'shfmt' },
      zsh = { 'shfmt' },
      -- scss = { 'stylelint' },
      typescript = { 'prettierd' },
      ruby = { 'rubocop' },
      lua = { 'stylua' },
      terraform = { 'terraform_fmt' },
      -- yaml = { 'yamlfmt' },
    },
    formatters = {
      -- erb_formatter = {
      --   command = 'erb-format',
      --   args = { '--stdin' },
      -- },
      rubocop = {
        condition = function(_, ctx)
          if has_rubocop_binstub(ctx) then
            return true
          end

          -- Otherwise, only use rubocop when config file is present
          return vim.fs.find({
            '.rubocop.yml',
            '.rubocop.yaml',
            '.rubocop_todo.yml',
            '.rubocop_todo.yaml',
          }, {
            upward = true,
            path = ctx.dirname,
            stop = vim.fs.find({ '.git' }, { upward = true, path = ctx.dirname })[1],
          })[1] ~= nil
        end,
        --@param ctx conform.Context
        command = function(_, ctx)
          if has_rubocop_binstub(ctx) then
            return 'bin/rubocop'
          end

          return 'bundle'
        end,
        --@param ctx conform.Context
        args = function(_, ctx)
          if has_rubocop_binstub(ctx) then
            -- Use the binstub if it exists
            return { '--server', '-a', '-f', 'quiet', '--stderr', '--stdin', '$FILENAME' }
          end
          -- Otherwise, use the default rubocop command
          return {
            'exec',
            'rubocop',
            '--autocorrect',
            '--format',
            'quiet',
            '--stderr',
            '--stdin',
            '$FILENAME',
          }
        end,
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
end

vim.api.nvim_create_user_command('AutoFormatToggle', function()
  if not vim.b.disable_autoformat then
    vim.b.disable_autoformat = true
    vim.notify('Autoformat-on-save disabled on buffer', vim.log.levels.INFO, { title = 'Conform' })
    -- I rarely need to disable globally so I'm commenting this out
    -- elseif vim.b.disable_autoformat and not vim.g.disable_autoformat then
    --   vim.g.disable_autoformat = true
    --   vim.notify('Autoformat-on-save disabled globally', 'info', { title = 'Conform' })
  else
    -- vim.g.disable_autoformat = false
    vim.b.disable_autoformat = false
    vim.notify('Autoformat-on-save re-enabled', vim.log.levels.INFO, { title = 'Conform' })
  end
end, { desc = 'Toggle autoformat on save', bang = true })

vim.keymap.set('n', ',F', function()
  vim.cmd.AutoFormatToggle()
end, { desc = 'Toggle auto[F]ormat' })

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = config,
}
