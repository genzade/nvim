local config = function()
  local has_npairs, npairs = pcall(require, 'nvim-autopairs')
  if not has_npairs then
    return
  end

  npairs.setup({ enable_check_bracket_line = false })
end

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = config,
}
