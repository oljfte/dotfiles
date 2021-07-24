lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>fa", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  local servers = {
    "pyright",
    "rust_analyzer",
    "tsserver",
    "solargraph"
  }

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})

  vim.fn.sign_define("LspDiagnosticsSignError", {texthl = "LspDiagnosticsSignError", numhl = "LspDiagnosticsLineNrError"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {texthl = "LspDiagnosticsSignWarning", numhl = "LspDiagnosticsLineNrWarning"})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {texthl = "LspDiagnosticsSignInformation", numhl = "LspDiagnosticsLineNrInformation"})
  vim.fn.sign_define("LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", numhl = "LspDiagnosticsLineNrHint"})

  vim.api.nvim_exec([[
    set completeopt=longest,menuone,noinsert,noselect
    set shortmess+=c

    autocmd BufEnter * lua require'completion'.on_attach()
    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    highlight LspDiagnosticsDefaultHint ctermfg=lightgray
    highlight LspDiagnosticsDefaultError ctermfg=red
    highlight LspDiagnosticsDefaultWarning ctermfg=yellow
    highlight LspDiagnosticsDefaultInformation ctermfg=blue

    highlight LspDiagnosticsLineNrWarning ctermfg=yellow
    highlight LspDiagnosticsLineNrError ctermfg=red
    highlight LspDiagnosticsLineNrInformation ctermfg=green
    highlight LspDiagnosticsLineNrHint ctermfg=lightgray
  ]], false)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = "◀",
      },
    }
  )
EOF
