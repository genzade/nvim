local opt = vim.opt_local
local o = vim.o

o.wrap = true
o.linebreak = true
opt.spell = true

-- Allow j/k when navigating wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

local which_key_ok, which_key = pcall(require, 'which-key')
if not which_key_ok then
  return
end

which_key.register({
  ['<Leader>'] = {
    m = {
      name = '+Markdown',
      p = {
        function()
          vim.cmd.MarkdownPreview()
        end,
        'Open [M]arkdown[P]review',
      },
    },
  },
}, {
  buffer = vim.api.nvim_get_current_buf(),
  mode = 'n',
  noremap = true,
  silent = true,
})

-- vim.keymap.set('n', '<Leader>mp', function()
--   vim.cmd.MarkdownPreview()
-- end, { noremap = true, buffer = true, desc = 'Open [M]arkdown[P]review' })
