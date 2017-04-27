" Set incompatible with vi
set nocompatible

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
