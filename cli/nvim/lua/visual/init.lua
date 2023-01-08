require("visual.highlights")

local opt = vim.opt

opt.ruler = false
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false
opt.title = true
opt.shortmess = opt.shortmess + "I"
opt.laststatus = 2
opt.guicursor = { "a:block-blinkon1", "i-c-ci:ver1-blinkon1" }
opt.termguicolors = true

vim.g.no_buffers_menu = 1
vim.wo.fillchars = "eob: "

-- Highlight yanked area
vim.cmd([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
    augroup END
]])

-- Auto highlight word under cursor
vim.cmd([[
  setl updatetime=300
  highlight WordUnderCursor guibg=#3C3F48
  autocmd CursorHold * call HighlightCursorWord()
  function! HighlightCursorWord()
      let search = getreg('/')
      let cword = expand('<cword>')
      let cchar = matchstr(getline('.'), '\%'.col('.').'c.')
      if match(cword, search) == -1 && len(cword) > 0 && stridx(cword, cchar) != -1
          exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
      else
          exe 'match WordUnderCursor /\V\<%s\>/'
      endif
  endfunction
]])
