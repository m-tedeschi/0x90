" Vim color scheme
"
" Name:       monochrome.vim
" Maintainer: Xavier Noria <fxn@hashref.com>
" License:    MIT

set background=dark

hi clear
if exists('syntax_on')
   syntax reset
endif

let g:colors_name = 'monochrome'

let s:white  = ['White', 15]
let s:black  = ['#0e1111', 16]
let s:bgray  = ['#181818', 233]
let s:lgray  = ['LightGray', 255]
let s:cgray  = ['#737373', 243]
let s:dgray  = ['DarkGray', 248]
let s:sblue  = ['#778899', 67]
let s:dblue  = ['#6f8798', 66]
let s:mblue  = ['#86aeca', 110]
let s:lblue  = ['#9fc6e6', 117]
let s:pblue  = ['#b8d4e8', 153]
let s:yellow = ['Yellow', 226]
let s:red    = ['#b6403a', 160]
let s:green  = ['#478226', 28]

let s:default_fg = s:lgray
let s:default_bg = s:black

let s:italic    = 'italic'
let s:bold      = 'bold'
let s:underline = 'underline'
let s:none      = 'NONE'

let s:default_lst = []
let s:default_str = ''

if !exists("g:monochrome_italic_comments")
  let g:monochrome_italic_comments = 0
endif
let s:comment_attr = g:monochrome_italic_comments ? s:italic : s:none

function! s:hi(...)
    let group = a:1
    let fg    = get(a:, 2, s:default_fg)
    let bg    = get(a:, 3, s:default_bg)
    let attr  = get(a:, 4, s:default_str)

    let cmd = ['hi', group]

    if fg != s:default_lst
        call add(cmd, 'guifg='.fg[0])
        call add(cmd, 'ctermfg='.fg[1])
    endif

    if bg != s:default_lst && bg != s:default_bg
        call add(cmd, 'guibg='.bg[0])
        call add(cmd, 'ctermbg='.bg[1])
    endif

    if attr != s:default_str
        call add(cmd, 'gui='.attr)
        call add(cmd, 'cterm='.attr)
    else
        call add(cmd, 'gui='.s:none)
        call add(cmd, 'cterm='.s:none)
    endif

    exec join(cmd, ' ')
endfunction


"
" --- Vim interface ------------------------------------------------------------
"

call s:hi('Normal')
call s:hi('Cursor', s:black, s:lgray)
call s:hi('CursorLine', s:default_lst, s:bgray, s:none)
call s:hi('CursorLineNr', s:white)
call s:hi('ColorColumn', s:default_fg, s:bgray)
call s:hi('Search', s:white, s:sblue)
call s:hi('Visual', s:white, s:sblue)
call s:hi('ErrorMsg', s:white, s:red)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:dgray)

" Folding.
call s:hi('FoldColumn', s:dgray)
call s:hi('Folded')

" Line numbers gutter.
call s:hi('LineNr', s:dgray)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:sblue)

" File browsers.
call s:hi('Directory', s:white, s:default_bg, s:none)
call s:hi('NERDTreeCWD', s:default_fg, s:default_bg, s:bold)

" Help.
call s:hi('helpSpecial')
call s:hi('helpHyperTextJump', s:sblue, s:default_bg, s:underline)
call s:hi('helpNote')

" Popup menu.
call s:hi('Pmenu', s:white, s:sblue)
call s:hi('PmenuSel', s:sblue, s:white)

" Notes.
call s:hi('Todo', s:black, s:yellow)

