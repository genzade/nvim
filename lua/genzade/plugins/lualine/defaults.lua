local M = {}

local padding = {
  left = 1,
  right = 1,
}

M.options = {
  icons_enabled = true,
  section_separators = '',
  component_separators = '',
  globalstatus = true,
  -- theme = 'sonokai',
  theme = 'auto',
}

-- local vim_icons = {
--   function()
--     return ""
--   end,
--   separator = { left = "", right = "" },
--   color = { bg = "#313244", fg = "#80A7EA" },
-- }

M.mode = {
  'mode',
  fmt = function(str)
    return str:sub(1, 1)
  end,
  color = function()
    local mode_color = {
      n = '#80A7EA',
      i = '#A6D189',
      v = '#EED49F',
      [''] = '#EED49F',
      V = '#EED49F',
      c = '#FF9CAC',
      no = '#80A7EA',
      s = '#FF9CAC',
      S = '#FF9CAC',
      [''] = '#FF9CAC',
      ic = '#A6D189',
      R = '#FF9CAC',
      Rv = '#FF9CAC',
      cv = '#FF9CAC',
      ce = '#FF9CAC',
      r = '#FF9CAC',
      rm = '#FF9CAC',
      ['r?'] = '#FF9CAC',
      ['!'] = '#FF9CAC',
    }
    return { bg = 'NONE', fg = mode_color[vim.fn.mode()] or 'LualineNormal', gui = 'bold' }
  end,
  -- icon = '',
}

M.branch = {
  'branch',
  color = { bg = 'NONE', gui = 'bold', fg = '#A6D189' },
  -- icon = '',
  icon = '',
}

M.diff = {
  'diff',
  colored = true,
  color = { bg = 'NONE' },
  padding = padding,
  -- symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  symbols = { added = ' ', modified = ' ', removed = ' ' },
}

-- M.diff = {
--   'diff',
--   color = { bg = 'NONE', fg = '#a6e3a1' },
--   -- uncomment and modify to use differenct symbols
--   -- symbols = {
--   --   added = '+',
--   --   modified = '~',
--   --   removed = '-',
--   -- },
-- }

M.filename = {
  'filename',
  file_status = true,
  symbols = { readonly = '󰌾', modified = '●', directory = '' },
  color = { bg = 'NONE', fg = '#F39660' },
}

M.diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic', 'nvim_lsp' },
  sections = { 'error', 'warn', 'info', 'hint' },
  update_in_insert = false, -- Update diagnostics in insert mode.
  always_visible = false,
  -- color = { bg = 'NONE' },
  color = { bg = '282C33', fg = 'abb2bf' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  padding = padding,
}

M.macro_recording = {
  'macro-recording',
  fmt = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == '' then
      return ''
    else
      return ' ' .. recording_register
    end
  end,
  color = { bg = 'NONE', fg = '#F7768E' },
  padding = padding,
}

-- M.fileformat = {
--   'fileformat',
--   icons_enabled = false,
--   -- symbols = {
--   --   unix = '', -- e712
--   --   dos = '', -- e70f
--   --   mac = '', -- e711
--   -- },
--   padding = padding,
-- }

-- override this because it feels wrong to see the linux penguin on the mac
-- lualine looks at fileformat (see :h fileformat) which is always unix on mac
-- revert to previous a better solution is found
M.fileformat = function()
  local os = vim.loop.os_uname().sysname
  local icon

  if os == 'Linux' then
    icon = '  '
  elseif os == 'Darwin' then
    icon = '  '
  else
    icon = '  '
  end
  --return icon .. os
  return icon
end

M.encoding = {
  'encoding',
  padding = padding,
}

M.lsp_status = {
  'lsp_status',
  -- icon = '  ',
  symbols = {
    -- Standard unicode symbols to cycle through for LSP progress:
    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    -- Standard unicode symbol for when LSP is done:
    done = '✓',
    -- Delimiter inserted between LSP names:
    separator = ' ',
    -- color = { bg = 'NONE' },
  },
  color = { bg = 'NONE', fg = '#b39df3' },
  -- color = { fg = '#b39df3' },
  ignore_lsp = { 'copilot' },
  icon = '󰒋',
  -- icon = '',
  -- padding = padding,
}

M.filetype = {
  'filetype',
  icon_only = true,
  color = { bg = 'NONE' },
  -- padding = padding,
}

M.progress = {
  'progress',
  -- color = { bg = 'NONE' },
  color = { bg = '282C33', fg = 'abb2bf' },
  -- padding = padding,
}

M.location = {
  'location',
  -- color = { fg = 'NONE' },
  -- color = { bg = 'NONE' },
  color = { bg = '282C33', fg = 'abb2bf' },
  -- padding = padding,
}

M.scrollbar = {
  function()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    -- local icon = ''
    -- local chars = {
    --   icon .. ' ██',
    --   icon .. ' ▇▇',
    --   icon .. ' ▆▆',
    --   icon .. ' ▅▅',
    --   icon .. ' ▄▄',
    --   icon .. ' ▃▃',
    --   icon .. ' ▂▂',
    --   icon .. ' ▁▁',
    --   icon .. ' __',
    -- }
    local chars = {
      '██',
      '▇▇',
      '▆▆',
      '▅▅',
      '▄▄',
      '▃▃',
      '▂▂',
      '▁▁',
    }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)

    return chars[index]
  end,
  -- color = { bg = 'NONE' },
  color = { bg = '282C33', fg = 'abb2bf' },
}

M.extensions = {
  'fzf',
  'lazy',
  'man',
  'nvim-tree',
  'quickfix',
}

return M
