-- Options
-- All Vim settings migrated from vimrc

local opt = vim.opt

-- General
opt.compatible = false                    -- Improved defaults
opt.termguicolors = true                  -- Enable 24-bit RGB colors
opt.swapfile = false                      -- Never use swapfile
opt.updatetime = 100                      -- Default is 4000ms

-- Enable filetype detection, plugins, and indent
-- This is critical for LSP, syntax, and plugin loading
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- UI
opt.cursorline = true                     -- Highlight cursor line
opt.showcmd = true                        -- Show command in bottom bar
opt.number = true                         -- Show line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.signcolumn = "yes"                    -- Always show sign column
opt.showtabline = 2                       -- Always show tabline

-- Splits
opt.splitbelow = true                     -- Natural split direction
opt.splitright = true                     -- Natural split direction

-- Text formatting
opt.textwidth = 0                         -- Don't auto-wrap text
opt.wrapmargin = 0                        -- Don't auto-wrap at margin
opt.formatoptions:remove("t")             -- Don't force line breaks in insert mode

-- Search
opt.ignorecase = true                     -- Ignore case when searching
opt.smartcase = true                      -- Unless using capital letters
opt.incsearch = true                      -- Move to first occurrence during search
opt.hlsearch = true                       -- Highlight search matches
opt.showmatch = true                      -- Highlight matching parenthesis

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = true                       -- Graphical menu for autocomplete

-- Buffers
opt.hidden = true                         -- Allow buffer switching without saving

-- Python providers
vim.g.python3_host_prog = '~/.vimvenv/bin/python'
vim.g.perl_host_prog = '/usr/bin/perl'

-- Leader key
vim.g.mapleader = " "                     -- Use space as leader

-- Plugin settings
vim.g.vsnip_filetypes = {
  python = { 'django' },
  ['jinja.html'] = { 'djangohtml' },
  htmljinja = { 'djangohtml' }
}
