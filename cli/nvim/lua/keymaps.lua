local utils = require("utils")

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
