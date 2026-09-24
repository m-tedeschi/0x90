" Vim syntax highlighting for SpeedPrep/export.py pb-dump.log output.
"
" Usage in Vim:
"   :set syntax=problemboard
"
" Optional install:
"   mkdir -p ~/.vim/syntax
"   cp SpeedPrep/problemboard.vim ~/.vim/syntax/problemboard.vim
"
" Optional auto-detect for pb-dump.log:
"   mkdir -p ~/.vim/ftdetect
"   cp SpeedPrep/problemboard-ftdetect.vim ~/.vim/ftdetect/problemboard.vim

if exists("b:current_syntax")
  finish
endif

syntax case match

syntax match problemBoardDivider /^=\{10,}$/
syntax match problemBoardEntry /^Entry \d\+ of \d\+/
syntax match problemBoardTitle /^\d\+\.\s.*$/ contains=problemBoardEasy,problemBoardMedium,problemBoardHard
syntax match problemBoardUntitled /^Untitled Problem.*$/

syntax match problemBoardLabel /^\(Solve Date\|Time\|(Last Solved)\|Space\|Link\|Video\|Notes\):/
syntax match problemBoardComplexity /O([^)]*)/
syntax match problemBoardUrl /https\?:\/\/\S\+/

syntax match problemBoardEasy /\[Easy\]/ contained
syntax match problemBoardMedium /\[Medium\]/ contained
syntax match problemBoardHard /\[Hard\]/ contained

syntax match problemBoardHeaderLabel /\v(Status|Pattern):/

syntax match problemBoardStatusAttempting /Attempting/ contained
syntax match problemBoardStatusSolved /Solved/ contained
syntax match problemBoardStatusNeedsReview /Needs Review/ contained
syntax match problemBoardStatusRedo /Redo/ contained
syntax match problemBoardStatusMastered /Mastered/ contained
syntax match problemBoardPatternValue /\v(Hash Map|Two Pointers|Sliding Window)/ contained

syntax match problemBoardStatusLine /^Status: .*$/ contains=problemBoardHeaderLabel,problemBoardStatusAttempting,problemBoardStatusSolved,problemBoardStatusNeedsReview,problemBoardStatusRedo,problemBoardStatusMastered,problemBoardPatternValue

highlight default link problemBoardDivider Comment
highlight default link problemBoardEntry Identifier
highlight default link problemBoardTitle Title
highlight default link problemBoardUntitled Title
highlight default link problemBoardLabel Type
highlight default link problemBoardHeaderLabel Type
highlight default link problemBoardComplexity Number
highlight default link problemBoardUrl Underlined

highlight default problemBoardEasy ctermfg=LightGreen guifg=#7ee787
highlight default problemBoardMedium ctermfg=Yellow guifg=#f2cc60
highlight default problemBoardHard ctermfg=LightRed guifg=#ff5555

highlight default problemBoardStatusAttempting ctermfg=Cyan guifg=#58a6ff
highlight default problemBoardStatusSolved ctermfg=Green guifg=#3fb950
highlight default problemBoardStatusNeedsReview ctermfg=Yellow guifg=#d29922
highlight default problemBoardStatusRedo ctermfg=Magenta guifg=#bc8cff
highlight default problemBoardStatusMastered ctermfg=Green cterm=bold guifg=#3fb950 gui=bold

highlight default problemBoardPatternValue ctermfg=Blue guifg=#79c0ff

let b:current_syntax = "problemboard"
