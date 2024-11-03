local M = {}

M.signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = ' ',
}

M.servers = {
  'bashls',
  'clangd',
  'cssls',
  'dockerls',
  'html',
  'solargraph',
  'lua_ls',
  'tailwindcss',
  'taplo',
  'terraformls',
  'ts_ls',
  'yamlls',
}

M.keymaps = function()
  local which_key_ok, which_key = pcall(require, 'which-key')
  if not which_key_ok then
    return
  end

  which_key.add({
    {
      mode = { 'n' },
      { ',', group = 'LSP' },
      { ',D', vim.lsp.buf.type_definition, desc = 'Type [D]efinition' },
      { ',ca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction' },
      { ',e', vim.diagnostic.open_float, desc = 'Op[E]n diagnostics' },
      { ',f', vim.lsp.buf.format, desc = '[F]ormat file' },
      { ',k', vim.lsp.buf.signature_help, desc = 'Signature help' },
      { ',q', vim.diagnostic.setloclist, desc = 'Create/replace location list for window' },
      { ',rn', vim.lsp.buf.rename, desc = '[R]e[N]ame symbol' },
      { ',w', group = 'Workspace' },
      { ',wa', vim.lsp.buf.add_workspace_folder, desc = '[A]dd folder' },
      {
        ',wl',
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = '[L]ist folders',
      },
      { ',wr', vim.lsp.buf.remove_workspace_folder, desc = '[R]emove folder' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { '[d', vim.diagnostic.goto_prev, desc = 'Previous [D]iagnostic' },
      { ']d', vim.diagnostic.goto_next, desc = 'Next [D]iagnostic' },
      { 'g', group = 'Go to' },
      { 'gD', vim.lsp.buf.declaration, desc = '[D]eclaration' },
      { 'gd', vim.lsp.buf.definition, desc = '[D]efinition' },
      { 'gi', vim.lsp.buf.implementation, desc = '[I]mplementation' },
      { 'gr', vim.lsp.buf.references, desc = '[R]eferences' },
    },
  })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    'textDocument/formatting',
    vim.lsp.util.make_formatting_params({}),
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == 'string' and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if
        not vim.api.nvim_buf_is_loaded(bufnr)
        or vim.api.nvim_buf_get_option(bufnr, 'modified')
      then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd('silent noautocmd update')
        end)
      end
    end
  )
end

M.on_attach = function(client, bufnr)
  vim.inspect(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  M.keymaps()

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end
end

return M
