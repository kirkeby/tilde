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
set incsearch
set viminfo='1000,f1,<50,s10,h,%

" When formatting text, recognize numbered lists.
set formatoptions+=n

" Show invisible characters.
set list
set listchars=tab:▸\ 
"set listchars+=eol:¬
"set listchars+=trail:♦
set tags=~/tags

" Holy fucking christ. Vim must never, ever, ever, *EVER* fucking touch my
" X clipboard. Vim is *not* a fucking GUI application!
set guioptions=-a
set clipboard=""

" Try to infect with Pathogen.
try
  call pathogen#infect()
  call pathogen#helptags()
catch
endtry

syntax enable
set background=dark

filetype plugin on

" Various keybindings
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

map <F1> <Esc>
imap <F1> <Esc>

let mapleader=","

noremap <leader><leader> :make<cr>
noremap <leader>. :lnext<cr>

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
autocmd BufNewFile,BufRead *.shpaml highlight clear Evil
autocmd BufNewFile,BufRead *.html highlight clear Evil
autocmd BufNewFile,BufRead *.cs highlight clear Evil
autocmd BufNewFile,BufRead *.cmd highlight clear Evil
autocmd BufNewFile,BufRead COMMIT_EDITMSG set tw=68

" CtrlP ignores
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|cov|venv|vendor|build|dist)$'

let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

let g:jedi#popup_on_dot = 0
let g:jedi#show_function_definition = 0

autocmd BufNewFile,BufRead *.py source ~/.vim/pep8.vim
