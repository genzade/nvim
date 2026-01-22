return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = function()
    local ok, flash = pcall(require, 'flash')
    if not ok then
      return
    end

    return {
      { '<Leader>s', mode = { 'n', 'x', 'o' }, flash.jump, desc = 'Flash' },
      { '<Leader>S', mode = { 'n', 'x', 'o' }, flash.treesitter, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', flash.remote, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, flash.treesitter_search, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, flash.toggle, desc = 'Toggle Flash Search' },
    }
  end,
}
