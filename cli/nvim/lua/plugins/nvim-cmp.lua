return function()
    local cmp = require "cmp"

    cmp.setup {
        mapping = {
            ['<CR>'] = cmp.mapping.confirm(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    feedkey("<C-n>", "n")
                elseif cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, {"i"}),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    feedkey("<C-p>", "n")
                elseif cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {"i"}),
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "path" },
            { name = "calc" },
            { name = "spell" },
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
        }
    }

    vim.cmd(
        [[
          augroup disable-cmp-in-telescope
            autocmd!
            autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
          augroup END
        ]]
    )
end
