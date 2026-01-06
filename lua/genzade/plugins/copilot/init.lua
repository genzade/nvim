local config = function()
  local status_ok, copilot = pcall(require, 'copilot')
  if not status_ok then
    return
  end

  copilot.setup({
    -- panel = {
    --   border = 'rounded',
    --   enabled = true,
    --   position = 'bottom',
    --   size = 20,
    --   keymap = {
    --     accept = '<C-y>',
    --     decline = '<C-e>',
    --     dismiss = '<C-c>',
    --     -- jump_next = '<C-kPoint>',
    --     -- jump_prev = '<C-kComma>',
    --   },
    -- },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = '<TAB>',
        decline = '<C-e>',
        dismiss = '<C-c>',
        -- next = '<C-kPoint>',
        -- prev = '<C-kComma>',
        next = '<C-n>',
        prev = '<C-p>',
      },
    },
    copilot_node_command = (function()
      local node_version =
        vim.trim(vim.fn.system("asdf list nodejs | tr -d ' *' | sort -V | tail -n1"))

      return string.format('%s/.asdf/installs/nodejs/%s/bin/node', os.getenv('HOME'), node_version)
    end)(),
  })

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  local copilot_panel_ok, copilot_panel = pcall(require, 'copilot.panel')
  if not copilot_panel_ok then
    return
  end

  local copilot_suggestion_ok, copilot_suggestion = pcall(require, 'copilot.suggestion')
  if not copilot_suggestion_ok then
    return
  end

  wk.add({
    {
      mode = { 'n' },
      { '<Leader>c', group = 'Copilot' },
      {
        '<Leader>cp',
        function()
          copilot_panel.open({ position = 'bottom', ratio = 0.4 })
        end,
        desc = 'Open [P]anel',
      },
      {
        '<Leader>cs',
        function()
          copilot_suggestion.toggle_auto_trigger()
        end,
        desc = 'Toggle [S]uggestion trigger',
      },
    },
    {
      mode = { 'i' },
      {
        '<C-s>',
        function()
          copilot_suggestion.toggle_auto_trigger()
        end,
        desc = 'Toggle [S]uggestion trigger',
      },
    },
  })
end

return {
  'zbirenbaum/copilot.lua',
  dependencies = { 'folke/which-key.nvim' },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = config,
  enabled = true,
}
