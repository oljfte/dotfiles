return function()
    local cmp = require "cmp"

    local check_back_space = function()
      local col = vim.fn.col '.' - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
    end

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup {
        mapping = {
            ['<CR>'] = cmp.mapping.confirm(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(t("<C-n>"), "n")
                elseif check_back_space() then
                    vim.fn.feedkeys(t("<Tab>"), "n")
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(t("<C-p>"), "n")
                else
                    fallback()
                end
            end, { "i", "s" }),
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
end
