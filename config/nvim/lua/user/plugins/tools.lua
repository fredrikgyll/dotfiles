-- Development tools
return {
  -- Automatic ctag generation
 -- {
 --   'ludovicchabant/vim-gutentags',
 --   event = { 'BufReadPost', 'BufNewFile' },
 -- },

  -- Dash integration
  {
    'rizzatti/dash.vim',
    cmd = { 'Dash', 'DashKeywords' },
  },

  -- Helm file support
  {
    'towolf/vim-helm',
    ft = 'helm',
  },

  {
    'nvim-pack/nvim-spectre',
    cmd = { 'Spectre' }
  }
}
