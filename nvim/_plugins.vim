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

" Indent tool
Plug 'Yggdroot/indentLine'

" Surroundings
Plug 'tpope/vim-surround'

" For better tmux experience
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Folding
Plug 'pseewald/vim-anyfold'

" Snippets (works with coc-snippets)
Plug 'honza/vim-snippets'

" Polyglot
Plug 'sheerun/vim-polyglot'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
filetype plugin indent on


" Make sure to prioritize configs below over base visual settings
source $DOTFILES/nvim/__visual.vim

" Source configs for each
for plugin_config in split(glob('$DOTFILES/nvim/plugins/*.vim'), '\n')
    exe 'source' plugin_config
endfor
