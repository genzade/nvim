-- https://github.com/HRRood/nvim/blob/463d454c90374b2bcf9b6014de1cd5180711cc03/lua/plugins/fuzzy-finder.lua#L397
local config = function()
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    return
  end

  local fb_actions = require('telescope').extensions.file_browser.actions
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      layout_config = {
        width = 0.95,
        height = 0.95,
        preview_cutoff = 120,
        preview_width = 0.65,
        horizontal = {
          preview_cutoff = 120,
          preview_width = 0.6,
        },
        vertical = {
          preview_cutoff = 40,
        },
        flex = {
          flip_columns = 150,
        },
      },
      prompt_prefix = '   ',
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
        theme = 'dropdown',
        layout_strategy = 'horizontal',
        previewer = false,
        layout_config = {
          width = 0.95,
          height = 0.95,
          prompt_position = 'top',
        },
        prompt_prefix = ' 󰺮  ',
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
      file_browser = {
        -- theme = 'dropdown',
        -- theme = 'ivy',
        initial_mode = 'normal',
        grouped = true,
        select_buffer = true,
        hidden = { file_browser = true, folder_browser = true },
        hide_parent_dir = true,
        git_status = true,
        quiet = true,
        mappings = {
          ['i'] = {
            ['<A-c>'] = false,
            ['<C-CR>'] = fb_actions.create_from_prompt,
            ['<A-r>'] = false,
            ['<A-m>'] = false,
            ['<A-y>'] = false,
            ['<A-d>'] = false,
            ['<C-o>'] = false,
            ['<C-g>'] = false,
            ['<C-e>'] = false,
            ['<C-w>'] = false,
            ['<C-t>'] = false,
            ['<C-f>'] = fb_actions.toggle_browser,
            ['<C-h>'] = false,
            ['<C-s>'] = actions.select_vertical,
            ['<bs>'] = fb_actions.backspace,
          },
          ['n'] = {
            ['c'] = fb_actions.create,
            ['r'] = fb_actions.rename,
            ['m'] = fb_actions.move,
            ['y'] = fb_actions.copy,
            ['d'] = fb_actions.remove,
            ['o'] = fb_actions.open,
            ['g'] = false,
            ['~'] = fb_actions.goto_home_dir,
            ['e'] = false,
            ['w'] = fb_actions.goto_cwd,
            ['f'] = fb_actions.toggle_browser,
            ['.'] = fb_actions.toggle_hidden,
            ['h'] = false,
            ['s'] = actions.select_vertical,
            ['<bs>'] = fb_actions.goto_parent_dir,
          },
        },
      },
    },
  })
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  telescope.load_extension('fzf')
  telescope.load_extension('notify')
  telescope.load_extension('neoclip')
  telescope.load_extension('file_browser')
  telescope.load_extension('ftm')

  local has_tbuiltin, tbuiltin = pcall(require, 'telescope.builtin')
  if not has_tbuiltin then
    return
  end
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    {
      { '<leader>f', group = 'Telescope' },
      {
        mode = { 'n' },
        { '?', tbuiltin.current_buffer_fuzzy_find, desc = 'Search current [B]uffer' },
        { '<Leader>fC', tbuiltin.command_history, desc = 'Search [C]ommand history' },
        { '<Leader>fL', tbuiltin.resume, desc = 'Resume [L]ast search' },
        { '<Leader>fc', tbuiltin.commands, desc = 'Search available [C]ommands' },
        { '<Leader>ff', tbuiltin.find_files, desc = 'Find [F]ile' },
        { '<Leader>fgc', tbuiltin.git_commits, desc = 'Search [G]it [C]ommits' },
        { '<Leader>fgf', tbuiltin.git_files, desc = 'Find [G]it [F]iles' },
        { '<Leader>fgs', tbuiltin.git_status, desc = 'Search [G]it [S]tatus' },
        { '<Leader>fh', tbuiltin.help_tags, desc = 'Search [H]elp docs' },
        { '<Leader>fl', tbuiltin.live_grep, desc = '[L]ive search string' },
        { '<Leader>fm', tbuiltin.marks, desc = 'Search [M]arks' },
        {
          '<Leader>fn',
          function()
            telescope.extensions.notify.notify({ initial_mode = 'normal' })
          end,
          desc = 'Search [N]otification',
        },
        {
          '<Leader>fp',
          function()
            telescope.extensions.neoclip.default()
          end,
          desc = 'Search yank/[P]aste registers',
        },
        { '<Leader>fr', tbuiltin.registers, desc = 'Search [R]egisters' },
        { '<Leader>fs', tbuiltin.grep_string, desc = '[S]earch word under cursor' },
        {
          '<leader>ft',
          -- '<cmd>Telescope ftm<CR>',
          function()
            telescope.extensions.ftm.ftm({ initial_mode = 'normal', prompt_prefix = '   ' })
          end,
          desc = '[F]loating [T]erminal Picker',
        },
      },
      {
        mode = { 'x' },
        { '<Leader>fs', tbuiltin.grep_string, desc = 'Find visually [S]elected word/s' },
      },
    },
  })
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'rcarriga/nvim-notify',
    'nvim-telescope/telescope-file-browser.nvim',
    'genzade/ftm.nvim',
    'folke/which-key.nvim',
  },
  event = 'VimEnter',
  config = config,
}
