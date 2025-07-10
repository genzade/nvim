local defaults = require('genzade.plugins.mini_indentscope.defaults')

return {
  'echasnovski/mini.indentscope',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = defaults.opts,
  init = function()
    local utils = require('genzade.core.utils')
    local autocmd = utils.create_autocmd
    local augroup = utils.create_augroup

    autocmd('FileType', {
      desc = 'Disable mini.indentscope for certain file types',
      group = augroup('mini_indentscope_disable_filetypes'),
      pattern = {
        'FTerm',
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
