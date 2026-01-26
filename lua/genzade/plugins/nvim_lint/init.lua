local config = function()
  local ok, nvim_lint = pcall(require, 'lint')
  if not ok then
    return
  end

  nvim_lint.linters_by_ft = {
    -- typescript = { 'eslint_d' },
    -- javascript = { 'eslint_d' },
    -- typescriptreact = { 'eslint_d' },
    -- javascriptreact = { 'eslint_d' },

    -- html = { 'htmlhint' },

    css = { 'stylelint' },
    sass = { 'stylelint' },
    scss = { 'stylelint' },

    -- json = { 'jsonlint' },

    -- markdown = { 'markdownlint' },

    -- eruby = { 'erb_lint' },
    -- ruby = { 'rubocop' },

    sh = { 'shellcheck' },
    zsh = { 'shellcheck' },
  }

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
    group = genzade.augroup('auto_lint'),
    callback = function()
      nvim_lint.try_lint()
    end,
  })
end

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufWritePost' },
  config = config,
}
