return {
  'echasnovski/mini.indentscope',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    draw = {
      delay = 25,
      priority = 2,
    },
    options = {
      try_as_border = false,
      try_as_border_hl = true,
    },
    symbol = '│',
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Disable mini.indentscope for certain file types',
      group = genzade.augroup('mini_indentscope_disable_filetypes'),
      pattern = {
        'ftm',
        'NvimTree',
        'copilot-chat',
        'dashboard',
        'git',
        'gitcommit',
        'help',
        'lazy',
        'lspinfo',
        'markdown',
        'mason',
        'notify',
        'startup',
        'txt',
        '', -- for all buffers without a file type
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
