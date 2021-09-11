-- Formatters
local formatter_dir = "plugins.nvim-lspconfig.langservers.formatter"

local black = require(formatter_dir..".".."black")
local isort = require(formatter_dir..".".."isort")
local prettier = require(formatter_dir..".".."prettier")
local rubocop_format = require(formatter_dir..".".."rubocop")
local eslint_format = require(formatter_dir..".".."eslint")

-- Linters
local linter_dir = "plugins.nvim-lspconfig.langservers.linter"

local flake8 = require(linter_dir..".".."flake8")
local mypy = require(linter_dir..".".."mypy")
local eslint_lint = require(linter_dir..".".."eslint")
local rubocop_lint = require(linter_dir..".".."rubocop")

-- Languages
local language_configs = {
  python = {black, isort, flake8, mypy},
  typescript = {prettier, eslint_lint, eslint_format},
  javascript = {prettier, eslint_lint, eslint_format},
  typescriptreact = {prettier, eslint_lint, eslint_format},
  javascriptreact = {prettier, eslint_lint, eslint_format},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
  ruby = {rubocop_format, rubocop_lint},
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
  tsserver = {},
  solargraph = {},
  denols = {}
}
