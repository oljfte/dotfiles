return function()
    local utils = require("utils")
    local colors = require("colors")

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
            },
            on_attach = function(bufnr)
              local gs = package.loaded.gitsigns

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              map({'n', 'v'}, '<leader>hs', gs.stage_hunk)
              map({'n', 'v'}, '<leader>hr', gs.reset_hunk)
              map('n', '<leader>hS', gs.stage_buffer)
              map('n', '<leader>hu', gs.undo_stage_hunk)
              map('n', '<leader>hR', gs.reset_buffer)
              map('n', '<leader>hp', gs.preview_hunk)
              map('n', '<leader>hb', function() gs.blame_line{full=true} end)
              map('n', '<leader>tb', gs.toggle_current_line_blame)
              map('n', '<leader>hd', gs.diffthis)
              map('n', '<leader>hD', function() gs.diffthis('~') end)
              map('n', '<leader>td', gs.toggle_deleted)
            end
        }
    )

    utils.highlight("GitSignsAdd", colors.green, "NONE", nil)
    utils.highlight("GitSignsChange", colors.blue, "NONE", nil)
    utils.highlight("GitSignsDelete", colors.red, "NONE", nil)
end
