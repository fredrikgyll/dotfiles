filetype off                  			" required
set nocompatible				" impproved defaults, required
set termguicolors

set noswapfile					" Never use SWAPfile
let mapleader = "\<Space>"			" Use SPACE as leader instead of \
set updatetime=100                              " Default 4000

""" neovim environments
let g:python_host_prog='~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog='~/.pyenv/versions/neovim3/bin/python'
"let g:ruby_host_prog = '~/.rbenv/versions/3.0.2/bin/neovim-ruby-host'
" let g:node_host_prog = '/Users/fredrikgy/Library/Application Support/fnm/node-versions/v22.5.1/installation/bin/neovim-node-host'
let g:perl_host_prog = '/usr/bin/perl'

""" Pulg
call plug#begin()

" Autocompletion
Plug 'ludovicchabant/vim-gutentags'                                     " Automatically generate ctags on write
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/nvim-cmp'
Plug 'glepnir/lspsaga.nvim'
Plug 'luckasRanarison/tailwind-tools.nvim'

Plug 'onsails/lspkind.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}             " Parsing engine for syntax, folding, etc.
Plug 'geigerzaehler/tree-sitter-jinja2'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Git
Plug 'tpope/vim-fugitive'                                               " Git plugin with commands 'G<command>'
Plug 'tpope/vim-rhubarb' 						" Enable :GBrowse for GitHub with fugitive.vim
Plug 'airblade/vim-gitgutter'                                           " Show git diff in signcolumn

" Navigation
Plug 'karb94/neoscroll.nvim'                                            " Smooth scroll animation instead of jump
Plug 'farmergreg/vim-lastplace'                                         " Move cursor to last edit location when reopening files
Plug 'bogado/file-line' 						" Open file on line with $ vim file:num
Plug 'qpkorr/vim-bufkill'                                               " unload buffer while keeping split

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }


" Tools
Plug 'tpope/vim-sensible'                                               " Sensible vim defaults
Plug 'rizzatti/dash.vim'                                                " Dash.app integration

" Editing
Plug 'danro/rename.vim'                                                 " Enables :Rename <new_name>
Plug 'tpope/vim-surround'                                               " Adds the surround motion bound to s
Plug 'fooSoft/vim-argwrap'                                              " Wrap function arguments with <leader>a
Plug 'psf/black'

" Visuals
Plug 'ellisonleao/gruvbox.nvim'
Plug 'itchyny/lightline.vim' 						" Lightweight statusline
Plug 'mengelbrecht/lightline-bufferline' 				" Bufferline functionality for lightline
Plug 'shinchu/lightline-gruvbox.vim' 					" Gruvbox colorscheme for gruvbox
Plug 'nvim-tree/nvim-web-devicons'                                      " For file icons in lots of plugins
Plug 'majutsushi/tagbar'                                                " Open tag navigation split with :Tagbar
Plug 'towolf/vim-helm'
Plug 'PeterRincker/vim-searchlight' 					" highlights Vim's current search match

call plug#end()

nnoremap <leader>sv :source $MYVIMRC<CR>
"let g:black_fast = 1
"autocmd BufWritePre *.py execute ':Black'


nnoremap g<C-q> ZZ:Gedit<CR>


""" Colors

" Use 256 colors in gui_running mode
"if !has('gui_running')
"  set t_Co=256
"endif
"
"set background=dark
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark='soft'
"let g:gruvbox_sign_column='bg0'
"colorscheme gruvbox

set completeopt=menu,menuone,noselect

""" Lightline

" active.left.1	\             [ 'readonly', 'relativepath', 'modified' ],
let g:lightline = {
	\ 'colorscheme' : 'gruvbox',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'relativepath', 'modified' ],
	\ 	    ]
        \ },
	\ 'tab': {
	\   'active': [ 'filename', 'modified' ],
	\   'inactive': [ 'filename', 'modified' ],
	\ },
	\ 'tabline': {
      	\   'left': [ [ 'buffers' ] ],
	\   'right': [ [ 'gitbranch' ] ],
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead',
	\   'scope': 'nvim_treesitter#statusline',
	\ },
	\ 'component_expand': {
	\   'buffers': 'lightline#bufferline#buffers'
	\ },
	\ 'component_type': {
	\   'buffers': 'tabsel'
	\ }
	\ }

