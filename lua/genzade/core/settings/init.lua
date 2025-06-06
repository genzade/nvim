-- Settings
local o = vim.o
local opt = vim.opt
local g = vim.g
local bo = vim.bo
local wo = vim.wo
local set_var = vim.api.nvim_set_var

g.base16colorspace = 256
g.completeopt = 'menu,menuone,noselect,noinsert,popup'

o.splitbelow = true
o.splitright = true

wo.number = true
wo.relativenumber = true

wo.list = true
wo.listchars = 'trail:·'

o.tabstop = 2
bo.tabstop = 2

o.shiftwidth = 2
bo.shiftwidth = 2

o.expandtab = true
bo.expandtab = true

o.scrolloff = 10
wo.scrolloff = 10

wo.signcolumn = 'yes'

o.hidden = true

o.termguicolors = true
-- o.term = 'screen-256color'
-- vim.cmd('let $TERM="alacritty"')
-- o.background = 'dark'

o.cursorline = true

o.laststatus = 3

o.mouse = ''

-- Set highlight on search
o.hlsearch = true

-- Preview substitutions live, as you type!
o.inccommand = 'split'

-- disable provider warnings
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- make sure we have a nerd fonts instaalled otherwise set to false
g.have_nerd_font = true

opt.spell = true
opt.spelllang = { 'en_gb' }

-- https://stackoverflow.com/questions/53327486/whats-happening-here-with-vim-inside-tmux-pane
-- this is still not resolved for me
if vim.env.TMUX then
  -- TODO: vim.opt has no options below?
  -- vim.cmd(
  --   [[
  --     let &t_ts = 'k'
  --     let &t_fs = '\\'
  --     " undercurl
  --     let &t_Cs = "\e[4:3m"
  --     let &t_Ce = "\e[4:0m"
  --   ]]
  -- )

  -- vim.api.nvim_set_var('&t_8f', '\\<Esc>[38;2;%lu;%lu;%lum')
  -- vim.api.nvim_set_var('&t_8f', '\\<Esc>[48;2;%lu;%lu;%lum')
  set_var('&t_8f', '\\<Esc>[38;2;%lu;%lu;%lum')
  set_var('&t_8b', '\\<Esc>[48;2;%lu;%lu;%lum')
  set_var('&t_Co', '256')

  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end
