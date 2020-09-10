call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

set autoread
set backup
set undofile
set undodir=$HOME/.vim/undo
set encoding=utf-8
set textwidth=78
set shiftwidth=4
set softtabstop=4
set expandtab
set ignorecase
set smartcase
set backspace=indent,eol,start
set statusline=%f\ %m\ %r\ %=[%l/%L]\ %3c\ 
set showmode
set showcmd
set laststatus=2
set wildignore=*.swp,*.pyc,*.class,*.o,*~
set ttyfast
set incsearch
set viminfo='1000,f1,<50,s10,h,%
set modeline
set nofoldenable
set nocindent
set nosmartindent

let g:rooter_patterns = ['.git']

" When formatting text, recognize numbered lists.
set formatoptions+=n

set tags=~/tags

" Holy fucking christ. Vim must never, ever, ever, *EVER* fucking touch my
" X clipboard. Vim is *not* a fucking GUI application!
set guioptions=-a
set clipboard=""

syntax enable
set background=dark
set list

filetype plugin on
filetype plugin indent on

" Various keybindings
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>
nmap <F8> :TagbarToggle<CR>

map <F1> <Esc>
imap <F1> <Esc>

map <F5> :make<CR>

let mapleader=";"

noremap <leader>. :lnext<cr>
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" shortcuts to make various targets
nnoremap <F5> :make test<CR>

" shortcuts to forcibly fix code snafus
nnoremap <leader>f :!in-vagrant isort %<cr>

" disable utterly broken python indentation (wtf, no, typing colon in a string
" is not a sign that you should mis-indent the whole line, vim)
autocmd FileType python setlocal indentkeys=

" Highlight evil hard tabs and trailing white-space (.gvimrc does this
" differently, so skip this for GUI).
if !has("gui_running")
    set listchars=tab:\ \ ,trail:\ 

    autocmd BufNewFile,BufRead *
        \ highlight SpecialKey term=standout ctermbg=red ctermfg=yellow
    autocmd BufNewFile,BufRead *.shpaml highlight clear SpecialKey
    autocmd BufNewFile,BufRead *.html highlight clear SpecialKey
    autocmd BufNewFile,BufRead *.cs highlight clear SpecialKey
    autocmd BufNewFile,BufRead *.cmd highlight clear SpecialKey
    autocmd BufNewFile,BufRead *.go highlight clear SpecialKey
endif

" Various temporary-file syntax rules
autocmd BufNewFile,BufRead * syntax sync fromstart
autocmd BufNewFile,BufRead psql.edit.* set syntax=sql
autocmd BufNewFile,BufRead ~/quotes/* setlocal tw=60
autocmd BufNewFile,BufRead *.shpaml setlocal sw=2 sts=2
autocmd BufNewFile,BufRead COMMIT_EDITMSG set tw=68
autocmd BufNewFile,BufRead Cargo.toml,Cargo.lock,*.rs compiler cargo
autocmd BufNewFile,BufRead Cargo.toml,Cargo.lock,*.rs set tw=78
autocmd BufNewFile,BufRead Cargo.toml,Cargo.lock,*.rs
    \ nnoremap <buffer> <F5> :make test<CR>

autocmd BufWritePre *
\ if !isdirectory(expand("<afile>:p:h")) |
    \ call mkdir(expand("<afile>:p:h"), "p") |
\ endif

" CtrlP ignores
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|cov|venv|vendor|build|dist|github.com)$'
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_match_window = 'max:20,results:200'

" LightLine
let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
  \ }
\ }
