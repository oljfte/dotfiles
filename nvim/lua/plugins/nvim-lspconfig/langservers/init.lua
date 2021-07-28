-- Formatters
local formatter_dir = "plugins.nvim-lspconfig.langservers.formatter"

local black = require(formatter_dir..".".."black")
local isort = require(formatter_dir..".".."isort")
local prettier = require(formatter_dir..".".."prettier")

-- Linters
local linter_dir = "plugins.nvim-lspconfig.langservers.linter"

local flake8 = require(linter_dir..".".."flake8")
local mypy = require(linter_dir..".".."mypy")
local eslint = require(linter_dir..".".."eslint")

-- Languages
local language_configs = {
  python = {black, isort, flake8, mypy},
  typescript = {prettier, eslint},
  javascript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
}

-- Language Server Configs
return {
  efm = {
    init_options = { documentFormatting = true, codeAction = true },
    filetypes = vim.tbl_keys(language_configs),
    settings = { languages = language_configs },
  },
  pyright = {},
  clangd = {},
  tsserver = {}
}
