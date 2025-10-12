-- Completion and snippets
return {
  -- nvim-cmp and sources
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lsp_signature_help = "[LSPSH]",
              path = "[PTH]",
              vsnip = "[Snip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
            before = function(entry, vim_item)
              -- Tailwind tools integration
              local ok, tailwind = pcall(require, 'tailwind-tools.cmp')
              if ok then
                return tailwind.lspkind_format(entry, vim_item)
              end
              return vim_item
            end
          })
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })

      -- Vsnip keybindings
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if vim.fn["vsnip#expandable"]() == 1 then
          return "<Plug>(vsnip-expand)"
        end
        return "<C-j>"
      end, { expr = true })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if vim.fn["vsnip#available"](1) == 1 then
          return "<Plug>(vsnip-expand-or-jump)"
        end
        return "<C-l>"
      end, { expr = true })

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if vim.fn["vsnip#jumpable"](1) == 1 then
          return "<Plug>(vsnip-jump-next)"
        end
        return "<Tab>"
      end, { expr = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if vim.fn["vsnip#jumpable"](-1) == 1 then
          return "<Plug>(vsnip-jump-prev)"
        end
        return "<S-Tab>"
      end, { expr = true })

      -- Select or cut text for snippets
      vim.keymap.set({ "n", "x" }, "s", "<Plug>(vsnip-select-text)")
      vim.keymap.set({ "n", "x" }, "S", "<Plug>(vsnip-cut-text)")
    end
  },
}
