local opt = vim.opt

-- Encoding/Format
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileformats = { "unix", "dos", "mac" }

-- Fix backspace indent
opt.backspace = { "indent", "eol", "start" }

-- Do not separate words with hyphen
opt.iskeyword = opt.iskeyword + { "-" }

-- Completion
opt.completeopt = { "longest", "menuone", "noinsert", "noselect" }
opt.shortmess:append({ c = true })

-- Disable mouse
opt.mouse = ""

-- Clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

-- Leader
vim.g.mapleader = " "

-- Tabs
opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 2
opt.expandtab = true

-- Command completion
opt.wildmenu = true
opt.wildmode = { "list:longest", "full" }

-- Enable hidden buffers
opt.hidden = true

-- Searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Grep
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }
opt.wildignore = { ".git/*", "node_modules/*", "*.o", "*.obj", ".git", "*.rbc", "*.pyc", "__pycache__", ".DS_Store" }

-- Rendering options
opt.ttimeoutlen = 1
opt.updatetime = 100

-- Autoread
opt.autoread = true

-- General autocmds
vim.cmd([[
      augroup remember-cursor-position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      augroup END
    ]])
