-- https://github.com/HRRood/nvim/blob/463d454c90374b2bcf9b6014de1cd5180711cc03/lua/plugins/fuzzy-finder.lua#L397
local config = function()
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    return
  end

  telescope.setup({
    defaults = {
      prompt_prefix = '$ ',
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
    },
    pickers = {
      buffers = {
        mappings = {
          n = {
            ['d'] = require('telescope.actions').delete_buffer,
          },
        },
        initial_mode = 'normal',
        sort_mru = true,
        ignore_current_buffer = true,
      },
      colorscheme = {
        enable_preview = true,
      },
      current_buffer_fuzzy_find = {
        theme = 'ivy',
      },
      git_status = {
        initial_mode = 'normal',
      },
      grep_string = {
        initial_mode = 'normal',
      },
      marks = {
        initial_mode = 'normal',
      },
      registers = {
        initial_mode = 'normal',
      },
      resume = {
        initial_mode = 'normal',
      },
    },
    extensions = {
      -- TODO: make this work properly
      -- ftm = {
      --   initial_mode = 'normal',
      --   prompt_prefix = '   ',
      -- },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        -- case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  telescope.load_extension('fzf')
  telescope.load_extension('notify')
  telescope.load_extension('neoclip')

  local highlights = {
    TelescopeBorder = { link = 'TelescopeNormal' },
    TelescopePromptBorder = { link = 'TelescopeNormal' },
    TelescopeResultsBorder = { link = 'TelescopeNormal' },
    TelescopePreviewBorder = { link = 'TelescopeNormal' },
  }

  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
  telescope.load_extension('ftm')

  local has_tbuiltin, tbuiltin = pcall(require, 'telescope.builtin')
  if not has_tbuiltin then
    return
  end

  local mappings = {
    { 'n', '?', tbuiltin.current_buffer_fuzzy_find, 'Search current [B]uffer' },
    { 'n', '<Leader>fC', tbuiltin.command_history, 'Search [C]ommand history' },
    { 'n', '<Leader>fL', tbuiltin.resume, 'Resume [L]ast search' },
    { 'n', '<Leader>fc', tbuiltin.commands, 'Search available [C]ommands' },
    { 'n', '<Leader>ff', tbuiltin.find_files, 'Find [F]ile' },
    { 'n', '<Leader>fgc', tbuiltin.git_commits, 'Search [G]it [C]ommits' },
    { 'n', '<Leader>fgf', tbuiltin.git_files, 'Find [G]it [F]iles' },
    { 'n', '<Leader>fgs', tbuiltin.git_status, 'Search [G]it [S]tatus' },
    { 'n', '<Leader>fh', tbuiltin.help_tags, 'Search [H]elp docs' },
    { 'n', '<Leader>fl', tbuiltin.live_grep, '[L]ive search string' },
    { 'n', '<Leader>fm', tbuiltin.marks, 'Search [M]arks' },
    {
      'n',
      '<Leader>fn',
      function()
        telescope.extensions.notify.notify({ initial_mode = 'normal' })
      end,
      'Search [N]otification',
    },
    {
      'n',
      '<Leader>fp',
      function()
        telescope.extensions.neoclip.default()
      end,
      'Search yank/[P]aste registers',
    },
    { 'n', '<Leader>fr', tbuiltin.registers, 'Search [R]egisters' },
    { 'n', '<Leader>fs', tbuiltin.grep_string, '[S]earch word under cursor' },
    {
      'n',
      '<leader>ft',
      -- '<cmd>Telescope ftm<CR>',
      function()
        telescope.extensions.ftm.ftm({ initial_mode = 'normal', prompt_prefix = '   ' })
      end,
      '[F]loating [T]erminal Picker',
    },
    {
      'x',
      '<Leader>fs',
      tbuiltin.grep_string,
      'Find visually [S]elected word/s',
    },
  }

  for _, mapping in ipairs(mappings) do
    local mode, lhs, rhs, desc = unpack(mapping)
    vim.keymap.set(mode, lhs, rhs, { desc = desc })
  end
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'rcarriga/nvim-notify',
    'genzade/ftm.nvim',
  },
  event = 'VimEnter',
  config = config,
}
