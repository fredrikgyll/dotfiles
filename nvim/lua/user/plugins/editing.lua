-- Editing enhancement plugins
return {
  -- Surround motion
  {
    'tpope/vim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
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

  -- File renaming
  {
    'danro/rename.vim',
    cmd = 'Rename',
  },

  -- Buffer kill without closing window
  {
    'qpkorr/vim-bufkill',
    keys = { '<C-c>' },
    cmd = { 'BD', 'BW', 'BUN' },
  },

  -- Python Black formatter (commented out auto-format in original config)
  {
    'psf/black',
    ft = 'python',
    -- Uncomment to enable auto-format on save:
    -- config = function()
    --   vim.g.black_fast = 1
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     pattern = '*.py',
    --     command = 'execute ":Black"'
    --   })
    -- end
  },
}
