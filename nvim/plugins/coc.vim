" Genaral
set nobackup
set nowritebackup
set updatetime=100
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
      \'coc-git',
      \'coc-yank',
      \'coc-pyright',
      \'coc-clangd',
      \'coc-rome',
      \'coc-sql',
      \'coc-texlab',
      \]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>":
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <leader>cdp <Plug>(coc-diagnostic-prev)
nnoremap <leader>cdn <Plug>(coc-diagnostic-next)
nnoremap <leader>cdf <Plug>(coc-definition)
nnoremap <leader>ctdf <Plug>(coc-type-definition)
nnoremap <leader>cim <Plug>(coc-implementation)
nnoremap <leader>crf <Plug>(coc-references)
nnoremap <leader>cdc :call <SID>show_documentation()<CR>
nnoremap <leader>crn <Plug>(coc-rename)
xnoremap <leader>cfs  <Plug>(coc-format-selected)
nnoremap <leader>cfs <Plug>(coc-format-selected)
nnoremap <leader>cfa :call CocAction('format')<cr>
nnoremap <leader>cfo :call CocAction('fold', <f-args>)
nnoremap <leader>coi :call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <leader>ghp <Plug>(coc-git-prevchunk)
nnoremap <leader>ghn <Plug>(coc-git-nextchunk)
nnoremap <leader>gcp <Plug>(coc-git-prevconflict)
nnoremap <leader>gcn <Plug>(coc-git-nextconflict)
nnoremap <leader>gci <Plug>(coc-git-chunkinfo)
nnoremap <leader>gcm <Plug>(coc-git-commit)
nnoremap <leader>gcu :CocCommand git.chunkUndo<CR>
nnoremap <leader>gcs :CocCommand git.chunkStage<CR>
nnoremap <leader>gdc :CocCommand git.diffCached<CR>
nnoremap <leader>gfu :CocCommand git.foldUnchanged<CR>
nnoremap <leader>gPU :CocCommand git.push<CR>

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
