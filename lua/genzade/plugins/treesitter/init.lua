local config = function()
  local ok, ts_config = pcall(require, 'nvim-treesitter.configs')
  if not ok then
    return
  end

  ts_config.setup({
    ensure_installed = 'all',
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ignore_install = { "norg" },
    -- needs testing post migration
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ['<leader>df'] = {
            query = '@function.outer',
            desc = 'Peek function',
          },
          ['<leader>dF'] = {
            query = '@class.outer',
            desc = 'Peek class',
          },
        },
      },
      select = {
        enable = true,
        keymaps = {
          ['af'] = {
            query = '@function.outer',
            desc = 'Select [A]round [F]unction',
          },
          ['if'] = {
            query = '@function.inner',
            desc = 'Select [I]nner [F]unction',
          },
          ['ac'] = {
            query = '@class.outer',
            desc = 'Select around [C]lass]',
          },
          ['ic'] = {
            query = '@class.inner',
            desc = 'Select inner part of a [C]lass region',
          },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>p'] = {
            query = '@parameter.inner',
            desc = 'Swap with next [P]arameter',
          },
        },
        swap_previous = {
          ['<leader>P'] = {
            query = '@parameter.inner',
            desc = 'Swap with previous [P]arameter',
          },
        },
      },
    },
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufRead', 'BufNewFile', 'FileType' },
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = config,
}
