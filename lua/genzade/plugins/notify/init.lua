local config = function()
  local notify_ok, notify = pcall(require, 'notify')
  if not notify_ok then
    return
  else
    vim.notify = notify
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.add({
    { '<Leader>n', group = 'Notify' },
    {
      mode = { 'n' },
      {
        '<Leader>nc',
        function()
          notify.dismiss({ silent = true, pending = true })
        end,
        desc = 'Close Notification',
      },
    },
  })

  notify.setup({
    stages = 'static',
    background_colour = 'FloatShadow',
    timeout = 3000,
    fps = 60,
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '✎',
    },
    top_down = false,
  })

  vim.lsp.handlers['window/showMessage'] = function(_, method, params, _)
    -- map both hint and info to info?
    local severity = { 'error', 'warn', 'info', 'info' }

    notify(method.message, severity[params.type])
  end
end

return {
  'rcarriga/nvim-notify',
  dependencies = { 'folke/which-key.nvim' },
  config = config,
}
