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

    utils.highlight("GitSignsAdd", "#30d158", "NONE", nil)
    utils.highlight("GitSignsChange", "#0a84ff", "NONE", nil)
    utils.highlight("GitSignsDelete", "#ff453a", "NONE", nil)
end
