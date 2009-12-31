set backup
set textwidth=78
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set ignorecase
set smartcase
set backspace=indent,eol,start 
set statusline=%f\ %m\ %r\ %=[%l/%L]\ %3c\ 
set laststatus=2

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
match Evil /\t/
match Evil /  *$/
match Evil /.\{79,\}/

" Various temporary-file syntax rules
autocmd BufNewFile,BufRead * syntax sync fromstart
autocmd BufNewFile,BufRead psql.edit.* set syntax=sql

" Load plugins from .vim/bundles/*
call pathogen#runtime_prepend_subdirectories(expand('~/.vim/bundles'))
