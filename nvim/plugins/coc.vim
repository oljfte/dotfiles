" Genaral
set nobackup
set nowritebackup
set updatetime=100
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
      \'coc-explorer',
      \'coc-git',
      \'coc-pyright',
      \'coc-highlight',
      \'coc-json',
      \]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>":
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <Leader>F :call CocAction('format')<cr>
nnoremap <Leader>T :call CocAction('fold', <f-args>)
nnoremap <Leader>O :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Coc-explorer
nmap <silent> <C-e> :CocCommand explorer --width 40 --quit-on-open --sources=buffer+,file+<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
autocmd Filetype coc-explorer :IndentLinesDisable
highlight CocExplorerBufferRoot ctermfg=15
highlight CocExplorerFileRoot ctermfg=15
highlight CocExplorerFileRootName ctermfg=15
highlight CocExplorerBookmarkRoot ctermfg=15
highlight CocExplorerBufferBufnr ctermfg=15
highlight CocExplorerGitUnstaged ctermfg=15
highlight CocExplorerGitStaged ctermfg=15
highlight CocExplorerGitRootUnstaged ctermfg=15
highlight CocExplorerGitRootStaged ctermfg=15

highlight link CocExplorerBufferNameVisible Normal
highlight link CocExplorerLabel Normal
highlight link CocExplorerTimeAccessed Normal
highlight link CocExplorerTimeCreated Normal
highlight link CocExplorerTimeModified Normal
highlight link CocExplorerFileSize Normal

" Coc-git
nmap [G <Plug>(coc-git-prevchunk)
nmap ]G <Plug>(coc-git-nextchunk)
nmap [C <Plug>(coc-git-prevconflict)
nmap ]C <Plug>(coc-git-nextconflict)
nmap Gs <Plug>(coc-git-chunkinfo)
nmap Gc <Plug>(coc-git-commit)
nmap <leader>u :CocCommand git.chunkUndo<CR>
