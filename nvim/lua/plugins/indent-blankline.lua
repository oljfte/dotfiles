return function()
  local utils = require("utils")
  utils.highlight("IndentBlanklineChar", "#303030", "NONE", nil)
  require("indent_blankline").setup {
      char = "▏",
  }
end
