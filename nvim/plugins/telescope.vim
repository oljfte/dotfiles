nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

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
  },
  pickers = {
    find_files = {
      find_command = {
        'fd',
        '--type',
        'file',
        '--follow',
        '--hidden',
        '--no-ignore-vcs',
      },
    }
  },
}
EOF
