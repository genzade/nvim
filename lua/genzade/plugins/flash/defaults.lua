local M = {}

M.keys = function()
  local flash_ok, flash = pcall(require, 'flash')
  if not flash_ok then
    return
  end

  return {
    {
      '<Leader>s',
      mode = { 'n', 'x', 'o' },
      function()
        flash.jump()
      end,
      desc = 'Flash'
    },
    {
      '<Leader>S',
      mode = { 'n', 'x', 'o' },
      function()
        flash.treesitter()
      end,
      desc = 'Flash Treesitter'
    },
    {
      'r',
      mode = 'o',
      function()
        flash.remote()
      end,
      desc = 'Remote Flash'
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        flash.treesitter_search()
      end,
      desc = 'Treesitter Search'
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        flash.toggle()
      end,
      desc = 'Toggle Flash Search'
    },
  }
end

return M
