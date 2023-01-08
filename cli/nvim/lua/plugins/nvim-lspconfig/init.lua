return function()
	local lspconfig = require("lspconfig")
	local langservers = require("plugins.nvim-lspconfig.langservers")

	local on_attach = function(client)
		require("plugins.nvim-lspconfig.visual")
		require("plugins.nvim-lspconfig.keymap")

		vim.cmd("autocmd CursorHold <buffer> lua vim.diagnostic.open_float({ focusable = false })")
	end

	vim.diagnostic.config({
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = true,
	})

	local function setup_servers()
		for langserver, config in pairs(langservers) do
			config.on_attach = on_attach
			lspconfig[langserver].setup(config)
		end
	end

	setup_servers()
end
