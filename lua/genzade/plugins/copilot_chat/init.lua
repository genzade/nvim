return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    { 'folke/which-key.nvim' },
  },
  build = 'make tiktoken',
  opts = {
    -- See Configuration section for options
  },
  config = function()
    require('CopilotChat').setup()
    local wk_ok, wk = pcall(require, 'which-key')
    if not wk_ok then
      return
    end

    wk.add({
      {
        { '<leader>i', group = 'Copilot Chat' },
        {
          mode = { 'n', 'v' },
          { '<leader>ic', vim.cmd.CopilotChat, desc = 'Chat with Copilot' },
          { '<leader>it', vim.cmd.CopilotChatToggle, desc = 'Toggle Copilot Chat' },
        },
        {
          mode = 'n',
          { '<leader>im', vim.cmd.CopilotChatCommit, desc = 'Generate Commit msg' },
        },
        {
          mode = 'v',
          { '<leader>id', vim.cmd.CopilotChatDocs, desc = 'Generate Docs' },
          { '<leader>ie', vim.cmd.CopilotChatExplain, desc = 'Explain Code' },
          { '<leader>if', vim.cmd.CopilotChatFix, desc = 'Fix Code Issues' },
          { '<leader>im', vim.cmd.CopilotChatCommit, desc = 'Generate commit msg for selection' },
          { '<leader>io', vim.cmd.CopilotChatOptimize, desc = 'Optimize Code' },
          { '<leader>ir', vim.cmd.CopilotChatReview, desc = 'Review Code' },
          { '<leader>it', vim.cmd.CopilotChatTests, desc = 'Generate Tests' },
        },
      },
    })
  end,
}
