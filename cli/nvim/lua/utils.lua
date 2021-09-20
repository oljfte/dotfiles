local M = {}

local default_opts = {noremap = true, silent = true}

function M.buf_keymap(mode, key, cmd, opts)
    vim.api.nvim_buf_set_keymap(0, mode, key, cmd, opts or default_opts)
end

function M.keymap(mode, key, cmd, opts)
    vim.api.nvim_set_keymap(mode, key, cmd, opts or default_opts)
end

function M.cnoreabbrev(from, to)
    vim.cmd("cnoreabbrev "..from.." "..to)
end

function M.highlight(group, guifg, guibg, attr)
    local parts = {group}
    if guifg then
        table.insert(parts, "guifg=" .. guifg)
    end
    if guibg then
        table.insert(parts, "guibg=" .. guibg)
    end
    if attr then
        table.insert(parts, "gui=" .. attr)
    end
    vim.api.nvim_command("highlight " .. table.concat(parts, " "))
end

function M.highlight_link(from_group, to_group)
    vim.api.nvim_command("highlight! link " .. from_group .. " " .. to_group)
end

function M.sign_define(key, text, texthl, linehl, numhl, icon)
    local options = {}
    if text then
        options.text = text
    end
    if texthl then
        options.texthl = texthl
    end
    if linehl then
        options.linehl = linehl
    end
    if numhl then
        options.numhl = numhl
    end
    if icon then
        options.icon = icon
    end
    vim.fn.sign_define(key, options)
end

return M
