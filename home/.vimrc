set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
Plugin 'airblade/vim-gitgutter'         " Show git diff in number column
Plugin 'christoomey/vim-tmux-navigator' " <ctrl-h, j, k, l> to move panes in vim anf tmux
"Plugin 'vim-airline/vim-airline'        " visual bottom bar
Plugin 'tpope/vim-sensible'             " Sensible vim defaults
Plugin 'bogado/file-line'               " Open files at a specific line number (vim filename:42)
Plugin 'danro/rename.vim'               " Enables :rename <new_name>
Plugin 'chrisbra/Recover.vim'           " Better handling of swapfiles [https://github.com/chrisbra/Recover.vim]
Plugin 'godlygeek/tabular'              " :Tab /<repexp> in order to allign
Plugin 'plasticboy/vim-markdown'        " Markdown syntax
Plugin 'w0rp/ale'                       " Linter which uses shellckeck
Plugin 'nvie/vim-flake8'                " PEP8 linter
Plugin 'Valloric/YouCompleteMe'         " Autocompletion
Plugin 'sheerun/vim-polyglot'           " Syntax for 100+ languages
Plugin 'plytophogy/vim-virtualenv'      " controlling virtualenvs from within vim
"Plugin 'srcery-colors/srcery-vim'       " srcery colorscheme
Plugin 'joshdick/onedark.vim'           " OneDark colorscheme 
Plugin 'itchyny/lightline.vim'          " A light and configurable statusline/tabline
"Plugin 'felixhummel/setcolors.vim'      " script for switching colorschemes
Plugin 'vim-python/python-syntax'
Plugin 'AndrewRadev/splitjoin.vim'      "split with gS join with gJ
Plugin 'terryma/vim-smooth-scroll'      " Make scrolling in Vim more pleasant
Plugin 'pangloss/vim-javascript'        " Improved syntax highlighting and indentation for JS
" see :h vundle for more details or wiki for FAQ

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

"mapping tab
map <c-n> :tabn<CR>
map <c-p> :tabp<CR>
map <c-e> :tabe<space>

" Mapping smoothscroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"Ctrl-c to copy in Vmode
vnoremap <C-c> :w !pbcopy<CR><CR> 
"noremap <C-S-v> :r !pbpaste<CR><CR>

highlight ColorColumn ctermbg=gray
set colorcolumn=80

" Put your non-Plugin stuff after this line
set backspace=2

" Enable syntax highlighting
syntax enable

" Enable OneDark colorscheme
colorscheme onedark

" lightline configuration
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" Enable linenumbering
set relativenumber

" Execute python script
nnoremap <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
inoremap <F9> <ESC>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" One tab inserts 4 spaces
" set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set expandtab smarttab

" Higlight cursorline
set cursorline

" Show command in bottom bar
set showcmd

" Filetype-specific line indents
filetype indent on

"Grafical menu for autocomplete
set wildmenu

" Highlight matching paranthesis
set showmatch

" Move to first occurence during search
set incsearch

" Highlight search matches
set hlsearch

" denine encoding
set encoding=utf-8

" set natural split direction
set splitbelow
set splitright

" Remove highlight after finished search
nnoremap <leader><space> :nohlsearch<CR>
