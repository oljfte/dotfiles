local utils = require("utils")

local black =    "#171717"
local red =      "#ff453a"
local green =    "#30d158"
local yellow =   "#ffd60a"
local blue =     "#0a84ff"
local magenta =  "#bf5af2"
local cyan =     "#64d2ff"
local white =    "#dbdbdb"
-- TODO
local lightgray = "#787880"
local darkgray = "#545458"

utils.highlight("Conceal", nil, "NONE", nil)
utils.highlight("Cursor", "NONE", "NONE", "reverse")
utils.highlight("CursorLineNr", "NONE", nil, nil)
utils.highlight("Directory", blue, nil, nil)
utils.highlight("DiffAdd", green, "NONE", nil)
utils.highlight("DiffDelete", red, "NONE", nil)
utils.highlight("DiffChange", green, "NONE", nil)
utils.highlight("DiffText", magenta, "NONE", nil)
utils.highlight("VertSplit", lightgray, darkgray, "NONE")
utils.highlight("Folded", lightgray, darkgray, nil)
utils.highlight("FoldColumn", lightgray, "NONE", nil)
utils.highlight("SignColumn", lightgray, "NONE", nil)
utils.highlight("IncSearch", blue, "Black", "reverse")
utils.highlight("LineNr", darkgray, "NONE", nil)
utils.highlight("MatchParen", nil, "NONE", "underline,bold")
utils.highlight("ModeMsg", green, nil, nil)
utils.highlight("MoreMsg", green, nil, nil)
utils.highlight("NonText", darkgray, "NONE", nil)
utils.highlight("Normal", white, "NONE", nil)
utils.highlight("InfoPopup", white, darkgray, nil)
utils.highlight("NormalFloat", white, darkgray, nil)
utils.highlight("PMenu", white, darkgray, nil)
utils.highlight("PMenuSel", white, darkgray, "reverse")
utils.highlight("PMenuSbar", darkgray, darkgray, nil)
utils.highlight("PMenuThumb", lightgray, darkgray, nil)
utils.highlight("Question", green, nil, nil)
utils.highlight("Search", black, yellow, nil)
utils.highlight("SpecialKey", lightgray, nil, nil)
utils.highlight("StatusLine", "NONE", white, nil)
utils.highlight("StatusLineNC", "NONE", white, nil)
utils.highlight("StatusLineTerm", "NONE", white, nil)
utils.highlight("StatusLineTermNC", "NONE", white, nil)
utils.highlight("TabLine", white, darkgray, nil)
utils.highlight("TabLineFill", darkgray, lightgray, nil)
utils.highlight("TabLineSel", nil, nil, "NONE")
utils.highlight("Title", magenta, nil, nil)
utils.highlight("Visual", white, lightgray, nil)
utils.highlight("VisualNOS", white, lightgray, nil)
utils.highlight("WarningMsg", red, "NONE", nil)
utils.highlight("WildMenu", white, darkgray, "reverse")
utils.highlight("Underlined", nil, nil, "underline")
utils.highlight("Ignore", darkgray, nil, nil)
utils.highlight("Error", black, red, nil)
utils.highlight("Todo", black, red, nil)
utils.highlight("Comment", lightgray, nil, nil)

utils.highlight("Constant", green, nil, nil)
utils.highlight_link("String", "Constant")
utils.highlight_link("Character", "Constant")
utils.highlight_link("Number", "Constant")
utils.highlight_link("Boolean", "Constant")
utils.highlight_link("Float", "Constant")

utils.highlight("ErrorMsg", black, red, nil)
utils.highlight_link("SpellBad", "ErrorMsg")
utils.highlight_link("SpellCap", "ErrorMsg")
utils.highlight_link("SpellRare", "ErrorMsg")
utils.highlight_link("SpellLocal", "ErrorMsg")
utils.highlight_link("NvimInternalError", "ErrorMsg")

utils.highlight("Identifier", yellow, nil, "NONE")
utils.highlight_link("Function", "Identifier")

utils.highlight("Statement", blue, nil, nil)
utils.highlight_link("Conditional", "Statement")
utils.highlight_link("Repeat", "Statement")
utils.highlight_link("Label", "Statement")
utils.highlight_link("Operator", "Statement")
utils.highlight_link("Keyword", "Statement")
utils.highlight_link("Exception", "Statement")

utils.highlight("PreProc", cyan, nil, nil)
utils.highlight_link("Include", "PreProc")
utils.highlight_link("Define", "PreProc")
utils.highlight_link("Macro", "PreProc")
utils.highlight_link("PreCondit", "PreProc")

utils.highlight("Type", magenta, nil, nil)
utils.highlight_link("StorageClass", "Type")
utils.highlight_link("Structure", "Type")
utils.highlight_link("Typedef", "Type")

utils.highlight("Special", red, nil, nil)
utils.highlight_link("SpecialChar", "Special")
utils.highlight_link("Tag", "Special")
utils.highlight_link("Delimiter", "Special")
utils.highlight_link("SpecialComment", "Special")
utils.highlight_link("Debug", "Special")

utils.highlight_link("EndOfBuffer", "NonText")
