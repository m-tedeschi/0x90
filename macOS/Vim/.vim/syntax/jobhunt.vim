" Vim syntax highlighting for export.py jh-dump.log output.
"
" Usage in Vim:
"   :set syntax=jobhunt
"
" Optional install:
"   mkdir -p ~/.vim/syntax
"   cp job-hunt/Vim/jobhunt.vim ~/.vim/syntax/jobhunt.vim
"
" Optional auto-detect for jh-dump.log:
"   mkdir -p ~/.vim/ftdetect
"   cp job-hunt/Vim/jobhunt-ftdetect.vim ~/.vim/ftdetect/jobhunt.vim

if exists("b:current_syntax")
  finish
endif

syntax case match

syntax match jobHuntDivider /^=\{10,}$/
syntax match jobHuntEntry /^Entry \d\+ of \d\+/
syntax match jobHuntTitle /^.\+ | .\+ | \[.\+\]$/ contains=jobHuntStageSaved,jobHuntStageApplied,jobHuntStageScreen,jobHuntStageInterview,jobHuntStageFinal,jobHuntStageOffer,jobHuntStageAccepted,jobHuntStageRejected,jobHuntStageWithdrawn,jobHuntStageExpired
syntax match jobHuntUntitled /^Untitled Application.*$/

syntax match jobHuntLabel /^\(Application Date\|Last Touched\|Notes\):/
syntax match jobHuntHeaderLabel /\v(Status|Location):/
syntax match jobHuntDate /\v<\d{4}-\d{2}-\d{2}>/
syntax match jobHuntUrl /https\?:\/\/\S\+/

syntax match jobHuntStageSaved /\[Saved\]/ contained
syntax match jobHuntStageApplied /\[Applied\]/ contained
syntax match jobHuntStageScreen /\[\(Recruiter Screen\|Technical Screen\)\]/ contained
syntax match jobHuntStageInterview /\[Interview Loop\]/ contained
syntax match jobHuntStageFinal /\[Final Round\]/ contained
syntax match jobHuntStageOffer /\[Offer\]/ contained
syntax match jobHuntStageAccepted /\[Accepted\]/ contained
syntax match jobHuntStageRejected /\[Rejected\]/ contained
syntax match jobHuntStageWithdrawn /\[Withdrawn\]/ contained
syntax match jobHuntStageExpired /\[Expired\]/ contained

syntax match jobHuntStatusNotStarted /Not Started/ contained
syntax match jobHuntStatusActive /Active/ contained
syntax match jobHuntStatusWaiting /Waiting/ contained
syntax match jobHuntStatusFollowup /Needs Follow-up/ contained
syntax match jobHuntStatusScheduled /Scheduled/ contained
syntax match jobHuntStatusPaused /Paused/ contained
syntax match jobHuntStatusClosed /Closed/ contained
syntax match jobHuntLocation /Location: .*/ contains=jobHuntHeaderLabel

syntax match jobHuntStatusLine /^Status: .*$/ contains=jobHuntHeaderLabel,jobHuntStatusNotStarted,jobHuntStatusActive,jobHuntStatusWaiting,jobHuntStatusFollowup,jobHuntStatusScheduled,jobHuntStatusPaused,jobHuntStatusClosed,jobHuntLocation

highlight default link jobHuntDivider Comment
highlight default link jobHuntEntry Identifier
highlight default link jobHuntTitle Title
highlight default link jobHuntUntitled Title
highlight default link jobHuntLabel Type
highlight default link jobHuntHeaderLabel Type
highlight default link jobHuntDate Number
highlight default link jobHuntUrl Underlined

highlight default jobHuntStageSaved ctermfg=Cyan guifg=#58a6ff
highlight default jobHuntStageApplied ctermfg=LightBlue guifg=#79c0ff
highlight default jobHuntStageScreen ctermfg=Yellow guifg=#f2cc60
highlight default jobHuntStageInterview ctermfg=Magenta guifg=#bc8cff
highlight default jobHuntStageFinal ctermfg=LightMagenta guifg=#d2a8ff
highlight default jobHuntStageOffer ctermfg=Green cterm=bold guifg=#3fb950 gui=bold
highlight default jobHuntStageAccepted ctermfg=LightGreen cterm=bold guifg=#7ee787 gui=bold
highlight default jobHuntStageRejected ctermfg=DarkGray guifg=#8b949e
highlight default jobHuntStageWithdrawn ctermfg=DarkGray guifg=#8b949e
highlight default jobHuntStageExpired ctermfg=DarkGray guifg=#8b949e

highlight default jobHuntStatusNotStarted ctermfg=DarkGray guifg=#8b949e
highlight default jobHuntStatusActive ctermfg=Green guifg=#3fb950
highlight default jobHuntStatusWaiting ctermfg=Yellow guifg=#d29922
highlight default jobHuntStatusFollowup ctermfg=LightRed cterm=bold guifg=#ff7b72 gui=bold
highlight default jobHuntStatusScheduled ctermfg=Cyan guifg=#58a6ff
highlight default jobHuntStatusPaused ctermfg=Magenta guifg=#bc8cff
highlight default jobHuntStatusClosed ctermfg=DarkGray guifg=#8b949e
highlight default jobHuntLocation ctermfg=Blue guifg=#79c0ff

let b:current_syntax = "jobhunt"
