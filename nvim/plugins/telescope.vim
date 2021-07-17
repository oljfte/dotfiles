nnoremap <leader>ff :lua require('telescope').extensions.fzf_writer.files()<CR>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fg :lua require('telescope').extensions.fzf_writer.grep()<CR>

lua <<EOF
local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {
        ["<esc>"] = actions.close,
      },
    },
  }
  extensions = {
    fzf_writer = {
      use_highlighter = true
    }
  }
}
EOF
