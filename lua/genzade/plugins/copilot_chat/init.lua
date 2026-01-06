return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    -- See Configuration section for options
  },
  keys = {
    { '<leader>ic', '<CMD>CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
    { '<leader>ic', '<CMD>CopilotChat<CR>', mode = 'v', desc = 'Chat with Copilot' },
    { '<leader>id', '<CMD>CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
    { '<leader>ie', '<CMD>CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
    { '<leader>if', '<CMD>CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
    { '<leader>im', '<CMD>CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
    { '<leader>io', '<CMD>CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
    { '<leader>ir', '<CMD>CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
    {
      '<leader>is',
      '<CMD>CopilotChatCommit<CR>',
      mode = 'v',
      desc = 'Generate Commit for Selection',
    },
    { '<leader>it', '<CMD>CopilotChatToggle<CR>', mode = 'n', desc = 'Toggle Copilot Chat' },
    { '<leader>it', '<CMD>CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
  },
}
