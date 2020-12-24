let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

"" Plugs list
" Comment out tool
Plug 'tpope/vim-commentary'

" Status line
Plug 'itchyny/lightline.vim'

" Undotree
Plug 'mbbill/undotree'

" Indent tool
Plug 'Yggdroot/indentLine'

" Surroundings
Plug 'tpope/vim-surround'

" For better tmux experience
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Multi language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Snippets (works with coc-snippets)
Plug 'honza/vim-snippets'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

call plug#end()
filetype plugin indent on


" Make sure to prioritize configurations below over base visual settings
source $DOTFILES/nvim/__visual.vim

" lightline
source $DOTFILES/nvim/colors/inheritor_lightline.vim
let g:lightline = {
    \ 'colorscheme': 'inheritor_lightline',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['cocstatus', winwidth(0) > 120 ? 'absolutepath' : 'filename', 'modified' ]],
    \   'right': [['cocgitbranch'], ['cocgitdiff']]
    \ },
    \ 'inactive': {
    \   'left': [['NONE'], ['filename']],
    \   'right': []
    \ },
    \ 'component_function': {
    \   'mode': 'CustomMode',
    \   'paste': 'CustomPaste',
    \   'absolutepath': 'CustomAbsolutePath',
    \   'filename': 'CustomFileName',
    \   'modified': 'CustomModified',
    \   'cocstatus': 'coc#status',
    \   'cocgitbranch': 'LightlineCocGitBranch',
    \   'cocgitdiff': 'LightlineCocGitDiff',
    \ },
    \ 'subseparator': {
    \   'left': '∣',
    \   'right': '∣'
    \ }
    \ }

function! CustomMode()
  return ' '.lightline#mode().' '
endfunction

function! CustomPaste()
  return &paste? '  PASTE  ' : ''
endfunction

function! CustomAbsolutePath()
  return ' '.expand('%:p').' '
endfunction

function! CustomFileName()
  return ' '.expand('%:t').' '
endfunction

function! CustomModified()
  return &modified? ' + ' : ''
endfunction

function! LightlineCocGitBranch()
    return exists('g:coc_git_status')? ' '.substitute(trim(get(g:, 'coc_git_status', '')), '[^a-zA-Z0-9_\ ]', '', 'g').' ' : ''
endfunction

function! LightlineCocGitDiff()
    return exists('b:coc_git_status')? ' '.trim(get(b:, 'coc_git_status', '')).' ' : ''
endfunction

" fzf.vim
" set wildmode=list:longest,list:full
" set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" nnoremap <silent> <leader>e :FZF -m<CR>

" The Silver Searcher
" if executable('ag')
"  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"  set grepprg=ag\ --nogroup\ --nocolor
" endif

" ripgrep
" if executable('rg')
"  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"  set grepprg=rg\ --vimgrep
"  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" endif

" Undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Coc
set nobackup
set nowritebackup
set updatetime=100
set shortmess+=c
set signcolumn=yes

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

autocmd CursorHold * silent call CocActionAsync('highlight')
highlight! link CocHighlightText Search

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

if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Coc-explorer
nmap <silent> <C-e> :CocCommand explorer --quit-on-open --width 40 --sources=buffer+,file+<CR>
autocmd VimEnter * if !argc() | exe "CocCommand explorer --quit-on-open --width 40 --sources=buffer+,file+ " . expand('%:p:h') | endif
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

