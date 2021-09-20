return function()
    require("nvim-treesitter.configs").setup(
        {
            highlight = {
                enable = true
            },
            ensure_installed = "maintained",
            indent = {enable = true},
            autopairs = {enable = true}
        }
    )
end
