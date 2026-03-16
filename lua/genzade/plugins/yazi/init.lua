return {
  'mikavilpas/yazi.nvim',
  version = '*', -- use the latest stable version
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '<leader>o',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      -- Open in the current working directory
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
    -- floating_window_scaling_factor = 0.95,
    hooks = {
      before_opening_window = function(opts)
        -- this is to match the sizing of yazi to other floating windows (FTM)
        local cl = vim.o.columns
        local ln = vim.o.lines

        local width = math.ceil(cl * 0.95)
        local height = math.ceil(ln * 0.95 - 4)
        local col = math.ceil((cl - width) * 0.5 - 1)
        local row = math.ceil((ln - height) * 0.5 - 1)

        opts.width = width
        opts.height = height
        opts.row = row
        opts.col = col
      end,
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
