local config = function()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  telescope.load_extension('yaml_schema')

  -- TODO: not working since upgrade to 0.10.0, related to
  -- https://github.com/someone-stole-my-name/yaml-companion.nvim/issues/52
  wk.add({
    {
      mode = { 'n' },
      {
        '<Leader>fy',
        function()
          telescope.extensions.yaml_schema.yaml_schema()
        end,
        desc = 'Find [Y]aml schema',
      },
    },
  })
end

return {
  'someone-stole-my-name/yaml-companion.nvim',
  lazy = true,
  ft = { 'yml', 'yaml', 'json' },
  dependencies = {
    -- { 'b0o/schemastore.nvim', commit = '6f2ffb8420422db9a6c43dbce7227f0fdb9fcf75' },
    'folke/which-key.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = config,
}
