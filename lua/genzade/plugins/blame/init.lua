return {
  'FabijanZulj/blame.nvim',
  lazy = false,
  cmd = 'BlameToggle',
  opts = {
    blame_opts = { '-w' },
    date_format = '%d/%m/%y',
  },
  keys = {
    {
      '<leader>B',
      function()
        vim.cmd.BlameToggle()
      end,
      desc = 'Toggle Git [B]lame',
    },
  },
}
