let g:fzf_buffers_jump = 1
let g:fzf_prefer_tmux = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'tmux': '-p 70%' }

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>ff :Files <CR>
nnoremap <leader>fgf :GFiles 
nnoremap <leader>fgs :GFiles? 
nnoremap <leader>fgc :BCommits <CR>
nnoremap <leader>fb :Buffers <CR>
nnoremap <leader>frg :Rg 
nnoremap <leader>fl :BLines 
nnoremap <leader>fal :Lines 
nnoremap <leader>ft :BTags 
nnoremap <leader>fat :Tags 
nnoremap <leader>fb :Buffers <CR>
nnoremap <leader>fh :History <CR>
nnoremap <leader>f: :History: <CR>
nnoremap <leader>f/ :History/ <CR>
nnoremap <leader>fc :Commands <CR>
nnoremap <leader>fm :Maps <CR>
