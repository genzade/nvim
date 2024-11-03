local config = function()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.setup()
end

return { 'folke/which-key.nvim', config = config }
