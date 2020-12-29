set foldlevel=99

augroup anyfold
    autocmd!
    autocmd Filetype * AnyFoldActivate
augroup END

autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > 1000000 || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd!
        autocmd Filetype * setlocal foldmethod=indent
    augroup END
endfunction
