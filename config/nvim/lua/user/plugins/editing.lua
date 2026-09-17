-- Editing enhancement plugins
return {
  -- Surround motion
  {
    'nvim-mini/mini.nvim',
    version = false,
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('mini.surround').setup()
    end
  },

  -- Auto-close brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true, -- Use treesitter
        ts_config = {
          lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' },
        },
        map_c_h = true,  -- Map <C-h> to delete pair
      })

      -- Integrate with nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- Custom jump-out keymap with <C-l>
      -- Jumps over closing brackets/quotes when cursor is right before them
      vim.keymap.set('i', '<C-l>', function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.fn.col('.')
        local char = line:sub(col, col)
        -- Check if cursor is before a closing character
        if char:match('[%)%]%}"\'`]') then
          return '<Right>'
        else
          return '<C-l>'  -- Default behavior if not before closing char
        end
      end, { expr = true, noremap = true, desc = 'Jump out of pairs or default <C-l>' })
    end
  },

  -- Color highlighter for CSS/Tailwind colors
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('colorizer').setup({
        filetypes = { '*' }, -- Enable for all filetypes
        user_default_options = {
          RGB      = true,  -- #RGB hex codes
          RRGGBB   = true,  -- #RRGGBB hex codes
          names    = true,  -- "Name" codes like Blue
          RRGGBBAA = true,  -- #RRGGBBAA hex codes
          rgb_fn   = true,  -- CSS rgb() and rgba() functions
          hsl_fn   = true,  -- CSS hsl() and hsla() functions
          css      = true,  -- Enable all CSS features
          css_fn   = true,  -- Enable all CSS *functions*
          tailwind = true,  -- Enable tailwind colors
        }
      })
    end
  },

  -- Argument wrapping
  {
    'fooSoft/vim-argwrap',
    keys = {
      { '<leader>a', ':ArgWrap<CR>', desc = 'Wrap/unwrap arguments', silent = true },
    },
    config = function()
      vim.g.argwrap_tail_comma = 1
    end
  },

  -- Buffer kill without closing window
  {
    'moll/vim-bbye',
    cmd = { 'Bdelete', 'Bwipeout' },
  },
}
