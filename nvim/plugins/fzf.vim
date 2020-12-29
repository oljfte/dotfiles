let g:fzf_prefer_tmux = 1
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
autocmd FileType fzf tunmap <Esc>
