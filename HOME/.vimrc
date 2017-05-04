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
Plugin 'vim-airline/vim-airline'        " visual bottom bar
Plugin 'tpope/vim-sensible'             " Sensible vim defaults
Plugin 'bogado/file-line'               " Open files at a specific line number (vim filename:42)
Plugin 'danro/rename.vim'               " Enables :rename <new_name>
Plugin 'chrisbra/Recover.vim'           " Better handling of swapfiles [https://github.com/chrisbra/Recover.vim]
Plugin 'godlygeek/tabular'              " :Tab /<repexp> in order to allign
Plugin 'plasticboy/vim-markdown'        " Markdown syntax
" see :h vundle for more details or wiki for FAQ

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Put your non-Plugin stuff after this line
set backspace=2

" Enable syntax highlighting
syntax enable

" Enable colortheme Darcula for syntax highlighting
colo darcula

" Enable linenumbering
set number

" One tab in file is shown as 4 spaces
set tabstop=4

" One tab inserts 4 spaces
set softtabstop=4

" Tab is set with above
set expandtab

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

" Remove highlight after finished search
nnoremap <leader><space> :nohlsearch<CR>
