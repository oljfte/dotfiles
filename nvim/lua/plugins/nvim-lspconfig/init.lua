return function()
    local lspconfig = require("lspconfig")
    local langservers = require("plugins.nvim-lspconfig.langservers")

    local on_attach = function(client)
        require("plugins.nvim-lspconfig.visual")
        require("plugins.nvim-lspconfig.keymap")
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            signs = true,
            update_in_insert = true
        }
    )

    local function setup_servers()
        for langserver, config in pairs(langservers) do
            config.on_attach = on_attach
            lspconfig[langserver].setup(config)
        end
    end

    setup_servers()
end
