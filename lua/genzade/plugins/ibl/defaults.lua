local ibl_chars = {
  '▏',
  '▎',
  '▍',
}

-- local function set_hl(group, fg)
--   vim.api.nvim_set_hl(0, group, { fg = fg })
-- end

local highlights = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowViolet',
  'RainbowCyan',
}

local excludes = {
  filetypes = {
    'NvimTree',
    'dashboard',
    'git',
    'gitcommit',
    'help',
    'lspinfo',
    'markdown',
    'startup',
    'txt',
    '', -- for all buffers without a file type
  },
}

local M = {}

M.rainbow_colors = {
  -- { 'RainbowRed', '#E06C75' },
  { 'RainbowRed',    '#FF8B94' },
  { 'RainbowYellow', '#E5C07B' },
  { 'RainbowBlue',   '#61AFEF' },
  { 'RainbowOrange', '#D19A66' },
  { 'RainbowGreen',  '#98C379' },
  { 'RainbowViolet', '#C678DD' },
  { 'RainbowCyan',   '#56B6C2' },
}

M.opts = {
  indent = {
    char = ibl_chars[1],
    tab_char = ibl_chars[1],
    highlight = highlights,
  },
  scope = {
    enabled = true,
    char = ibl_chars[1],
    show_start = false,
    show_end = false,
  },
  exclude = excludes,
}

return M