function! LightlineScope()
  return v:lua.get_current_function_name()
endfunction

set showtabline=2

""" Plugins

"""" TagBar
map <F12> :TagbarToggle<CR>

let g:tagbar_map_nexttag = "]n"
let g:tagbar_map_prevtag = "[n"


"""" ArgWrap
" Wrap function arguments
nnoremap <silent> <leader>a :ArgWrap<CR>

" Use trailing comma on last argument
let g:argwrap_tail_comma = 1

"""" vim-fugitive

" symlink spelling mistakes
:command! -nargs=* -complete=option Gti Git <args>
:command! -nargs=* -complete=option GIt Git <args>
:command! -nargs=* -complete=option GTi Git <args>
:command! -nargs=* -complete=option G Git <args>

" Open git status page
nnoremap <Leader>gg :vert Git<CR>

""" vim-rhubarb
nnoremap <Leader>gb :Git blame<CR>

" Open current line on GitHub
nnoremap <Leader>gh V:Gbrowse<CR>

nnoremap <leader>gt <cmd>lua require('my_functions').find_files_expanded_word()<cr>
" nnoremap <leader>gt <cmd>lua require('telescope.builtin').find_files({find_command={'fd', vim.fn.expand("<cword>")}})<cr>

""" Basics

" Don't let the filetype plugin insert newlines automatically
set textwidth=0 wrapmargin=0

" Do not let vim force line breaks when exceeding textwidth in insert mode
set formatoptions-=t

" Higlight cursorline
set cursorline

" Show command in bottom bar
set showcmd

" Enable linenumbering
set relativenumber

" set natural split direction
set splitbelow
set splitright

" keep signcolumn open
set signcolumn=yes

" make # and ? wark same way as /
nnoremap <expr> n 'Nn'[v:searchforward].(&fdo=~'search\\|all'?'zv':'')
nnoremap <expr> N 'nN'[v:searchforward].(&fdo=~'search\\|all'?'zv':'')


" Copy to system clipboard
vnoremap  <leader>y  "+y
vnoremap  <leader>Y  "+yg$
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from system clipboard
nnoremap <leader>p :set paste<CR> "+p :set nopaste<CR>
nnoremap <leader>P :set paste<CR> "+P :set nopaste<CR>
vnoremap <leader>p :set paste<CR> "+p :set nopaste<CR>
vnoremap <leader>P :set paste<CR> "+P :set nopaste<CR>


" Keep selection when tabbing
vnoremap < <gv
vnoremap > >gv

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

""" vim-vsip
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

let g:vsnip_filetypes ={
	\ 'python' : ['django'],
        \ 'jinja.html': ['djangohtml'],
        \ 'htmljinja': ['djangohtml']
	\ }


" Command
"nnoremap <silent> <leader>: :Commands<CR>

" All git commits
"nnoremap <silent> <leader>gl :Commits<CR>

" Search helptags
"nnoremap <silent> <leader>hh :Helptags<CR>


" Remove search selection
nnoremap <leader><space> :nohlsearch<CR>

" When searching ignore case
set ignorecase

" Except when using Capital letters
set smartcase

"Grafical menu for autocomplete
set wildmenu

" Highlight matching paranthesis
set showmatch

" Move to first occurence during search
set incsearch

" Highlight search matches
set hlsearch


""" Buffers

" Change buffer mapping
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Remap buffer close to vim-bufkill
"
function! SmartBufKill()
  let active_buffer_count=len(getbufinfo({'buflisted':1}))
  if expand('%:p') != '' && active_buffer_count > 1
    BD
  else
    bd
  endif
endfunction
noremap <silent> <C-c> :call SmartBufKill()<cr>


""" Commands

" Write to the current file as sudo
cmap w!! w !sudo tee > /dev/null %

" map common errors to correct commands
:command WQ wq
:command Wq wq
:command W w
:command Q q


autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype jinja setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype htmljinja setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype xhtml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype javascriptreact setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype geojson setlocal ts=2 sw=2 expandtab
autocmd Filetype sql setlocal ts=4 sts=4 sw=4 expandtab

au BufRead,BufNewFile *.geojson set filetype=json

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd FileType python,htmldjango,css autocmd BufWritePre * call TrimWhitespace()

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif
