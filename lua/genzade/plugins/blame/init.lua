local config = function()
  local blame_ok, blame = pcall(require, 'blame')
  if not blame_ok then
    return
  end

  blame.setup({
    blame_opts = { '-w' },
    date_format = '%d/%m/%y',
  })
end

return {
  'FabijanZulj/blame.nvim',
  lazy = false,
  cmd = 'BlameToggle',
  config = config,
  keys = {
    {
      '<leader>B',
      function()
        vim.cmd('BlameToggle')
      end,
      desc = 'Toggle Git [B]lame',
    },
  },
}
