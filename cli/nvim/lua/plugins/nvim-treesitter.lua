return function()
	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
		},
		indent = { enable = true },
		autopairs = { enable = true },
		ensure_installed = "all",
	})
end
