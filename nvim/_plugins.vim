let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  silent exec "!curl -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" Plugs list
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'

call plug#end()
filetype plugin indent on

" Make sure to prioritize configs below over base visual settings
source $DOTFILES/nvim/__visual.vim

" Source configs for each
for plugin_config in split(glob('$DOTFILES/nvim/plugins/*.vim'), '\n')
    exe 'source' plugin_config
endfor
