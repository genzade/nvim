local config = function()
  local ok, nvim_lint = pcall(require, 'lint')
  if not ok then
    return
  end

  nvim_lint.linters_by_ft = {
    typescript = { 'eslint_d' },
    javascript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },

    html = { 'htmlhint' },

    css = { 'stylelint' },
    sass = { 'stylelint' },
    scss = { 'stylelint' },

    json = { 'jsonlint' },

    markdown = { 'markdownlint' },

    eruby = { 'erb_lint' },
    -- haml = { 'haml-lint' },
    ruby = { 'rubocop' },

    sh = { 'shellcheck' },
    zsh = { 'shellcheck' },
  }

  local severity_map = {
    ['fatal'] = vim.diagnostic.severity.ERROR,
    ['error'] = vim.diagnostic.severity.ERROR,
    ['warning'] = vim.diagnostic.severity.WARN,
    ['convention'] = vim.diagnostic.severity.HINT,
    ['refactor'] = vim.diagnostic.severity.INFO,
    ['info'] = vim.diagnostic.severity.INFO,
  }

  -- nvim_lint.linters['haml-lint'] = {
  --   cmd = 'haml-lint',
  --   stdin = false,
  --   ignore_exitcode = true,
  --   args = { '--reporter', 'json' },
  --   parser = function(output)
  --     local diagnostics = {}
  --     local decoded = vim.json.decode(output)

  --     if not decoded or not decoded.files or not decoded.files[1] then
  --       return diagnostics
  --     end

  --     local offences = decoded.files[1].offenses

  --     for _, off in pairs(offences) do
  --       table.insert(diagnostics, {
  --         source = 'haml-lint',
  --         lnum = off.location.line - 1,
  --         col = 0,
  --         end_lnum = off.location.line - 1,
  --         end_col = 0,
  --         severity = severity_map[off.severity],
  --         message = off.message,
  --         code = off.linter_name,
  --       })
  --     end

  --     return diagnostics
  --   end,
  -- }

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
  enabled = false,
}
