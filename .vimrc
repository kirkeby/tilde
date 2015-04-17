set autoread
set backup
set undofile
set encoding=utf-8
set textwidth=78
set colorcolumn=+2
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
set modeline

" When formatting text, recognize numbered lists.
set formatoptions+=n

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
set list

filetype plugin on

" Various keybindings
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

map <F1> <Esc>
imap <F1> <Esc>

map <F5> :make<CR>

let mapleader=","

noremap <leader><leader> :make<cr>
noremap <leader>. :lnext<cr>

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

autocmd FileType go compiler go
" *shudder*
autocmd FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8 nolist tw=0 autoindent smartindent makeprg=make

" CtrlP ignores
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|cov|venv|vendor|build|dist|github.com)$'
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_match_window = 'max:20,results:200'
