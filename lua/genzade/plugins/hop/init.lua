local config = function()
  local hop_ok, hop = pcall(require, 'hop')
  if not hop_ok then
    return
  end

  hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

  local which_key_ok, which_key = pcall(require, 'which-key')
  if not which_key_ok then
    return
  end

  which_key.add({
    {
      mode = { 'n' },
      { '<Leader>s', group = 'Hop' },
      { '<Leader>sL', '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop anywhere [L]ine' },
      { '<Leader>sW', '<CMD>HopAnywhere<CR>', desc = 'Hop anywhere [W]indow' },
      { '<Leader>sl', '<CMD>HopWordCurrentLine<CR>', desc = 'Hop [L]ine' },
      { '<Leader>sw', '<CMD>HopWord<CR>', desc = 'Hop [W]indow' },
    },
    {
      mode = { 'v' },
      { '<Leader>s', group = 'Hop' },
      { '<Leader>sL', '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop anywhere [L]ine' },
      { '<Leader>sW', '<CMD>HopAnywhere<CR>', desc = 'Hop anywhere [W]indow' },
      { '<Leader>sl', '<CMD>HopWordCurrentLine<CR>', desc = 'Hop [L]ine' },
      { '<Leader>sw', '<CMD>HopWord<CR>', desc = 'Hop [W]indow' },
    },
    {
      mode = { 'o' },
      { '<Leader>s', group = 'Hop' },
      { '<Leader>sL', '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop anywhere [L]ine' },
      { '<Leader>sW', '<CMD>HopAnywhere<CR>', desc = 'Hop anywhere [W]indow' },
      { '<Leader>sl', '<CMD>HopWordCurrentLine<CR>', desc = 'Hop [L]ine' },
      { '<Leader>sw', '<CMD>HopWord<CR>', desc = 'Hop [W]indow' },
    },
  })
end

-- TODO: replace with flash.nvim

return {
  'phaazon/hop.nvim',
  branch = 'v2',
  dependencies = { 'folke/which-key.nvim' },
  config = config,
}
