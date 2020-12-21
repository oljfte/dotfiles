syntax on
set ruler
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

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

nnoremap n nzzzv
nnoremap N Nzzzv

" Colorscheme
source $DOTFILES/nvim/colors/inheritor.vim
colorscheme inheritor 

" Dim inactive panes
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

" Cursor appearance
set guicursor=a:block-blinkon0,i-c-ci:ver1-blinkon0
