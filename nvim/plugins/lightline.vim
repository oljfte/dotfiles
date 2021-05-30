source $DOTFILES/nvim/colors/inheritor_lightline.vim
let g:lightline = {
    \ 'colorscheme': 'inheritor_lightline',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['cocstatus', winwidth(0) > 160 ? 'absolutepath' : 'filename', 'modified' ]],
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
    return len(trim(get(g:, 'coc_git_status', ''))) > 0? ' '.substitute(trim(get(g:, 'coc_git_status', '')), '[^-a-zA-Z0-9_\ ]', '', 'g').' ' : ''
endfunction

function! LightlineCocGitDiff()
    return len(trim(get(b:, 'coc_git_status', ''))) > 0? ' '.trim(get(b:, 'coc_git_status', '')).' ' : ''
endfunction
