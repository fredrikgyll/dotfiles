-- UI plugins
return {
  -- Gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },

  -- Lightline statusline
  {
    'itchyny/lightline.vim',
    dependencies = {
      'mengelbrecht/lightline-bufferline',
      'shinchu/lightline-gruvbox.vim',
    },
    config = function()
      vim.g.lightline = {
        colorscheme = 'gruvbox',
        active = {
          left = {
            { 'mode', 'paste' },
            { 'readonly', 'relativepath', 'modified' },
          }
        },
        tab = {
          active = { 'filename', 'modified' },
          inactive = { 'filename', 'modified' },
        },
        tabline = {
          left = { { 'buffers' } },
          right = { { 'gitbranch' } },
        },
        component_function = {
          gitbranch = 'FugitiveHead',
        },
        component_expand = {
          buffers = 'lightline#bufferline#buffers'
        },
        component_type = {
          buffers = 'tabsel'
        }
      }
    end
  },

  -- Web devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = true,
  },

  -- Search highlight
  {
    'PeterRincker/vim-searchlight',
    event = { 'BufReadPost', 'BufNewFile' },
  },
}
