local autocmd = vim.api.nvim_create_autocmd

-- Custom filetype detection
vim.filetype.add({
  extension = { geojson = 'json' },
})

-- Filetype-specific indentation settings
local function set_indent(filetype, spaces)
  autocmd('FileType', {
    pattern = filetype,
    callback = function()
      vim.opt_local.tabstop = spaces
      vim.opt_local.shiftwidth = spaces
      vim.opt_local.softtabstop = spaces
      vim.opt_local.expandtab = true
    end
  })
end

-- 2-space indentation for web files
set_indent('html', 2)
set_indent('htmldjango', 2)
set_indent('xhtml', 2)
set_indent('xml', 2)
set_indent('css', 2)
set_indent('sh', 2)
set_indent('javascript', 2)
set_indent('javascriptreact', 2)
set_indent('typescript', 2)
set_indent('typescriptreact', 2)
set_indent('json', 2)
set_indent('geojson', 2)

-- 4-space indentation for SQL
set_indent('sql', 4)
