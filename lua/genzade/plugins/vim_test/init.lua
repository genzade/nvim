local config = function()
  local defaults = require('genzade.plugins.vim_test.defaults')
  local ftm_runner = defaults.ftm_runner
  local tmux_runner = defaults.tmux_runner
  local select_strategy = defaults.select_strategy
  local select_rspec_executable = defaults.select_rspec_executable

  vim.api.nvim_create_user_command('TestStrategySelect', select_strategy, { force = true })

  vim.api.nvim_set_var('test#custom_strategies', {
    ftm = ftm_runner,
    tmux = tmux_runner,
  })

  -- vim.g['test#strategy'] = 'ftm'
  vim.api.nvim_set_var('test#strategy', 'ftm')

  -- javascript
  vim.api.nvim_set_var('test#javascript#jest#executable', 'yarn jest')

  vim.api.nvim_create_user_command(
    'TestRSpecExecutableSelect',
    select_rspec_executable,
    { force = true }
  )

  -- ruby
  vim.api.nvim_set_var(
    'test#ruby#rspec#file_pattern',
    [[\v(_spec\.rb|_feature\.rb|spec/.*\.feature)$]]
  )

  -- vim.g["test#strategy"] = "ftm"
  -- vim.g["test#strategy"] = "dispatch"
  -- vim.g['test#strategy'] = 'neovim'
  -- vim.g['test#preserve_screen'] = 1

  -- vim.g['test#lua#runner'] = '/Users/genzade/.luarocks/bin/busted'
  -- vim.api.nvim_set_var('test#lua#busted#executable', '/Users/genzade/.luarocks/bin/busted')

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    {
      mode = { 'n' },
      { '<Leader>t', group = 'TestRunner' },
      { '<Leader>tS', '<CMD>TestStrategySelect<CR>', desc = 'Select test [S]trategy' },
      { '<Leader>tf', '<CMD>TestFile<CR>', desc = 'Run test [F]ile' },
      { '<Leader>tl', '<CMD>TestLast<CR>', desc = 'Run [L]ast test' },
      { '<Leader>tn', '<CMD>TestNearest<CR>', desc = 'Run [N]earest test' },
      { '<Leader>tr', '<CMD>TestRSpecExecutableSelect<CR>', desc = 'Select [R]Spec executable' },
      { '<Leader>ts', '<CMD>TestSuite<CR>', desc = 'Run test [S]uite' },
      { '<Leader>tv', '<CMD>TestVisit<CR>', desc = 'Run test [V]isit' },
    },
  })
end

return {
  'vim-test/vim-test',
  dependencies = { 'genzade/ftm.nvim', 'folke/which-key.nvim' },
  config = config,
}
