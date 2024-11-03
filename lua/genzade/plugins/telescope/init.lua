local config = function()
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    print('telescope not ok ..................................')
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
    extensions = {
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

  local has_tbuiltin, tbuiltin = pcall(require, 'telescope.builtin')
  if not has_tbuiltin then
    print('telescope builtin not ok ...........................')
    return
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    {
      mode = { 'n' },
      { '<Leader>f', group = 'Telescope' },
      { '<Leader>fB', tbuiltin.buffers, desc = 'Find opened [B]uffers' },
      {
        '<Leader>fb',
        function()
          local ok, theme = pcall(require, 'telescope.themes')
          if not ok then
            return
          end

          tbuiltin.current_buffer_fuzzy_find(theme.get_ivy())
        end,
        desc = 'Search current [B]uffer',
      },
      { '<Leader>fC', tbuiltin.command_history, desc = 'Search [C]ommand history' },
      { '<Leader>fG', tbuiltin.git_commits, desc = 'Search [G]it commits' },
      { '<Leader>fL', tbuiltin.resume, desc = 'Resume [L]ast search' },
      { '<Leader>fc', tbuiltin.commands, desc = 'Search available [C]ommands' },
      { '<Leader>ff', tbuiltin.find_files, desc = 'Find [F]ile' },
      { '<Leader>fg', tbuiltin.git_files, desc = 'Find [G]it files' },
      { '<Leader>fh', tbuiltin.help_tags, desc = 'Search [H]elp docs' },
      { '<Leader>fl', tbuiltin.live_grep, desc = '[L]ive search string' },
      { '<Leader>fm', tbuiltin.marks, desc = 'Search [M]arks' },
      {
        '<Leader>fn',
        function()
          telescope.extensions.notify.notify()
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
    },
    {
      mode = { 'x' },
      {
        '<Leader>fs',
        function()
          local visual_selection = function()
            -- Get visually selected text

            -- TODO: make this work with new nvim_cmd api
            vim.cmd('noautocmd normal! "vy"')

            local text = vim.fn.getreg('v')

            vim.fn.setreg('v', {})

            text = string.gsub(text, '\n', '')

            if string.len(text) == 0 then
              text = nil
            end

            return text
          end

          tbuiltin.grep_string({ search = visual_selection() })
        end,
        desc = 'Find visually [S]elected word/s',
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
    'folke/which-key.nvim',
    'rcarriga/nvim-notify',
  },
  event = 'VimEnter',
  config = config,
}
