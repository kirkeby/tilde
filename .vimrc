set textwidth=78
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set ignorecase
set smartcase
set backspace=indent,eol,start 

" Holy fucking christ. Vim must never, ever, ever, *EVER* fucking touch my
" X clipboard. Vim is *not* a fucking GUI application!
set guioptions=-a
set clipboard=""

syntax on
filetype plugin indent on

" hard tabs are evil
highlight Tabs term=standout ctermbg=red guibg=red
match Tabs /\t/

" Various temporary-file syntax rules
autocmd BufNewFile,BufRead psql.edit.* set syntax=sql
