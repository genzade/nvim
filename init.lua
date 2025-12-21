_G.genzade = {}

function genzade.augroup(name, opts)
  return vim.api.nvim_create_augroup('genzade_' .. name, { clear = opts and opts.clear or true })
end

vim.opt.termguicolors = true -- Enable true color support, must be set before colorscheme

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.completeopt = 'menu,menuone,noselect,noinsert,popup'

-- local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   local out =
--     vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })

--   if vim.v.shell_error ~= 0 then
--     vim.api.nvim_echo({
--       { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
--       { out, 'WarningMsg' },
--       { '\nPress any key to exit...' },
--     }, true, {})
--     vim.fn.getchar()
--     os.exit(1)
--   end
-- end

-- vim.opt.rtp:prepend(lazypath)

-- -- considerations
-- -- https://github.com/stevearc/aerial.nvim

-- -- Setup lazy.nvim
-- require('lazy').setup({
--   spec = {
--     { import = 'genzade/plugins' },
--   },
--   ui = { border = 'rounded' },
-- })

local modules = { 'core', 'lazy' }

for _, module in ipairs(modules) do
  require('genzade' .. '.' .. module).setup()
end
