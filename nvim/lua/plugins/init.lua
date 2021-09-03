-- Install packer.nvim if not exists
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.api.nvim_command("packadd packer.nvim")
end

-- Plugins
local packer = require("packer")

return packer.startup(
    function(use)
        use({"wbthomason/packer.nvim"})

        use(
            {
                "nvim-treesitter/nvim-treesitter",
                config = require("plugins.nvim-treesitter"),
                event = "BufRead",
                run = ":TSUpdate"
            }
        )

        use(
            {
                "nvim-telescope/telescope.nvim",
                config = require("plugins.telescope"),
                requires = { {"nvim-lua/plenary.nvim"} }
            }
        )

        use(
            {
                "neovim/nvim-lspconfig",
                config = require("plugins.nvim-lspconfig"),
            }
        )

        use(
            {
                "hrsh7th/nvim-compe",
                config = require("plugins.nvim-compe"),
                event = "InsertEnter"
            }
        )

        use(
            {
                "lewis6991/gitsigns.nvim",
                config = require("plugins.gitsigns"),
                event = "BufRead"
            }
        )

        use(
            {
                "lukas-reineke/indent-blankline.nvim",
                config = require("plugins.indent-blankline")
            }
        )

        packer.install()
        packer.compile()
    end
)
