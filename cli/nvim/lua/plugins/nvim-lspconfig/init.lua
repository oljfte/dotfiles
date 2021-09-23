return function()
    local lspconfig = require("lspconfig")
    local langservers = require("plugins.nvim-lspconfig.langservers")

    local on_attach = function(client)
        require("plugins.nvim-lspconfig.visual")
        require("plugins.nvim-lspconfig.keymap")

        vim.cmd("autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })")

        if client.name ~= 'efm' then
            client.resolved_capabilities.document_formatting = false
        end
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