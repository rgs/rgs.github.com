function <SID>FT_check_pod()
    if getline(nextnonblank(1)) =~ '^=head'
	setf pod
    endif
endfunction
au BufNewFile,BufRead * call <SID>FT_check_pod()
