local opt = vim.opt

-- General
opt.termguicolors = true
opt.swapfile = false
opt.updatetime = 100

-- UI
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showtabline = 2

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Text formatting
opt.textwidth = 0
opt.wrapmargin = 0
opt.wrap = false
opt.formatoptions:remove("t")

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Enable reading project-local .nvim.lua or .exrc files
opt.exrc = true
opt.secure = true

-- Python provider
vim.g.python3_host_prog = '~/.vimvenv/bin/python'

-- Leader key
vim.g.mapleader = " "
