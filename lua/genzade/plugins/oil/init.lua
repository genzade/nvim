local config = function()
  local oil_ok, oil = pcall(require, 'oil')
  if not oil_ok then
    return
  end

  oil.setup({
    columns = { "icon" },
    keymaps = {
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<Esc>"] = "actions.close",
    },
    view_options = {
      show_hidden = true,
    },
  })

  vim.keymap.set('n', '<leader>o', oil.toggle_float, { desc = 'Open [O]il file browser' })
end

return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = config,
}
