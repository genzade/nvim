local undodir = string.format('%s/.cache/nvim/undo', os.getenv('HOME'))
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.backspace = 'indent,eol,start'
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.selection = 'inclusive'
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spelllang = { 'en_gb' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.timeoutlen = 600
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undo'
vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
vim.opt.updatetime = 250
vim.opt.winborder = 'rounded'
