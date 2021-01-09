" vim startup file of Rafael Garcia-Suarez

set nocp	" Use vim defaults, not vi ones
set bs=2	" Smart backspace in insert mode
set noea	" Don't resize windows on split/close
set fo+=r	" Auto-format comments while typing
set com-=:%	" '%' doesn't start comments
set hls		" Highlight search pattern matches
set nois	" ...but no incremental search
set nojs	" Join lines with only one space
set kp=		" No external help system
set mls=2	" Check two lines for modelines
set nf-=octal	" Ctrl-A doesn't increment octal numbers
set sb		" Open new windows below the current one
set shm=a	" Use the shortest messages
set sc		" Show commands being typed
set sm		" Show matching brackets when typing
set tw=0	" No automatic line wrap
set su+=.bs	" Skip makemaker files for filename completion
set su-=.h	" but not C header files
set ai si ts=8 sts=4 sw=4 et       " Default indent / tabs settings
set sbr=$ wrap  " List mode and non-text characters
set lcs=tab:!-,trail:~,extends:>,nbsp:#
set bk bdir=~/tmp,.,/tmp	   " Backup settings
set dir=~/tmp,.,/tmp,/var/tmp	   " Swap file
if has('folding')
    set nofen foldmethod=indent	   " Folding
endif
set pa=.,/etc,~,, cd=,,.,~	   " Where to search for files and paths
set vb		" visualbell
set notimeout ttimeout " time out on key codes only
set complete=.,w,b,u

" Custom status line display
set ls=2 " Always show status line
if has('statusline')
    function CurrentGitStatus()
        let gitoutput = split(system('git status --porcelain -b '.shellescape(expand('%')).' 2>/dev/null'),'\n')
        if len(gitoutput) > 0
            let b:gitstatus = strpart(get(gitoutput,0,''),3) . '/' . strpart(get(gitoutput,1,'  '),0,2)
        else
            let b:gitstatus = ''
        endif
    endfunc
    autocmd BufEnter,BufWritePost * call CurrentGitStatus()

    " Status line detail:
    " %f		file path
    " %y		file type between braces (if defined)
    " %([%R%M]%)	read-only, modified and modifiable flags between braces
    " %{'!'[&ff=='default_file_format']}
    "			shows a '!' if the file format is not the platform default
    " %{'$'[!&list]}	shows a '$' if in list mode
    " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
    "			only for debug : display the current syntax item name
    " %=		right-align following items
    " #%n		buffer number
    " %l/%L,%c%V	line number, total number of lines, and column number
    function SetStatusLineStyle()
        call CurrentGitStatus()
	if &stl == '' || &stl =~ 'synID'
	    let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} %(<%{&ft=='netrw'?'':b:gitstatus}>%)%=#%n %l/%L,%c%V "
	else
	    let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
	endif
    endfunc
    " Switch between the normal and vim-debug modes in the status line
    nmap _ds :call SetStatusLineStyle()<CR>
    call SetStatusLineStyle()
    " Window title
    if has('title')
	set titlestring=%t%(\ [%R%M]%)
    endif
endif

" Syntax highlighting settings and customizations
if has('syntax')
    let perl_include_pod=1
    let is_bash=1
    syntax on
    filetype plugin indent on
endif

"
" Mappings
"

" Define this for plugins
let mapleader="_"
let maplocalleader="_"

" Matches the currently selected area or the current word
vmap <silent> # y:match Error /\V<C-r>"/<CR>
nmap <silent> # :match Error /\<<C-r><C-w>\>/<CR>

" Redefine Y to be more intuitive
nmap Y y$

" Restrict current search on whole words only
nmap _* /\<<C-R>/\><CR>

" Break the current line after the cursor
nmap <F3> a<CR><Esc>

" Remove search pattern highlighting (because we have set hls previously)
nmap <silent> <F4> :noh<CR>:match none<CR>

" Toggle list mode
nmap <F6> :se list!<CR>

" Suppress all empty lines
nmap _em :g/^$/d<CR>

" Change directory to the one of the current file
nmap _h :lcd%:p:h<CR>
nmap _H :cd%:p:h<CR>

" I don't use the command-line window
nmap q: :q

" Suppress all spaces at end/beginning of lines
nmap _s :%s/\s\+$//<CR>
nmap _S :%s/^\s\+//<CR>

" Convert file format to unix
nmap _ux :se ff=unix<CR>

" Execute current line as a vim command
nmap _xx "xyy:@x<CR>

" Force syntax synchronization on whole file
nmap _y :syn sync fromstart<CR>

" invert lightness of the background
nmap _bg :let &bg=&bg=='dark'?'light':'dark'<CR>

" color adjustments
hi SpellBad term=reverse ctermbg=1

"
" Fix common typos and other abbreviations
"

iab boolena boolean
iab pirnt print
iab pritn print
iab serach search
iab vairable variable
iab varibale variable
iab varibales variables
iab udpate update

"
" Load external scripts
"

run githistorybrowser.vim

hi PerlVarHiLight ctermbg=NONE ctermfg=white cterm=bold
run hl-var-simple.vim
