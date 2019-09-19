set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" General
Plug 'christoomey/vim-tmux-navigator' " <ctrl-h, j, k, l> to move panes in vim anf tmux
Plug 'tpope/vim-sensible'             " Sensible vim defaults
Plug 'bogado/file-line'               " Open files at a specific line number (vim filename:42)
Plug 'danro/rename.vim'               " Enables :rename <new_name>
Plug 'chrisbra/Recover.vim'           " Better handling of swapfiles [https://github.com/chrisbra/Recover.vim]
Plug 'godlygeek/tabular'              " :Tab /<repexp> in order to allign
Plug 'cskeeters/vim-smooth-scroll'    " Make scrolling in Vim more pleasant
Plug 'ap/vim-buftabline'	      " Buffer list that lives in the tabline
Plug 'tpope/vim-eunuch'               " UNIX commands e.g :Rename :SudoWrite
Plug 'qpkorr/vim-bufkill'	      " delete a buffer without closing the split with :BD
Plug 'Valloric/MatchTagAlways'	      " always highlights the enclosing XML/HTML tags

" Git
Plug 'airblade/vim-gitgutter'         " Show git diff in number column
Plug 'jreybert/vimagit'               " Modal git editing with <leader>g
Plug 'tpope/vim-fugitive'             " Git plugin with commands 'G<command>'
Plug 'tpope/vim-rhubarb'	      " GitHub extension for fugitive.vim

" Theme
Plug 'joshdick/onedark.vim'           " OneDark colorscheme
Plug 'itchyny/lightline.vim'          " A light and configurable statusline/tabline
Plug 'maximbaz/lightline-ale'	      " ALE indicator for the lightline vim plugin
"Plug 'srcery-colors/srcery-vim'       " srcery colorscheme
"Plug 'felixhummel/setcolors.vim'      " script for switching colorschemes

" Python
Plug 'tweekmonster/django-plus.vim'   " Improvements to the handling of Django related files in Vi
"Plug 'plytophogy/vim-virtualenv'      " controlling virtualenvs from within vim
Plug 'AndrewRadev/splitjoin.vim'      " Split with gS join with gJ

" Testing
Plug 'janko/vim-test'		      "  Vim wrapper for running tests on different granularities.

" React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'


