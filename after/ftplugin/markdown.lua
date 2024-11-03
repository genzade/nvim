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

which_key.add({
  {
    mode = { 'n' },
    { '<Leader>m', buffer = vim.api.nvim_get_current_buf(), group = 'Markdown', remap = false },
    {
      '<Leader>mp',
      function()
        vim.cmd.MarkdownPreview()
      end,
      buffer = vim.api.nvim_get_current_buf(),
      desc = 'Open [M]arkdown[P]review',
      remap = false,
    },
  },
})
