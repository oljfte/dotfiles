let s:black       = 0
let s:red         = 1
let s:green       = 2
let s:yellow      = 3
let s:blue        = 4
let s:magenta     = 5
let s:cyan        = 6
let s:dimfg       = 7
let s:bg          = 8
let s:fg          = 15

let s:p = {
			\ 'normal':   {},
			\ 'inactive': {},
			\ 'insert':   {},
			\ 'replace':  {},
			\ 'visual':   {},
			\ 'tabline':  {}}

" [[guifg, guibg, ctermfg, ctermbg], ...]
let s:p.normal.middle = [
			\ [s:fg, s:bg, s:fg, s:bg]]
let s:p.normal.left = [
			\ [s:fg, s:dimfg, s:fg, s:dimfg],
			\ [s:fg, s:bg, s:fg, s:bg]]
let s:p.normal.right = [
			\ [s:fg, s:dimfg, s:fg, s:dimfg],
			\ [s:fg, s:bg, s:fg, s:bg]]

let s:p.normal.error = [
			\ [s:black, s:red, s:black, s:red]]
let s:p.normal.warning = [
			\ [s:black, s:yellow, s:black, s:yellow]]

let s:p.insert.left = [
			\ [s:black, s:green, s:black, s:green],
			\ s:p.normal.left[1]]
let s:p.visual.left = [
			\ [s:black, s:blue, s:black, s:blue],
			\ s:p.normal.left[1]]
let s:p.replace.left = [
			\ [s:black, s:yellow, s:black, s:yellow],
			\ s:p.normal.left[1]]

let s:p.tabline.middlie = [
			\ [s:fg, s:bg, s:fg, s:bg]]
let s:p.tabline.right = [
			\ [s:fg, s:bg, s:fg, s:bg],
			\ [s:fg, s:bg, s:fg, s:bg]]
let s:p.tabline.left = [
			\ [s:dimfg, s:bg, s:dimfg, s:bg]]
let s:p.tabline.tabsel = [
			\ [s:fg, s:black, s:fg, s:black]]


let g:lightline#colorscheme#inheritor_lightline#palette = s:p
