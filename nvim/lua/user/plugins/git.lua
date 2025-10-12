-- Git plugins
return {
  -- Fugitive - Core git plugin
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gti', 'GIt', 'GTi', 'G', 'Gedit', 'Gdiff', 'Gblame', 'Gbrowse' },
    keys = {
      { '<leader>gg', ':vert Git<CR>', desc = 'Git status' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
      { '<leader>gh', 'V:Gbrowse<CR>', mode = 'n', desc = 'GitHub browse' },
    },
    config = function()
      -- Command aliases for common typos
      vim.cmd('command! -nargs=* -complete=option Gti Git <args>')
      vim.cmd('command! -nargs=* -complete=option GIt Git <args>')
      vim.cmd('command! -nargs=* -complete=option GTi Git <args>')
      vim.cmd('command! -nargs=* -complete=option G Git <args>')

      -- Custom keymap for special git command
      vim.keymap.set('n', 'g<C-q>', 'ZZ:Gedit<CR>', { noremap = true })
    end
  },

  -- Rhubarb - GitHub integration for fugitive
  {
    'tpope/vim-rhubarb',
    dependencies = { 'tpope/vim-fugitive' },
  },

  -- Gitgutter - Show git diff in sign column
  {
    'airblade/vim-gitgutter',
    event = { 'BufReadPost', 'BufNewFile' },
  },
}