" Signs.
call s:hi('SignColumn')

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Statement', s:mblue)
call s:hi('Conditional', s:lblue)
call s:hi('Repeat', s:lblue)
call s:hi('Label', s:mblue)
call s:hi('Operator', s:cgray)
call s:hi('Keyword', s:lblue)
call s:hi('Exception', s:lblue)
call s:hi('PreProc', s:dblue)
call s:hi('Include', s:dblue)
call s:hi('Define', s:dblue)
call s:hi('Macro', s:dblue)
call s:hi('PreCondit', s:dblue)
call s:hi('String', s:sblue)
call s:hi('Character', s:sblue)
call s:hi('Comment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('Constant', s:mblue)
call s:hi('Number', s:mblue)
call s:hi('Boolean', s:mblue)
call s:hi('Float', s:mblue)
call s:hi('Type', s:pblue)
call s:hi('StorageClass', s:lblue)
call s:hi('Structure', s:lblue)
call s:hi('Typedef', s:pblue)
call s:hi('Function', s:lblue)
call s:hi('Identifier', s:default_fg, s:default_bg, s:bold)
call s:hi('Special', s:dblue)
call s:hi('SpecialChar', s:mblue)
call s:hi('Tag', s:dblue)
call s:hi('Delimiter', s:cgray)
call s:hi('SpecialComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('Debug', s:red)
call s:hi('MatchParen', s:lgray, s:black, s:underline)


"
" --- Swift --------------------------------------------------------------------
"

call s:hi('swiftKeyword', s:lblue)
call s:hi('swiftMultiwordKeyword', s:lblue)
call s:hi('swiftImport', s:dblue)
call s:hi('swiftImportModule', s:default_fg)
call s:hi('swiftImportComponent', s:default_fg)
call s:hi('swiftDefinitionModifier', s:dblue)
call s:hi('swiftInOutKeyword', s:lblue)
call s:hi('swiftTypeName', s:pblue)
call s:hi('swiftIdentifierKeyword', s:mblue)
call s:hi('swiftFuncKeywordGeneral', s:lblue)
call s:hi('swiftFuncKeyword', s:lblue)
call s:hi('swiftFuncDefinition', s:dblue)
call s:hi('swiftTypeDefinition', s:lblue)
call s:hi('swiftMultiwordTypeDefinition', s:lblue)
call s:hi('swiftTypeAliasDefinition', s:lblue)
call s:hi('swiftTypeAliasName', s:pblue)
call s:hi('swiftVarDefinition', s:dblue)
call s:hi('swiftVarName', s:default_fg, s:default_bg, s:bold)
call s:hi('swiftLabel', s:dblue)
call s:hi('swiftBoolean', s:mblue)
call s:hi('swiftNil', s:mblue)
call s:hi('swiftType', s:pblue)
call s:hi('swiftTypePair', s:pblue)
call s:hi('swiftCoreTypes', s:pblue)
call s:hi('swiftOperator', s:cgray)
call s:hi('swiftCastOp', s:dblue)
call s:hi('swiftNilOps', s:cgray)
call s:hi('swiftTypeParameters', s:cgray)
call s:hi('swiftTypeDeclaration', s:cgray)
call s:hi('swiftTypeAliasValue', s:cgray)
call s:hi('swiftParamDelim', s:cgray)
call s:hi('swiftConstraint', s:lblue)
call s:hi('swiftString', s:sblue)
call s:hi('swiftInterpolation', s:mblue)
call s:hi('swiftChar', s:sblue)
call s:hi('swiftComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('swiftLineComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('swiftTodo', s:black, s:yellow)
call s:hi('swiftDecimal', s:mblue)
call s:hi('swiftHex', s:mblue)
call s:hi('swiftOct', s:mblue)
call s:hi('swiftBin', s:mblue)
call s:hi('swiftTupleIndexNumber', s:mblue)
call s:hi('swiftPreproc', s:dblue)
call s:hi('swiftPreprocFalse', s:cgray)
call s:hi('swiftAttribute', s:mblue)
call s:hi('swiftReservedIdentifier', s:default_fg, s:default_bg, s:bold)
call s:hi('swiftImplicitVarName', s:default_fg, s:default_bg, s:bold)

"
" --- C / C++ ------------------------------------------------------------------
"

call s:hi('cStatement', s:lblue)
call s:hi('cConditional', s:lblue)
call s:hi('cRepeat', s:lblue)
call s:hi('cLabel', s:dblue)
call s:hi('cUserLabel', s:default_fg)
call s:hi('cOperator', s:cgray)
call s:hi('cType', s:pblue)
call s:hi('cTypedef', s:lblue)
call s:hi('cStructure', s:lblue)
call s:hi('cStorageClass', s:dblue)
call s:hi('cConstant', s:mblue)
call s:hi('cNumber', s:mblue)
call s:hi('cFloat', s:mblue)
call s:hi('cOctal', s:mblue)
call s:hi('cOctalZero', s:mblue)
call s:hi('cCharacter', s:sblue)
call s:hi('cSpecialCharacter', s:mblue)
call s:hi('cString', s:sblue)
call s:hi('cCppString', s:sblue)
call s:hi('cFormat', s:mblue)
call s:hi('cSpecial', s:mblue)
call s:hi('cInclude', s:dblue)
call s:hi('cIncluded', s:default_fg)
call s:hi('cDefine', s:dblue)
call s:hi('cPreProc', s:dblue)
call s:hi('cPreCondit', s:dblue)
call s:hi('cPreConditMatch', s:dblue)
call s:hi('cComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('cCommentL', s:cgray, s:default_bg, s:comment_attr)
call s:hi('cCommentStart', s:cgray)
call s:hi('cTodo', s:black, s:yellow)

call s:hi('cppStatement', s:lblue)
call s:hi('cppAccess', s:dblue)
call s:hi('cppModifier', s:dblue)
call s:hi('cppType', s:pblue)
call s:hi('cppExceptions', s:lblue)
call s:hi('cppOperator', s:cgray)
call s:hi('cppCast', s:dblue)
call s:hi('cppStorageClass', s:dblue)
call s:hi('cppStructure', s:lblue)
call s:hi('cppBoolean', s:mblue)
call s:hi('cppConstant', s:mblue)
call s:hi('cppNumber', s:mblue)
call s:hi('cppFloat', s:mblue)
call s:hi('cppString', s:sblue)
call s:hi('cppRawString', s:sblue)
call s:hi('cppRawStringDelimiter', s:cgray)
call s:hi('cppCharacter', s:sblue)
call s:hi('cppSpecialCharacter', s:mblue)
call s:hi('cppModule', s:dblue)
call s:hi('cppMinMax', s:cgray)

"
" --- Python -------------------------------------------------------------------
"

call s:hi('pythonStatement', s:lblue)
call s:hi('pythonConditional', s:lblue)
call s:hi('pythonRepeat', s:lblue)
call s:hi('pythonOperator', s:cgray)
call s:hi('pythonException', s:lblue)
call s:hi('pythonInclude', s:dblue)
call s:hi('pythonAsync', s:lblue)
call s:hi('pythonFunction', s:lblue)
call s:hi('pythonBuiltin', s:pblue)
call s:hi('pythonBuiltinObj', s:mblue)
call s:hi('pythonDecorator', s:cgray)
call s:hi('pythonDecoratorName', s:mblue)
call s:hi('pythonAttribute', s:mblue)
call s:hi('pythonEscape', s:mblue)
call s:hi('pythonString', s:sblue)
call s:hi('pythonRawString', s:sblue)
call s:hi('pythonQuotes', s:cgray)
call s:hi('pythonNumber', s:mblue)
call s:hi('pythonDoctest', s:cgray)
call s:hi('pythonDoctestValue', s:default_fg)
call s:hi('pythonComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('pythonTodo', s:black, s:yellow)
call s:hi('pythonExceptions', s:pblue)

"
" --- JavaScript ---------------------------------------------------------------
"

call s:hi('javaScriptFunction', s:dblue)
call s:hi('javaScriptConditional', s:lblue)
call s:hi('javaScriptRepeat', s:lblue)
call s:hi('javaScriptBranch', s:lblue)
call s:hi('javaScriptOperator', s:cgray)
call s:hi('javaScriptType', s:pblue)
call s:hi('javaScriptStatement', s:lblue)
call s:hi('javaScriptBoolean', s:mblue)
call s:hi('javaScriptNull', s:mblue)
call s:hi('javaScriptIdentifier', s:mblue)
call s:hi('javaScriptLabel', s:dblue)
call s:hi('javaScriptException', s:lblue)
call s:hi('javaScriptMessage', s:pblue)
call s:hi('javaScriptGlobal', s:pblue)
call s:hi('javaScriptMember', s:mblue)
call s:hi('javaScriptDeprecated', s:cgray)
call s:hi('javaScriptReserved', s:dblue)
call s:hi('javaScriptModifier', s:dblue)
call s:hi('javaScriptBraces', s:cgray)
call s:hi('javaScriptParens', s:cgray)
call s:hi('javaScriptStringD', s:sblue)
call s:hi('javaScriptStringS', s:sblue)
call s:hi('javaScriptStringT', s:sblue)
call s:hi('javaScriptRegexpString', s:sblue)
call s:hi('javaScriptSpecial', s:mblue)
call s:hi('javaScriptSpecialCharacter', s:mblue)
call s:hi('javaScriptEmbed', s:mblue)
call s:hi('javaScriptNumber', s:mblue)
call s:hi('javaScriptLineComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('javaScriptComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('javaScriptCommentTodo', s:black, s:yellow)

"
" --- Shell --------------------------------------------------------------------
"

call s:hi('shStatement', s:lblue)
call s:hi('bashStatement', s:lblue)
call s:hi('bashAdminStatement', s:lblue)
call s:hi('shConditional', s:lblue)
call s:hi('shLoop', s:lblue)
call s:hi('shIf', s:lblue)
call s:hi('shFor', s:lblue)
call s:hi('shRepeat', s:lblue)
call s:hi('shCaseEsac', s:lblue)
call s:hi('shCaseIn', s:lblue)
call s:hi('shFunction', s:lblue)
call s:hi('shFunctionKey', s:dblue)
call s:hi('shFunctionOne', s:lblue)
call s:hi('shFunctionTwo', s:lblue)
call s:hi('shFunctionThree', s:lblue)
call s:hi('shFunctionFour', s:lblue)
call s:hi('shSet', s:dblue)
call s:hi('shSetList', s:dblue)
call s:hi('shVariable', s:default_fg, s:default_bg, s:bold)
call s:hi('shVar', s:default_fg, s:default_bg, s:bold)
call s:hi('shDeref', s:mblue)
call s:hi('shDerefSimple', s:mblue)
call s:hi('shDerefVar', s:mblue)
call s:hi('shDerefSpecial', s:mblue)
call s:hi('bashSpecialVariables', s:mblue)
call s:hi('shShellVariables', s:mblue)
call s:hi('shOperator', s:cgray)
call s:hi('shTestOpr', s:cgray)
call s:hi('shRedir', s:cgray)
call s:hi('shHereString', s:cgray)
call s:hi('shNumber', s:mblue)
call s:hi('shSingleQuote', s:sblue)
call s:hi('shDoubleQuote', s:sblue)
call s:hi('shExSingleQuote', s:sblue)
call s:hi('shExDoubleQuote', s:sblue)
call s:hi('shStringSpecial', s:mblue)
call s:hi('shSpecial', s:mblue)
call s:hi('shSpecialDQ', s:mblue)
call s:hi('shSpecialSQ', s:mblue)
call s:hi('shSpecialNoZS', s:mblue)
call s:hi('shCtrlSeq', s:mblue)
call s:hi('shCommandSub', s:mblue)
call s:hi('shCommandSubBQ', s:mblue)
call s:hi('shCmdSubRegion', s:cgray)
call s:hi('shArithRegion', s:cgray)
call s:hi('shDblBrace', s:cgray)
call s:hi('shDblParen', s:cgray)
call s:hi('shQuote', s:cgray)
call s:hi('shComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('shQuickComment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('shTodo', s:black, s:yellow)


"
" --- VimL ---------------------------------------------------------------------
"

call s:hi('vimOption')
call s:hi('vimGroup')
call s:hi('vimHiClear')
call s:hi('vimHiGroup')
call s:hi('vimHiAttrib')
call s:hi('vimHiGui')
call s:hi('vimHiGuiFgBg')
call s:hi('vimHiCTerm')
call s:hi('vimHiCTermFgBg')
call s:hi('vimSynType')
hi link vimCommentTitle Comment


"
" --- Ruby ---------------------------------------------------------------------
"

call s:hi('rubyConstant')
call s:hi('rubySharpBang', s:cgray)
call s:hi('rubySymbol', s:sblue)
call s:hi('rubyStringDelimiter', s:sblue)
call s:hi('rubyStringEscape', s:sblue)
call s:hi('rubyRegexpEscape', s:sblue)
call s:hi('rubyRegexpAnchor', s:sblue)
call s:hi('rubyRegexpSpecial', s:sblue)


"
" --- Elixir -------------------------------------------------------------------
"

call s:hi('elixirAlias', s:default_fg, s:default_bg, s:none)
call s:hi('elixirDelimiter', s:sblue)
call s:hi('elixirSelf', s:default_fg, s:default_bg, s:none)

" For ||, ->, etc.
call s:hi('elixirOperator')

" Module attributes like @doc or @type.
hi link elixirVariable Statement

" While rendered as comments in other languages, docstrings are strings,
" experimental.
hi link elixirDocString String
hi link elixirDocTest String
hi link elixirStringDelimiter String


"
" --- Perl ---------------------------------------------------------------------
"

call s:hi('perlSharpBang', s:cgray)
call s:hi('perlStringStartEnd', s:sblue)
call s:hi('perlStringEscape', s:sblue)
call s:hi('perlMatchStartEnd', s:sblue)


"
" --- Diffs --------------------------------------------------------------------
"

call s:hi('diffFile', s:cgray)
call s:hi('diffNewFile', s:cgray)
call s:hi('diffIndexLine', s:cgray)
call s:hi('diffLine', s:cgray)
call s:hi('diffSubname', s:cgray)
call s:hi('diffAdded', s:white, s:green)
call s:hi('diffRemoved', s:white, s:red)


"
" --- Markdown -----------------------------------------------------------------
"

call s:hi('Title', s:lblue)
call s:hi('htmlH1', s:lblue)
call s:hi('htmlH2', s:lblue)
call s:hi('htmlH3', s:lblue)
call s:hi('htmlH4', s:lblue)
call s:hi('htmlH5', s:lblue)
call s:hi('htmlH6', s:lblue)
call s:hi('markdownH1', s:lblue)
call s:hi('markdownH2', s:lblue)
call s:hi('markdownH3', s:lblue)
call s:hi('markdownH4', s:lblue)
call s:hi('markdownH5', s:lblue)
call s:hi('markdownH6', s:lblue)
call s:hi('markdownH1Delimiter', s:cgray)
call s:hi('markdownH2Delimiter', s:cgray)
call s:hi('markdownH3Delimiter', s:cgray)
call s:hi('markdownH4Delimiter', s:cgray)
call s:hi('markdownH5Delimiter', s:cgray)
call s:hi('markdownH6Delimiter', s:cgray)
call s:hi('markdownHeadingDelimiter', s:cgray)
call s:hi('markdownHeadingRule', s:cgray)
call s:hi('markdownRule', s:cgray)
call s:hi('markdownBlockquote', s:cgray)
call s:hi('markdownListMarker', s:sblue)
call s:hi('markdownOrderedListMarker', s:sblue)
call s:hi('markdownCode', s:sblue)
call s:hi('markdownCodeBlock', s:cgray)
call s:hi('markdownCodeDelimiter', s:cgray)
call s:hi('markdownLinkText', s:sblue, s:default_bg, s:underline)
call s:hi('markdownLinkTextDelimiter', s:cgray)
call s:hi('markdownLinkDelimiter', s:cgray)
call s:hi('markdownUrl', s:cgray, s:default_bg, s:underline)
call s:hi('markdownUrlDelimiter', s:cgray)
call s:hi('markdownUrlTitle', s:default_fg)
call s:hi('markdownUrlTitleDelimiter', s:cgray)
call s:hi('markdownId', s:cgray)
call s:hi('markdownIdDelimiter', s:cgray)
call s:hi('markdownIdDeclaration', s:cgray)
call s:hi('markdownAutomaticLink', s:sblue, s:default_bg, s:underline)
call s:hi('markdownItalic', s:default_fg, s:default_bg, s:italic)
call s:hi('markdownItalicDelimiter', s:cgray)
call s:hi('markdownBold', s:default_fg)
call s:hi('markdownBoldDelimiter', s:cgray)
call s:hi('markdownBoldItalic', s:default_fg, s:default_bg, s:italic)
call s:hi('markdownBoldItalicDelimiter', s:cgray)
call s:hi('markdownStrike', s:cgray)
call s:hi('markdownStrikeDelimiter', s:cgray)
call s:hi('markdownEscape', s:sblue)
call s:hi('markdownLineBreak', s:dgray, s:default_bg, s:underline)
call s:hi('markdownFootnote', s:sblue)
call s:hi('markdownFootnoteDefinition', s:sblue)
call s:hi('markdownYamlHead', s:cgray)
call s:hi('markdownError', s:red)


"
" --- vim-fugitive -------------------------------------------------------------
"

call s:hi('gitcommitComment', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitOnBranch', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitBranch', s:sblue, s:default_bg, s:none)
call s:hi('gitcommitHeader', s:white)
call s:hi('gitcommitSelected', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscarded', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitSelectedType', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscardedType', s:default_fg, s:default_bg, s:none)


"
" --- NeoMake ------------------------------------------------------------------
"

call s:hi('NeomakeMessageSign')
call s:hi('NeomakeWarningSign', s:sblue)
call s:hi('NeomakeErrorSign', s:yellow)
call s:hi('NeomakeInfoSign')
call s:hi('NeomakeError', s:yellow)
call s:hi('NeomakeInfo')
call s:hi('NeomakeMessage')
call s:hi('NeomakeWarning', s:yellow)
