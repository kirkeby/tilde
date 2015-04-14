" A bit more than two line-widths to allow for UI taking up some space.
winsize 180 60

" Pretty colors.
colorscheme desert
highlight NonText guibg=grey20
highlight SpecialKey guibg=salmon

" Stuff there is room for here, but not in a normal 80x24 terminal vim.
set number
set cursorline

" Show invisible characters; we can actually do this in a gvim without
" screwing up copy/paste.
set listchars=tab:▸·,trail:·

" 1) Shut up. 2) Stop giving me seizures.
set visualbell t_vb=
