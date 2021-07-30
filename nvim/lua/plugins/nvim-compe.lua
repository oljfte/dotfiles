return function()
    local utils = require('utils')

    require "compe".setup(
        {
            preselect = "always",
            source = {
                path = true,
                buffer = true,
                calc = false,
                nvim_lsp = true,
                nvim_lua = true,
                spell = false,
                tags = true
            }
        }
    )

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    _G.tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
      elseif check_back_space() then
        return t "<Tab>"
      else
        return vim.fn['compe#complete']()
      end
    end

    _G.s_tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
      else
        return t "<S-Tab>"
      end
    end

    utils.keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    utils.keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    utils.keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    utils.keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    utils.keymap('i', '<CR>', "compe#confirm('<CR>')", {expr = true, noremap = true})
end
