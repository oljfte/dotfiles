" Source config
for config_path in split(globpath('$DOTFILES/nvim/', '_[^_]*\.vim'), '\n')
  exe 'source' config_path
endfor

" Source custom configs
for config_path in split(globpath('$PERSONAL/nvim/', '_[^_]*\.vim'), '\n')
  exe 'source' config_path
endfor
