" Auto-detect SpeedPrep problem board dumps.
"
" Install:
"   mkdir -p ~/.vim/ftdetect
"   cp SpeedPrep/problemboard-ftdetect.vim ~/.vim/ftdetect/problemboard.vim
"
" Requires syntax file:
"   mkdir -p ~/.vim/syntax
"   cp SpeedPrep/problemboard.vim ~/.vim/syntax/problemboard.vim

augroup problemboard_filetype
  autocmd!
  autocmd BufRead,BufNewFile pb-dump.log setfiletype problemboard
  autocmd BufRead,BufNewFile */pb-dump.log setfiletype problemboard
augroup END
