let s:color_map = {
	\'Black'       : 0,
	\'DarkRed'     : 1,
	\'DarkGreen'   : 2,
	\'DarkYellow'  : 3,
	\'DarkBlue'    : 4,
	\'DarkMagenta' : 5,
	\'DarkCyan'    : 6,
	\'LightGray'   : 7,
	\'DarkGray'    : 8,
	\'Red'         : 9,
	\'Green'       : 10,
	\'Yellow'      : 11,
	\'Blue'        : 12,
	\'Magenta'     : 13,
	\'Cyan'        : 14,
	\'Text'        : 15,
\}

fun! <SID>set_colors(group, fg, bg, attr)
	if !empty(a:fg)
		if type(a:fg) == 1
			exec "hi " . a:group . " guifg=" . a:fg . " ctermfg=" . get(s:color_map, a:fg)
		else
			exec "hi " . a:group . " guifg=" . a:fg . " ctermfg=" . a:fg
		endif
	endif

	if !empty(a:bg)
		if type(a:bg) == 1 && a:bg != 'NONE'
			exec "hi " . a:group . " guibg=" .  a:bg . " ctermbg=" . get(s:color_map, a:bg)
		else
			exec "hi " . a:group . " guibg=" . a:bg . " ctermbg=" . a:bg
		endif
	endif

	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr . " term=" . a:attr
	endif
endfun

hi clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "inheritor_nvim"

let s:bg           = 'Black'
let s:fg           = 'Text'

let s:darkgray     = 'DarkGray'
let s:lightgray    = 'LightGray'

let s:black        = 'Black'
let s:red          = 'Red'
let s:green        = 'Green'
let s:yellow       = 'Yellow'
let s:blue         = 'Blue'
let s:magenta      = 'Magenta'
let s:cyan         = 'Cyan'

let s:dimred       = 'DarkRed'
let s:dimgreen     = 'DarkGreen'
let s:dimyellow    = 'DarkYellow'
let s:dimblue      = 'DarkBlue'
let s:dimmagenta   = 'DarkMagenta'
let s:dimcyan      = 'DarkCyan'

call <SID>set_colors("ActiveWindow"  , "" , "NONE" , "")
call <SID>set_colors("InactiveWindow"  , "" , 8 , "")

call <SID>set_colors("ColorColumn"  , "" , s:darkgray , "")
call <SID>set_colors("CursorColumn" , "" , s:darkgray , "")
call <SID>set_colors("CursorLine" , "" , s:darkgray , "NONE")

call <SID>set_colors("Conceal"  , ""     , "NONE" , "")
call <SID>set_colors("Cursor"   , "NONE" , "NONE" , "reverse")
call <SID>set_colors("CursorIM" , ""     , ""     , "")

call <SID>set_colors("CursorLineNr" , "NONE" , s:darkgray      , "")
call <SID>set_colors("Directory"    , s:blue , ""         , "")
call <SID>set_colors("DiffAdd"      , s:dimgreen, "NONE", "")
call <SID>set_colors("DiffDelete"   , s:dimred,   "NONE", "")
call <SID>set_colors("DiffChange"   , s:dimcyan, "NONE", "")
call <SID>set_colors("DiffText"     , s:magenta, "NONE", "")

hi link EndOfBuffer NonText

call <SID>set_colors("ErrorMsg"   , s:black  , s:red    , "")

call <SID>set_colors("VertSplit"  , s:lightgray    , s:darkgray    , "NONE")

call <SID>set_colors("Folded"     , s:lightgray , s:darkgray    , "")
call <SID>set_colors("FoldColumn" , s:lightgray , s:darkgray    , "")
call <SID>set_colors("SignColumn" , s:lightgray , "NONE"        , "")

call <SID>set_colors("IncSearch"  , s:blue , "Black" , "reverse")
call <SID>set_colors("LineNr"     , s:lightgray, "NONE"  , "")
call <SID>set_colors("MatchParen" , ""             , "NONE"  , "underline,bold")
call <SID>set_colors("ModeMsg"    , s:green        , ""      , "")
call <SID>set_colors("MoreMsg"    , s:green        , ""      , "")
call <SID>set_colors("NonText"    , s:darkgray          , "NONE"      , "")

call <SID>set_colors("Normal" , s:fg , "NONE" , "")

call <SID>set_colors("InfoPopup", s:fg, s:darkgray, "")


call <SID>set_colors("PMenu"            , s:fg       , s:darkgray    , "")
call <SID>set_colors("PMenuSel"         , s:fg       , s:lightgray   , "")
call <SID>set_colors("PMenuSbar"        , s:fg       , s:darkgray    , "")
call <SID>set_colors("PMenuThumb"       , s:fg       , s:darkgray    , "")
call <SID>set_colors("Question"         , s:green    , ""            , "")
call <SID>set_colors("Search"           , s:black    , s:blue        , "")
call <SID>set_colors("SpecialKey"       , s:lightgray , ""            , "")
call <SID>set_colors("StatusLine"       , s:darkgray , s:fg          , "")
call <SID>set_colors("StatusLineNC"     , s:darkgray , s:fg          , "")
call <SID>set_colors("StatusLineTerm"   , s:darkgray , s:fg          , "")
call <SID>set_colors("StatusLineTermNC" , s:darkgray , s:fg          , "")
call <SID>set_colors("TabLine"          , s:fg       , s:darkgray    , "")
call <SID>set_colors("TabLineFill"      , s:darkgray , s:lightgray   , "")
call <SID>set_colors("TabLineSel"       , ""         , ""            , "NONE")
call <SID>set_colors("Title"            , s:magenta  , ""            , "")
call <SID>set_colors("Visual"           , ""         , s:lightgray       , "")
call <SID>set_colors("VisualNOS"        , ""         , s:lightgray       , "")
call <SID>set_colors("WarningMsg"       , s:red      , "NONE"        , "")
call <SID>set_colors("WildMenu"         , s:green    , s:darkgray    , "")

call <SID>set_colors("Underlined"       , ""         , ""             , "underline")
call <SID>set_colors("Ignore"           , s:darkgray      , ""             , "")
call <SID>set_colors("Error"            , s:black    , s:red          , "")
call <SID>set_colors("Todo"             , s:black   , s:red        , "NONE")

call <SID>set_colors("Comment", s:lightgray, "", "")

call <SID>set_colors("Constant", s:green, "", "")
hi link String    Constant
hi link Character Constant
hi link Number    Constant
hi link Boolean   Constant
hi link Float     Constant

hi link SpellBad ErrorMsg
hi link SpellCap ErrorMsg
hi link SpellRare ErrorMsg
hi link SpellLocal ErrorMsg
hi link NvimInternalError ErrorMsg

call <SID>set_colors("Identifier", s:yellow, "", "NONE")

hi link Function Identifier

call <SID>set_colors("Statement", s:blue, "", "")
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement

call <SID>set_colors("PreProc", s:cyan, "", "")
hi link Include   PreProc
hi link Define    PreProc
hi link Macro     PreProc
hi link PreCondit PreProc

call <SID>set_colors("Type", s:magenta, "", "")
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type

call <SID>set_colors("Special", s:red, "", "")
hi link SpecialChar    Special
hi link Tag            Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special

delf <SID>set_colors
unlet s:darkgray s:lightgray s:bg s:fg s:blue s:yellow s:red s:green s:cyan s:magenta s:dimyellow s:dimred s:dimgreen s:dimcyan
