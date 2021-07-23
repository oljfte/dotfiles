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
    prompt_prefix = "",
    selection_caret = "",
    entry_prefix = "",
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.8,
        height = 0.6,
      }
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

highlight TelescopeNormal ctermfg=darkgray
highlight TelescopeSelection ctermfg=white gui=bold
highlight TelescopeMultiSelection ctermfg=white gui=bold
highlight TelescopeMatching ctermfg=green
