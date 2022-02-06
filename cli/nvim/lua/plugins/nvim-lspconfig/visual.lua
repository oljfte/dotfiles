local utils = require("utils")
local colors = require("colors")

utils.highlight("DiagnosticHint", colors.lightgray)
utils.highlight("DiagnosticError", colors.red)
utils.highlight("DiagnosticWarn", colors.yellow)
utils.highlight("DiagnosticInfo", colors.blue)

utils.highlight("DiagnosticLineNrHint", colors.lightgray)
utils.highlight("DiagnosticLineNrError", colors.red)
utils.highlight("DiagnosticLineNrWarn", colors.yellow)
utils.highlight("DiagnosticLineNrInfo", colors.blue)

utils.sign_define("DiagnosticSignError", "", nil, nil, "DiagnosticLineNrError")
utils.sign_define("DiagnosticSignWarn", "", nil, nil, "DiagnosticLineNrWarn")
utils.sign_define("DiagnosticSignInfo", "", nil, nil, "DiagnosticLineNrInfo")
utils.sign_define("DiagnosticSignHint", "", nil, nil, "DiagnosticLineNrHint")
