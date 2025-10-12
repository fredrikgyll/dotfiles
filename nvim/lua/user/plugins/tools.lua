-- Development tools
return {
  -- Automatic ctag generation
  {
    'ludovicchabant/vim-gutentags',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Tagbar for tag navigation
  {
    'majutsushi/tagbar',
    keys = {
      { '<F12>', ':TagbarToggle<CR>', desc = 'Toggle Tagbar' },
    },
    config = function()
      vim.g.tagbar_map_nexttag = "]n"
      vim.g.tagbar_map_prevtag = "[n"
    end
  },

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
}
