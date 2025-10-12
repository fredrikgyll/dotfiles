-- UI plugins
return {
  -- Gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },

  -- Lualine statusline (modern Lua replacement for lightline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } }, -- Show relative path
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        tabline = {
          lualine_a = {
            {
              'buffers',
              show_filename_only = false,
              mode = 2, -- Show buffer number + name
            }
          },
          lualine_z = { 'tabs' }
        },
      })
    end
  },

  -- Web devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = true,
  },
}
