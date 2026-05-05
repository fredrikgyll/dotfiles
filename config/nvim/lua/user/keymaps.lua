-- Keymaps
-- All keybindings migrated from vimrc and init.vim

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
keymap('n', '<leader><space>', ':nohlsearch<CR>', opts)

-- Window navigation (Ctrl-hjkl)
keymap('n', '<C-h>', ':wincmd h<CR>', opts)
keymap('n', '<C-j>', ':wincmd j<CR>', opts)
keymap('n', '<C-k>', ':wincmd k<CR>', opts)
keymap('n', '<C-l>', ':wincmd l<CR>', opts)

keymap('n', '<leader>b', ':cclose<CR>', opts)

vim.cmd('command! -nargs=* -complete=option Q q <args>')
vim.cmd('command! -nargs=* -complete=option Qa qa <args>')
vim.cmd('command! -nargs=* -complete=option QA qa <args>')
vim.cmd('command! -nargs=* -complete=option W w <args>')
vim.cmd('command! -nargs=* -complete=option Wa wa <args>')
vim.cmd('command! -nargs=* -complete=option Wq wq <args>')
vim.cmd('command! -nargs=* -complete=option WQ wq <args>')
vim.cmd('command! -nargs=* -complete=option E e <args>')
-- System clipboard operations
keymap('v', '<leader>y', '"+y', opts)
keymap('v', '<leader>Y', '"+yg$', opts)
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>yy', '"+yy', opts)

keymap( 'n', '<leader>cp', function ()
  vim.fn.setreg('+', vim.fn.expand('%')) -- write to clippoard end
end, opts)

keymap("n", "<Leader>xo", ":e <C-r>+<CR>", opt) -- edit path in clipboard

-- Neovim automatically handles paste mode, no need for :set paste
keymap('n', '<leader>p', '"+p', opts)
keymap('n', '<leader>P', '"+P', opts)
keymap('v', '<leader>p', '"+p', opts)
keymap('v', '<leader>P', '"+P', opts)

-- Keep selection when indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('n', '<C-C>', ':Bdelete<CR>', opts)

-- Buffer navigation
keymap('n', '<C-N>', ':bnext<CR>', opts)
keymap('n', '<C-P>', ':bprev<CR>', opts)

-- Search behavior (make # and ? work same way as /)
keymap('n', 'n', function()
  local search_forward = vim.v.searchforward == 1
  local key = search_forward and 'n' or 'N'
  vim.cmd('normal! ' .. key)
  if vim.fn.foldclosed('.') ~= -1 then
    vim.cmd('normal! zv')
  end
end, opts)

keymap('n', 'N', function()
  local search_forward = vim.v.searchforward == 1
  local key = search_forward and 'N' or 'n'
  vim.cmd('normal! ' .. key)
  if vim.fn.foldclosed('.') ~= -1 then
    vim.cmd('normal! zv')
  end
end, opts)

-- Create command aliases for common typos
vim.cmd('command! WQ wq')
vim.cmd('command! Wq wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')

-- Write as sudo
vim.cmd('cmap w!! w !sudo tee > /dev/null %')

-- Note: The following keymaps are defined in their respective plugin files:
-- Telescope keymaps: lua/user/plugins/telescope.lua
-- LSP keymaps: lua/user/plugins/lsp.lua (in on_attach)
-- Git keymaps: lua/user/plugins/git.lua
-- ArgWrap: lua/user/plugins/editing.lua
-- Tagbar: lua/user/plugins/tools.lua
-- Vsnip: lua/user/plugins/completion.lua
