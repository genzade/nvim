local opt = vim.opt_local
local o = vim.o

o.wrap = true
o.linebreak = true
opt.spell = true

-- Allow j/k when navigating wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

local wk_ok, wk = pcall(require, 'which-key')
if not wk_ok then
  return
end

wk.add({
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
