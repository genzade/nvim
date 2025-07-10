local defaults = require('genzade.plugins.mini_files.defaults')

return {
  'echasnovski/mini.files',
  version = '*',
  opts = defaults.opts,
  keys = defaults.keys,
  init = function()
    local utils = require('genzade.core.utils')
    local autocmd = utils.create_autocmd
    local augroup = utils.create_augroup

    autocmd('User', {
      desc = 'Add minifiles split keymaps',
      group = augroup('mini_files_split_keymaps'),
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        defaults.map_split(buf_id, '<C-v>', 'vsplit', true)
        defaults.map_split(buf_id, '<C-s>', 'split', true)
        defaults.map_split(buf_id, '|', 'vsplit', false)
        defaults.map_split(buf_id, '\\', 'split', false)
      end,
    })
  end,
}
