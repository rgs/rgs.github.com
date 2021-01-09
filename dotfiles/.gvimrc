" Remove menu and toolbar
set go-=m go-=T
set visualbell cursorline

" Set font
set guifont=Menlo-Regular:h14

" Set colors
set bg=light
color peachpuff
" Restore custom highlighting
highlight PerlVarHiLight guifg=black guibg=white gui=bold

" No cursor blink, ever
set gcr+=a:blinkon0

" Default geometry
set lines=40 co=100
