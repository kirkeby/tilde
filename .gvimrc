" A bit more than two line-widths to allow for UI taking up some space.
winsize 180 60
vsplit

" Pretty colors.
colorscheme solarized

" Stuff there is room for here, but not in a normal 80x24 terminal vim.
set number
set cursorline
set colorcolumn=+2

" Show invisible characters; we can actually do this in a gvim without
" screwing up copy/paste.
set listchars=tab:▸·,trail:·

" 1) Shut up. 2) Stop giving me seizures.
set visualbell t_vb=
