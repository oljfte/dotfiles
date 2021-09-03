return function()
    local actions = require("telescope.actions")
    local utils = require("utils")
    local colors = require("colors")

    require("telescope").setup(
        {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close
                    },
                    n = {
                        ["<esc>"] = actions.close
                    }
                },
                -- TODO: Change these to empty string once https://github.com/nvim-telescope/telescope.nvim/pull/1046 is merged
                prompt_prefix = " ",
                selection_caret = " ",
                entry_prefix = " ",
            },
            pickers = {
                find_files = {
                    find_command = {
                        "rg",
                        "--ignore",
                        "--hidden",
                        "--files"
                    }
                }
            }
        }
    )

    utils.highlight("TelescopeNormal", colors.lightgray, nil, nil)
    utils.highlight("TelescopeSelection", colors.white, nil, "bold")
    utils.highlight("TelescopeMultiSelection", colors.white, nil, "bold")
    utils.highlight("TelescopeMatching", colors.green, nil, nil)

    utils.keymap('n', "<leader>ff", ":Telescope find_files<CR>")
    utils.keymap('n', "<leader>fh", ":Telescope oldfiles<CR>")
    utils.keymap('n', "<leader>fb", ":Telescope buffers<CR>")
    utils.keymap('n', "<leader>fg", ":Telescope live_grep<CR>")
end
