-- Autocommands
-- All autocommands migrated from vimrc

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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
set_indent('jinja', 2)
set_indent('htmljinja', 2)
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

-- Custom filetype detection
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.geojson',
  command = 'set filetype=json'
})

-- Django/Jinja HTML detection based on directory structure
-- Detect Django projects: if manage.py exists in project root, treat .html as htmldjango
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.html',
  callback = function()
    local file_path = vim.fn.expand('%:p')

    -- Check if we're in a templates/ directory (Django convention)
    if file_path:match('/templates/') then
      vim.bo.filetype = 'htmldjango'
      return
    end

    -- Check if manage.py exists in any parent directory (Django project)
    local current_dir = vim.fn.expand('%:p:h')
    while current_dir ~= '/' do
      if vim.fn.filereadable(current_dir .. '/manage.py') == 1 then
        vim.bo.filetype = 'htmldjango'
        return
      end
      current_dir = vim.fn.fnamemodify(current_dir, ':h')
    end

    -- Check for jinja2/ directory pattern (already handled by treesitter)
    if file_path:match('/jinja2/') then
      vim.bo.filetype = 'htmljinja'
      return
    end

    -- Otherwise keep default html
  end
})

-- Trim trailing whitespace on save
local trim_group = augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = trim_group,
  pattern = { '*.py', '*.html', '*.css', '*.htmldjango' },
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end
})

-- Cursor color settings for xterm/rxvt
if vim.env.TERM and (vim.env.TERM:match('xterm') or vim.env.TERM:match('rxvt')) then
  -- Orange cursor in insert mode
  vim.cmd([[
    let &t_SI = "\<Esc>]12;orange\x7"
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
  ]])

  autocmd('VimLeave', {
    command = 'silent !echo -ne "\\033]112\\007"'
  })
end
