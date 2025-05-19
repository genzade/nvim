local config = function()
  INSERT_RESULT_KEY = '<C-y>'

  local ok, gemini = pcall(require, 'gemini')
  if not ok then
    return
  end

  gemini.setup({
    hints = {
      insert_result_key = INSERT_RESULT_KEY,
    },
    completion = {
      insert_result_key = INSERT_RESULT_KEY,
    },
  })
end

return {
  'kiddos/gemini.nvim',
  config = config,
  enabled = false,
}
