local utils = require("utils")
local colors = require("colors")

utils.highlight("LspDiagnosticsDefaultHint", colors.lightgray)
utils.highlight("LspDiagnosticsDefaultError", colors.red)
utils.highlight("LspDiagnosticsDefaultWarning", colors.yellow)
utils.highlight("LspDiagnosticsDefaultInformation", colors.blue)

utils.highlight("LspDiagnosticsLineNrHint", colors.lightgray)
utils.highlight("LspDiagnosticsLineNrError", colors.red)
utils.highlight("LspDiagnosticsLineNrWarning", colors.yellow)
utils.highlight("LspDiagnosticsLineNrInformation", colors.blue)

utils.sign_define("LspDiagnosticsSignError", "", nil, nil, "LspDiagnosticsLineNrError")
utils.sign_define("LspDiagnosticsSignWarning", "", nil, nil, "LspDiagnosticsLineNrWarning")
utils.sign_define("LspDiagnosticsSignInformation", "", nil, nil, "LspDiagnosticsLineNrInformation")
utils.sign_define("LspDiagnosticsSignHint", "", nil, nil, "LspDiagnosticsLineNrHint")
