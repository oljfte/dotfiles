local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.nvim-treesitter"),
		event = "BufRead",
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		config = require("plugins.telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = require("plugins.nvim-lspconfig"),
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = require("plugins.nvim-cmp"),
	},
	{
		"lewis6991/gitsigns.nvim",
		config = require("plugins.gitsigns"),
		event = "BufRead",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugins.indent-blankline"),
	},
	{
		"zbirenbaum/copilot.lua",
		config = require("plugins.copilot"),
	},
})