Plug 'neoclide/coc.nvim', {'branch': 'release'}
"""" Completion
"""if has('nvim')
"""  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"""else
"""  Plug 'Shougo/deoplete.nvim'
"""  Plug 'roxma/nvim-yarp'
"""  Plug 'roxma/vim-hug-neovim-rpc'
"""endif
"""Plug 'deoplete-plugins/deoplete-jedi'
"""Plug 'autozimu/LanguageClient-neovim', {
"""    \ 'branch': 'next',
"""    \ 'do': 'bash install.sh',
"""    \ }
"""Plug 'Shougo/neosnippet.vim'
"""Plug 'Shougo/neosnippet-snippets'
"""
"""
"""" Linting
"""Plug 'dense-analysis/ale'              " Asynchronous linting/fixing

"Plug 'plasticboy/vim-markdown'        " Markdown syntax
"Plug 'nvie/vim-flake8'                " PEP8 linter
"Plug 'sheerun/vim-polyglot'           " Syntax for 100+ languages

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'    " Automatically create ctag files

" All of your Plugins must be added before the following line
call plug#end()

""" Interpreters

let g:ruby_host_prog = expand('~/.rbenv/versions/2.6.3/bin/neovim-ruby-host')
let g:python3_host_prog = '/Users/fredrikg/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog  = '/Users/fredrikg/.pyenv/versions/neovim2/bin/python'
"""""""""""let g:deoplete#sources#jedi#python_path = '/Users/fredrikg/.pyenv/versions/neovim3/bin/python'
""" Map LEADER
let mapleader = "\<Space>"
set statusline^=%{coc#status()}
"""""""""""""""""" Deoplete
"""""""""""""""""""""let g:deoplete#enable_at_startup = 1
"""""""""""""""
"""""""""""""""""" LanguageServer
"""""""""""""""let g:LanguageClient_serverCommands = {
"""""""""""""""    \ 'python': ['/Users/fredrikg/.pyenv/shims/pyls'],
"""""""""""""""    \ 'html': ['html-languageserver', '--stdio'],
"""""""""""""""    \ 'css': ['css-languageserver', '--stdio'],
"""""""""""""""    \ }
"""""""""""""""
"""""""""""""""nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"""""""""""""""nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"""""""""""""""nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"""""""""""""""nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"""""""""""""""""" neosnippet
"""""""""""""""
"""""""""""""""imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"""""""""""""""smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"""""""""""""""xmap <C-k>     <Plug>(neosnippet_expand_target)
"""""""""""""""
"""""""""""""""imap <expr><TAB>
""""""""""""""" \ pumvisible() ? "\<C-n>" :
""""""""""""""" \ neosnippet#expandable_or_jumpable() ?
""""""""""""""" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"""""""""""""""
"""""""""""""""smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"""""""""""""""\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"""""""""""""""
"""""""""""""""" For conceal markers.
"""""""""""""""if has('conceal')
"""""""""""""""  set conceallevel=2 concealcursor=niv
"""""""""""""""endif
"""""""""""""""
"""""""""""""""" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
"""""""""""""""" found' messages
"""""""""""""""set shortmess+=c
"""""""""""""""
"""""""""""""""" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
"""""""""""""""inoremap <c-c> <ESC>


nnoremap gsv :source ~/.vimrc<CR>
nnoremap gip :PlugInstall<CR>
nnoremap gup :PlugUpdate<CR>

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

" Make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

""" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" All files in project
nnoremap <silent> <leader>l :Files<CR>

" All tags in current buffer
nnoremap <silent> <leader>T :BTags<CR>

" All tags in project
nnoremap <silent> <leader>t :Tags<CR>

" Command
nnoremap <silent> <leader>: :Commands<CR>

" All git commits
nnoremap <silent> <leader>gl :Commits<CR>

" All git commits in current buffer
nnoremap <silent> <leader>gL :Commits<CR>

" Grep content of all files
nnoremap <silent> <leader>f :Find<CR>

" Search normal mode mappings
nnoremap <silent> <leader><Esc> :Maps<CR>

" Search helptags
nnoremap <silent> <leader>H :Helptags<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"""" vim-fugitive
" Add the entire file to the staging area
nnoremap <Leader>gw :Gw<CR>      " git add file

" Show commits for every source line
nnoremap <Leader>gb :Gblame<CR>  " git blame

""" vim-rhubarb
" Open current line in the browser
nnoremap <Leader>gB :.Gbrowse<CR>

" Open visual selection in the browser
vnoremap <Leader>gB :Gbrowse<CR>

"""" Vimagit
nnoremap <leader>gg :Magit<CR>

" git push
nnoremap <leader>gp :! git push<CR>

" Enable deletion of untracked files in Magit (enable when you understand this)
" let g:magit_discard_untracked_do_delete=1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --exclude=@.gitignore --exclude=.mypy_cache --exclude=node_modules --exclude=migrations --exclude=admin.py --python-kinds=-i'

"""" vim-gutentags
let g:gutentags_ctags_exclude = ['.mypy_cache', '@.gitignore', 'node_modules', 'migrations', 'admin.py']

""" vim-gitgutter
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

" Update sign column every quarter second
set updatetime=250

" Use GitHub Octicons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''


""" Colorscheme

" Enable OneDark colorscheme
colorscheme onedark

" JS syntax
let g:javascript_plugin_flow = 1

let g:jsx_ext_required = 0

""" Gutter & Lightline

" lightline configuration
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'component_expand': {
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \     'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \     'linter_checking': 'left',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'left',
  \ },
  \ 'component_function': {
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \   'gitbranch': 'fugitive#head',
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \   'virtualenv': 'virtualenv#statusline',
  \   'gutentags': 'gutentags#statusline',
  \ },
  \ 'active': {
  \     'left':  [
  \                [ 'mode', 'paste' ],
  \                [ 'gitbranch', 'readonly', 'virtualenv', 'relativepath', 'modified', 'search_status'],
  \                [ 'gutentags', 'tagbar'],
  \                [ 'tagbar'],
  \              ],
  \	'right': [
  \         [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \	    [ 'lineinfo' ],
  \	    [ 'percent' ],
  \         [ 'filetype' ] ]
  \ },
  \ }

let g:lightline#ale#indicator_checking = ' '
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_ok = ' '
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = ''
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" ALE error message
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_pylint_options = '--load-plugins pylint_django'

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Keep ALE gutter open
let g:ale_sign_column_always = 1
"let g:ale_javascript_eslint_use_global = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'yapf'],
\   'javascript': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\}

let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}

nnoremap gaf :ALEFix<CR>


""" Testing

let test#strategy = "vimterminal"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-a> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


""" Keybindings

" Execute python script
nnoremap <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
inoremap <F9> <ESC>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

"change buffer mapping
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Remove highlight after finished search
nnoremap <leader><space> :nohlsearch<CR>

" remap buffer close to vim-bufkill
nnoremap <C-c> :BD<cr>


""" Formatting

" Display \t as 8 visual spaces (recommended setting)
"set tabstop=8

" Pressing tab during editing operations inserts 4 spaces
"set softtabstop=4

" Number of spaces used for each step of an (auto)indent action, e.g. '>>'.
"set shiftwidth=4

" Tab is replaced by the spaces specified as above
"set expandtab

" When vim smartwraps overflowing text, the text on the new line is indented properly
"set breakindent

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

" Filetype-specific line indents
filetype indent on

" set natural split direction
set splitbelow
set splitright

""" Search

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

""" Performance

" Some experimenting with latency

" Only used in vim
set ttyfast

" Do not redraw screens during macros, etc.
"set lazyredraw

""" Python

" Flag unnecessary whitespace in python files
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Enable python highlighting
let python_highlight_all=1

""" Indentation

autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype xhtml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype less setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype java setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype python setlocal omnifunc=jedi#completions tw=79
                                \ completeopt-=preview
                                \ formatoptions+=c
				\ cc=80
