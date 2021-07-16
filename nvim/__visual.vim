syntax on
set noruler
set number
set noshowmode
set title
set t_Co=256

let no_buffers_menu=1
let &fcs='eob: '

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '▏'
let g:indentLine_faster = 1

au TermEnter * setlocal scrolloff=0
au TermLeave * setlocal scrolloff=3

" Status line
set laststatus=1

" Highlight yanked area
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

" Use modeline overrides
set modeline
set modelines=10

nnoremap n nzzzv
nnoremap N Nzzzv

" Colorscheme
source $DOTFILES/nvim/colors/inheritor.vim
colorscheme inheritor 

" Cursor appearance
set guicursor=a:block-blinkon1,i-c-ci:ver1-blinkon1
