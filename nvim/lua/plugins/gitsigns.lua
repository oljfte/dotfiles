return function()
    local utils = require("utils")

    require("gitsigns").setup(
        {
            signs = {
                add = {hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
                change = {hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
                delete = {hl = "GitSignsDelete", text = "╻", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
                topdelete = {hl = "GitSignsDelete", text = "╹", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
                changedelete = {
                    hl = "GitSignsChange",
                    text = "┃",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn"
                }
            }
        }
    )

    utils.highlight("GitSignsAdd", "02", "NONE", nil)
    utils.highlight("GitSignsChange", "04", "NONE", nil)
    utils.highlight("GitSignsDelete", "01", "NONE", nil)
end
