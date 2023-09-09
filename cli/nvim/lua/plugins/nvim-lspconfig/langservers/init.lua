local langservers = {
	"clangd",
	"dartls",
	"pyright",
	"rust_analyzer",
	"solargraph",
	"tsserver",
}
local result = {}

for _, server in ipairs(langservers) do
	local ok, module = pcall(require, "plugins.nvim-lspconfig.langservers." .. server)
	result[server] = ok and module or {}
end

return result
