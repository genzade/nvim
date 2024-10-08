local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end

  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local config = function()
  vim.g.completeopt = 'menu,menuone,noselect,noinsert'

  local cmp_status_ok, cmp = pcall(require, 'cmp')
  if not cmp_status_ok then
    return
  end
  local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_status_ok then
    return
  end
  local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
  if not lspkind_status_ok then
    return
  end

  lspkind.init()

  cmp.setup({
    mapping = {
      ['<tab>'] = cmp.config.disable,
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-y>'] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { 'i', 'c' }
      ),

      ['<C-space>'] = cmp.mapping({
        i = cmp.mapping.complete(),
        c = function(
          _ --[[fallback]]
        )
          if cmp.visible() then
            if not cmp.confirm({ select = true }) then
              return
            end
          else
            cmp.complete()
          end
        end,
      }),

      -- Testing
      ['<C-q>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

      ['<A-j>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<A-k>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      -- Could enable this only for lua, but nvim_lua handles that already.
      { name = 'nvim_lua',                keyword_length = 3 },
      { name = 'luasnip',                 keyword_length = 2 },
      -- { name = 'copilot', keyword_length = 0 },
      { name = 'nvim_lsp',                keyword_length = 2 },
      { name = 'path',                    keyword_length = 3 },
      { name = 'buffer',                  keyword_length = 3 },
      { name = 'emoji',                   keyword_length = 3 },
      { name = 'rg',                      keyword_length = 3 },
      { name = 'nvim_lsp_signature_help', keyword_length = 3 },
      {
        name = 'spell',
        keyword_length = 2,
        option = {
          function()
            local ctx = require('cmp.config.context')
            return ctx.in_treesitter_capture('spell')
          end,
        },
      },
    },
    sorting = {
      priority_weight = 2,
      -- TODO: Would be cool to add stuff like "See variable names before method names"
      -- in rust, or something like that.
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        -- require('copilot_cmp.comparators').prioritize,
        -- require('copilot_cmp.comparators').score,
        cmp.config.compare.score,

        cmp.config.compare.recently_used,
        cmp.config.compare.locality,

        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    -- come back here when luasnip is installed
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      -- How to set up nice formatting for your sources.
      format = lspkind.cmp_format({
        -- with_text = true,
        menu = {
          nvim_lsp = '[LSP]',
          luasnip = '[SNIP]',
          emoji = '[EMOJ]',
          nvim_lua = '[API]',
          path = '[PATH]',
          buffer = '[BUF]',
          spell = '[SPELL]',
        },
        mode = 'symbol_text',
        max_width = 50,
        symbol_map = {
          -- Class = 'ﴯ',
          -- Color = '',
          -- Constant = '',
          -- Constructor = '',
          -- -- Copilot = '',
          -- Enum = '',
          -- EnumMember = '',
          -- Event = '',
          -- Field = 'ﰠ',
          -- File = '',
          -- Folder = '',
          -- Function = '',
          -- Interface = '',
          -- Keyword = '',
          -- Method = '',
          -- Module = '',
          -- Operator = '',
          -- Property = 'ﰠ',
          -- Reference = '',
          -- Snippet = '',
          -- Struct = 'פּ',
          -- Text = '',
          -- TypeParameter = '',
          -- Unit = '塞',
          -- Value = '',
          -- Variable = '',

          Class = '󰠱',
          Color = '󰏘',
          Constant = '󰏿',
          Constructor = '',
          -- Copilot = '',
          Enum = '',
          EnumMember = '',
          Event = '',
          Field = '󰇽',
          File = '󰈙',
          Folder = '󰉋',
          Function = '󰊕',
          Interface = '',
          Keyword = '󰌋',
          Method = '󰆧',
          Module = '',
          Operator = '󰆕',
          Property = '󰜢',
          Reference = '',
          Snippet = '',
          Struct = '',
          Text = '',
          TypeParameter = '󰅲',
          Unit = '',
          Value = '󰎠',
          Variable = '󰂡',
        },
      }),
    },
    experimental = {
      -- I like the new menu better! Nice work hrsh7th
      native_menu = false,

      -- Let's play with this for a day or two
      ghost_text = false,
    },
    window = {
      documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None',
      }),
      -- documentation = {
      --   border = "rounded",
      --   winhighlight = "FloatBorder:FloatBorder,Normal:Normal",
      -- },
    },
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      { { name = 'nvim_lsp_document_symbol' } },
      { { name = 'buffer' } }
    ),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, {
      -- increase keyword_length if it gets annoying
      { name = 'cmdline', max_item_count = 30, keyword_length = 1 },
    }),
  })

  -- cmp.event:on('menu_opened', function()
  --   vim.b.copilot_suggestion_hidden = true
  -- end)

  -- cmp.event:on('menu_closed', function()
  --   vim.b.copilot_suggestion_hidden = false
  -- end)
  -- shout out to Telescopic Johnson
end

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'lukas-reineke/cmp-rg',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
    'f3fora/cmp-spell',
  },
  config = config,
}
