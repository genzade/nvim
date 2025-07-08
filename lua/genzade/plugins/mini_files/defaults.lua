local M = {}

M.keys = function()
  local mini_files_ok, mini_files = pcall(require, 'mini.files')
  if not mini_files_ok then
    return
  end

  return {
    {
      '<leader>o',
      function()
        mini_files.open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = '[O]pen mini.files explorer (Directory of Current File)',
    },
    {
      '<leader>O',
      function()
        mini_files.open(vim.uv.cwd(), true)
      end,
      desc = 'Open mini.files explorer (cwd)',
    },
  }
end

M.opts = function()
  return {
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 25,
    },
    options = {
      -- Whether to use for editing directories
      use_as_default_explorer = false,
    },
  }
end

return M
