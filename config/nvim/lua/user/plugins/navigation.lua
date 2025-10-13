-- Navigation enhancement plugins
return {
  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },

  -- Restore cursor to last edit position
  {
    'farmergreg/vim-lastplace',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Open file:line with vim file.txt:123
  {
    'wsdjeg/vim-fetch',
    lazy = false,
  },
}
