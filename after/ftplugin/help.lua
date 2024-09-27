-- to enable syntax highlighting in help
vim.treesitter.start()

vim.keymap.set('n', 'q', '<CMD>bd<CR>', { silent = true, buffer = true })
