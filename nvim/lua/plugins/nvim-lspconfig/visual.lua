local utils = require("utils")

utils.highlight("LspDiagnosticsDefaultHint", "lightgray")
utils.highlight("LspDiagnosticsDefaultError", "red")
utils.highlight("LspDiagnosticsDefaultWarning", "yellow")
utils.highlight("LspDiagnosticsDefaultInformation", "blue")

utils.highlight("LspDiagnosticsLineNrHint", "lightgray")
utils.highlight("LspDiagnosticsLineNrError", "red")
utils.highlight("LspDiagnosticsLineNrWarning", "yellow")
utils.highlight("LspDiagnosticsLineNrInformation", "blue")

utils.sign_define("LspDiagnosticsSignError", "", nil, nil, "LspDiagnosticsLineNrError")
utils.sign_define("LspDiagnosticsSignWarning", "", nil, nil, "LspDiagnosticsLineNrWarning")
utils.sign_define("LspDiagnosticsSignInformation", "", nil, nil, "LspDiagnosticsLineNrInformation")
utils.sign_define("LspDiagnosticsSignHint", "", nil, nil, "LspDiagnosticsLineNrHint")
