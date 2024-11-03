local config = function()
  local ruby_projections = require('genzade.plugins.projectionist.projections.ruby')
  -- have a look at https://github.com/veezus/clean-living/blob/24a4271a6c/.projections.json
  local javascript_projections = require('genzade.plugins.projectionist.projections.javascript')

  vim.g.projectionist_heuristics = {
    -- Rails
    ['Gemfile&config/boot.rb&config/application.rb'] = ruby_projections.ruby_on_rails,
    -- Generic ruby project
    ['Gemfile&!config/boot.rb&!spec/rails_helper.rb'] = ruby_projections.ruby_generic,
    -- Generic javascript project with jest
    ['package.json&jest.config.js'] = javascript_projections.javascript_generic,
  }

  local which_key_ok, which_key = pcall(require, 'which-key')
  if not which_key_ok then
    return
  end

  which_key.add({
    { '<Leader>a', group = 'Projectionist' },
    { '<Leader>aa', '<CMD>A<CR>', desc = 'Open [A]lternate file' },
    { '<Leader>as', '<CMD>AS<CR>', desc = 'Open alternate file ([S]plit hor)' },
    { '<Leader>at', '<CMD>AT<CR>', desc = 'Open alternate file (new [T]ab)' },
    { '<Leader>av', '<CMD>AV<CR>', desc = 'Open alternate file (split [V]ert)' },
  })
end

return {
  'tpope/vim-projectionist',
  dependencies = { 'folke/which-key.nvim' },
  config = config,
}
