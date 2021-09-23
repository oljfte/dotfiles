local utils = require('utils')

utils.keymap("i", "<Up>", "<Nop>")
utils.keymap("i", "<Down>", "<Nop>")
utils.keymap("i", "<Left>", "<Nop>")
utils.keymap("i", "<Right>", "<Nop>")
utils.keymap("n", "<Up>", "<Nop>")
utils.keymap("n", "<Down>", "<Nop>")
utils.keymap("n", "<Left>", "<Nop>")
utils.keymap("n", "<Right>", "<Nop>")
utils.keymap("v", "<Up>", "<Nop>")
utils.keymap("v", "<Down>", "<Nop>")
utils.keymap("v", "<Left>", "<Nop>")
utils.keymap("v", "<Right>", "<Nop>")

utils.keymap("n", "<ESC><ESC>", ":noh<CR>")

utils.keymap("n", "n", "nzzzv")
utils.keymap("n", "N", "Nzzzv")

utils.cnoreabbrev("W!", "w!")
utils.cnoreabbrev("Q!", "q!")
utils.cnoreabbrev("Qall!", "qall!")
utils.cnoreabbrev("Wq", "wq")
utils.cnoreabbrev("Wa", "wa")
utils.cnoreabbrev("wQ", "wq")
utils.cnoreabbrev("WQ", "wq")
utils.cnoreabbrev("W", "w")
utils.cnoreabbrev("Q", "q")
utils.cnoreabbrev("Qall", "qall")