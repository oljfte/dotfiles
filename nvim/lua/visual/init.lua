require("visual.colorscheme")

local opt = vim.opt

opt.ruler = false
opt.number = true
opt.signcolumn = "yes"
opt.showmode = false
opt.title = true
opt.shortmess = opt.shortmess + "I"
opt.laststatus = 1
opt.guicursor = {"a:block-blinkon1", "i-c-ci:ver1-blinkon1"}

vim.g.no_buffers_menu = 1
vim.wo.fillchars = 'eob: '

-- Highlight yanked area
vim.cmd(
    [[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
  augroup END
]]
)
