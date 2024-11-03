local config = function()
  local set_hl = vim.api.nvim_set_hl
  local has_gitsigns, gitsigns = pcall(require, 'gitsigns')
  if not has_gitsigns then
    return
  end

  set_hl(0, 'SignColumn', { fg = 'NONE', bg = 'NONE' })
  set_hl(0, 'GitSignsAdd', { fg = 'Green', bg = 'NONE' })
  set_hl(0, 'GitSignsChange', { fg = 'Yellow', bg = 'NONE' })
  set_hl(0, 'GitSignsDelete', { fg = 'Red', bg = 'NONE' })
  set_hl(0, 'VertSplit', { fg = 'NONE', bg = 'NONE' })

  gitsigns.setup({
    signs = {
      add = { text = '+' },
      change = { text = '│' },
      changedelete = { text = '-' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local which_key_ok, which_key = pcall(require, 'which-key')
      if not which_key_ok then
        return
      end

      which_key.add({
        {
          mode = { 'n' },
          { ']', buffer = bufnr, group = 'gitsigns' },
          {
            ']c',
            function()
              if vim.wo.diff then
                return ']c'
              end

              vim.schedule(function()
                gs.next_hunk()
              end)

              return '<Ignore>'
            end,
            buffer = bufnr,
            desc = 'Go to next hunk',
          },
          { '[', buffer = bufnr, group = 'gitsigns' },
          {
            '[c',
            function()
              if vim.wo.diff then
                return ']c'
              end

              vim.schedule(function()
                gs.next_hunk()
              end)

              return '<Ignore>'
            end,
            buffer = bufnr,
            desc = 'Go to previous hunk',
          },
          { '<Leader>h', buffer = bufnr, group = 'gitsigns' },
          {
            '<Leader>hB',
            gs.toggle_current_line_blame,
            buffer = bufnr,
            desc = 'Git [B]lame toggle',
          },
          {
            '<Leader>hD',
            function()
              gs.diffthis('~')
            end,
            buffer = bufnr,
            desc = 'Git [D]iff ~',
          },
          { '<Leader>hR', gs.reset_buffer, buffer = bufnr, desc = '[R]eset buffer' },
          { '<Leader>hS', gs.stage_buffer, buffer = bufnr, desc = '[S]tage buffer' },

          {
            '<Leader>hb',
            function()
              gs.blame_line({ full = true })
            end,
            buffer = bufnr,
            desc = 'Git [B]lame',
          },
          { '<Leader>hd', gs.diffthis, buffer = bufnr, desc = 'Git [D]iff' },
          { '<Leader>hp', gs.preview_hunk, buffer = bufnr, desc = '[P]review hunk' },
          { '<Leader>hr', gs.reset_hunk, buffer = bufnr, desc = '[R]eset hunk' },
          { '<Leader>hs', gs.stage_hunk, buffer = bufnr, desc = '[S]tage hunk' },
          { '<Leader>hu', gs.undo_stage_hunk, buffer = bufnr, desc = '[U]ndo staged hunk' },
          { '<Leader>l', gs.toggle_deleted, buffer = bufnr, desc = 'Toggle de[L]eted' },
        },
        {
          mode = { 'v' },
          { '<Leader>h', buffer = bufnr, group = 'gitsigns' },
          { '<Leader>hs', gs.stage_hunk, buffer = bufnr, desc = '[S]tage hunk (visual)' },
          { '<Leader>hr', gs.reset_hunk, buffer = bufnr, desc = '[R]eset hunk (visual)' },
        },
        {
          mode = { 'o' },
          { 'ih', gs.select_hunk, buffer = bufnr, desc = 'Select [I]nner [H]unk' },
        },
        {
          mode = { 'x' },
          { 'ih', gs.select_hunk, buffer = bufnr, desc = 'Select [I]nner [H]unk' },
        },
      })
    end,
    -- watch_index = { interval = 1000 },
    current_line_blame = true,
    -- sign_priority = 6,
    -- update_debounce = 100,
    -- status_formatter = nil, -- Use default
    -- use_decoration_api = true,
    -- use_internal_diff = true, -- If luajit is present
  })
end

return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'folke/which-key.nvim' },
  event = 'BufRead',
  config = config,
}
