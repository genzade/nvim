local ensure_installed = {
  'bash',
  'c',
  'comment',
  'css',
  'diff',
  'dockerfile',
  'editorconfig',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'graphql',
  'haskell',
  'html',
  'javascript',
  'jq',
  'json',
  'json5',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'muttrc',
  'nix',
  'regex',
  'ruby',
  'rust',
  'scss',
  'slim',
  'sql',
  'ssh_config',
  'terraform',
  'tmux',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  event = { 'BufRead', 'BufNewFile', 'FileType' },
  opts = {
    ensure_installed = ensure_installed,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ignore_install = { 'norg', 'ipkg' },
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
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  -- config = config,
}
