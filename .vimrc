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
highlight Evil term=standout ctermbg=red ctermfg=yellow
match Evil /\t\|.\{79,\}\|  *$/

" Various temporary-file syntax rules
autocmd BufNewFile,BufRead * syntax sync fromstart
autocmd BufNewFile,BufRead psql.edit.* set syntax=sql

" Load plugins from .vim/bundles/*
call pathogen#runtime_prepend_subdirectories(expand('~/.vim/bundles'))

" NERDTree for browsing
nnoremap <Leader>t :NERDTree<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=64
