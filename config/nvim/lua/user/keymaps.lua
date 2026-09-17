local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local user_cmd = vim.api.nvim_create_user_command

-- General
keymap('n', '<leader><space>', ':nohlsearch<CR>', opts)

-- Window navigation (Ctrl-hjkl)
keymap('n', '<C-h>', ':wincmd h<CR>', opts)
keymap('n', '<C-j>', ':wincmd j<CR>', opts)
keymap('n', '<C-k>', ':wincmd k<CR>', opts)
keymap('n', '<C-l>', ':wincmd l<CR>', opts)

keymap('n', '<leader>b', ':cclose<CR>', opts)

-- Command aliases for typos
user_cmd('Q',  'q<bang> <args>',  { bang = true, nargs = '*' })
user_cmd('Qa', 'qa<bang> <args>', { bang = true, nargs = '*' })
user_cmd('QA', 'qa<bang> <args>', { bang = true, nargs = '*' })
user_cmd('W',  'w<bang> <args>',  { bang = true, nargs = '*' })
user_cmd('Wa', 'wa<bang> <args>', { bang = true, nargs = '*' })
user_cmd('Wq', 'wq<bang> <args>', { bang = true, nargs = '*' })
user_cmd('WQ', 'wq<bang> <args>', { bang = true, nargs = '*' })
user_cmd('E',  'e<bang> <args>',  { bang = true, nargs = '*' })

-- System clipboard operations
keymap({ 'n', 'x' }, '<leader>y', '"+y', opts)
keymap('n', '<leader>Y', '"+y$', opts)

keymap('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, opts)

keymap('n', '<Leader>xo', ':e <C-r>+<CR>', opts)

keymap({ 'n', 'x' }, '<leader>p', '"+p', opts)
keymap({ 'n', 'x' }, '<leader>P', '"+P', opts)

-- Keep selection when indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('n', '<C-C>', ':Bdelete<CR>', opts)

-- Buffer navigation
keymap('n', '<C-N>', ':bnext<CR>', opts)
keymap('n', '<C-P>', ':bprev<CR>', opts)

-- Search: keep n/N direction consistent regardless of / vs ?
keymap('n', 'n', function()
  local key = vim.v.searchforward == 1 and 'n' or 'N'
  vim.cmd('normal! ' .. key)
  if vim.fn.foldclosed('.') ~= -1 then vim.cmd('normal! zv') end
end, opts)

keymap('n', 'N', function()
  local key = vim.v.searchforward == 1 and 'N' or 'n'
  vim.cmd('normal! ' .. key)
  if vim.fn.foldclosed('.') ~= -1 then vim.cmd('normal! zv') end
end, opts)

-- Write as sudo
keymap('c', 'w!!', 'w !sudo tee > /dev/null %')
