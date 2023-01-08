return function()
	local utils = require("utils")
	utils.highlight("IndentBlanklineChar", "#323236", "NONE", nil)
	require("indent_blankline").setup({
		char = "▏",
	})
end
