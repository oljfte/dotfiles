return function()
    local actions = require("telescope.actions")
    local utils = require("utils")

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
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        -- TODO: Set min/max
                        width = 0.8,
                        height = 0.6
                    }
                }
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type",
                        "file",
                        "--follow",
                        "--hidden",
                        "--no-ignore-vcs"
                    }
                }
            }
        }
    )

    utils.highlight("TelescopeNormal", "lightgray", nil, nil)
    utils.highlight("TelescopeSelection", "white", nil, "bold")
    utils.highlight("TelescopeMultiSelection", "white", nil, "bold")
    utils.highlight("TelescopeMatching", "green", nil, nil)

    utils.keymap('n', "<leader>ff", ":Telescope find_files<CR>")
    utils.keymap('n', "<leader>fh", ":Telescope oldfiles<CR>")
    utils.keymap('n', "<leader>fb", ":Telescope buffers<CR>")
    utils.keymap('n', "<leader>fg", ":Telescope live_grep<CR>")
end