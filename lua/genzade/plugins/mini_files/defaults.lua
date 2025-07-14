local M = {}

M.keys = function()
  local minifiles_ok, minifiles = pcall(require, 'mini.files')
  if not minifiles_ok then
    return
  end

  return {
    {
      '<leader>o',
      function()
        local file = vim.api.nvim_buf_get_name(0)
        local file_exists = vim.fn.filereadable(file) ~= 0

        minifiles.open(file_exists and file or nil)
        minifiles.reveal_cwd()
      end,
      desc = '[O]pen mini.files explorer (Directory of Current File)',
    },
    {
      '<leader>O',
      function()
        minifiles.open(vim.uv.cwd(), true)
      end,
      desc = '[O]pen mini.files explorer (cwd)',
    },
  }
end

M.map_split = function(buf_id, lhs, direction, close_on_file)
  local function rhs()
    local minifiles_ok, minifiles = pcall(require, 'mini.files')
    if not minifiles_ok then
      return
    end

    local fs_entry = minifiles.get_fs_entry()

    if fs_entry == nil or fs_entry.fs_type ~= 'file' then
      return
    end

    local cur_target = minifiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    minifiles.set_target_window(new_target)
    minifiles.go_in({ close_on_file = close_on_file })
  end

  local desc = 'Open in ' .. direction .. (close_on_file and ' and close' or '')

  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
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
      width_nofocus = 50,
      -- Width of preview window
      width_preview = 75,
    },
    options = {
      -- Whether to use for editing directories
      use_as_default_explorer = false,
    },
  }
end

return M
