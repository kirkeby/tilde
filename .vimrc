set backup
"set undofile
set encoding=utf-8
set textwidth=78
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set ignorecase
set smartcase
set backspace=indent,eol,start
set statusline=%f\ %m\ %r\ %=[%l/%L]\ %3c\ 
set showmode
set showcmd
set laststatus=2
set wildignore=*.swp,*.pyc,*.class,*.o,*~
set ttyfast

" When formatting text, recognize numbered lists.
set formatoptions+=n

" Show invisible characters.
set list
set listchars=tab:▸\ 
"set listchars+=eol:¬
"set listchars+=trail:♦

" Holy fucking christ. Vim must never, ever, ever, *EVER* fucking touch my
" X clipboard. Vim is *not* a fucking GUI application!
set guioptions=-a
set clipboard=""

syntax on
filetype plugin on

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Highlight evil hard tabs, trailing white-space and overlong lines
highlight clear Evil
match Evil /\t\|.\{79,\}\|  *$/

" Various temporary-file syntax rules
autocmd BufNewFile,BufRead *
    \ highlight Evil term=standout ctermbg=red ctermfg=yellow
autocmd BufNewFile,BufRead * syntax sync fromstart
autocmd BufNewFile,BufRead psql.edit.* set syntax=sql
autocmd BufNewFile,BufRead ~/quotes/* setlocal tw=60
autocmd BufNewFile,BufRead *.shpaml setlocal sw=2 sts=2
autocmd BufNewFile,BufRead *.cs highlight clear Evil
autocmd BufNewFile,BufRead *.cmd highlight clear Evil

" Load plugins from .vim/bundles/*
call pathogen#runtime_prepend_subdirectories(expand('~/.vim/bundles'))

" Bluth.
let mapleader=","

" NERDTree for browsing
nnoremap <Leader>t :NERDTree<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=64
