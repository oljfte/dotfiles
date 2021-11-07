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
                prompt_prefix = "",
                selection_caret = "",
                entry_prefix = "",
            },
            pickers = {
                find_files = {
                    find_command = {
                        "rg",
                        "--follow",
                        "--hidden",
                        "--files"
                    }
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }
    )

    require('telescope').load_extension('fzf')

    utils.highlight("TelescopeNormal", colors.lightgray, nil, nil)
    utils.highlight("TelescopeSelection", colors.white, nil, "bold")
    utils.highlight("TelescopeMultiSelection", colors.white, nil, "bold")
    utils.highlight("TelescopeMatching", colors.green, nil, nil)

    utils.keymap('n', "<leader>ff", ":Telescope find_files<CR>")
    utils.keymap('n', "<leader>fh", ":Telescope oldfiles<CR>")
    utils.keymap('n', "<leader>fb", ":Telescope buffers<CR>")
    utils.keymap('n', "<leader>fg", ":Telescope live_grep<CR>")
    utils.keymap('n', "<leader>gc", ":Telescope git_commits<CR>")
    utils.keymap('n', "<leader>gb", ":Telescope git_bcommits<CR>")
end
