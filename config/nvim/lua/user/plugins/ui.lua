-- UI plugins
return {
  -- Gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },

  -- Lualine statusline (modern Lua replacement for lightline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Custom function to get current scope path (e.g., module.Class.method)
      local function get_current_scope()
        local ts_utils_ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
        if not ts_utils_ok then
          return ''
        end

        local current_node = ts_utils.get_node_at_cursor()
        if not current_node then
          return ''
        end

        local scopes = {}
        local expr = current_node

        -- Walk up the tree and collect all scope names
        while expr do
          local node_type = expr:type()
          if node_type == 'function_declaration'
              or node_type == 'function_definition'
              or node_type == 'method_declaration'
              or node_type == 'method_definition'
              or node_type == 'class_declaration'
              or node_type == 'class_definition'
              or node_type == 'module' then
            local name_node = expr:field('name')[1]
            if name_node then
              local name = vim.treesitter.get_node_text(name_node, 0)
              -- Insert at the beginning to maintain hierarchy order
              table.insert(scopes, 1, name)
            end
          end
          expr = expr:parent()
        end

        if #scopes > 0 then
          return table.concat(scopes, '.')
        end
        return ''
      end

      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            { 'filename', path = 1 }, -- Show relative path
            { get_current_scope, icon = '' }
          },
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
