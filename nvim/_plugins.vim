let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  silent exec "!curl -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" Plugs list
Plug 'neovim/nvim-lspconfig'
  \| Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-telescope/telescope.nvim'
  \| Plug 'nvim-lua/popup.nvim'
  \| Plug 'nvim-lua/plenary.nvim'
  \| Plug 'nvim-telescope/telescope-fzf-writer.nvim'
  \| Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'lewis6991/gitsigns.nvim'
Plug 'preservim/nerdcommenter'

call plug#end()
filetype plugin indent on

" Make sure to prioritize configs below over base visual settings
source $DOTFILES/nvim/__visual.vim

" Source configs for each
for plugin_config in split(glob('$DOTFILES/nvim/plugins/*.vim'), '\n')
    exe 'source' plugin_config
endfor
