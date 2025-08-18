local M = {}

M.setup = function()
  local core_modules = { 'autocmds', 'globals', 'keymaps', 'lsp', 'settings' }

  for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, string.format('genzade.core.%s', module))
    assert(ok, string.format('Error loading %s\n\n%s', module, err))
  end
end

return M
