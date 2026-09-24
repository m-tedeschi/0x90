" Auto-detect job hunt dumps.
"
" Install:
"   mkdir -p ~/.vim/ftdetect
"   cp job-hunt/Vim/jobhunt-ftdetect.vim ~/.vim/ftdetect/jobhunt.vim
"
" Requires syntax file:
"   mkdir -p ~/.vim/syntax
"   cp job-hunt/Vim/jobhunt.vim ~/.vim/syntax/jobhunt.vim

augroup jobhunt_filetype
  autocmd!
  autocmd BufRead,BufNewFile jh-dump.log setfiletype jobhunt
  autocmd BufRead,BufNewFile */jh-dump.log setfiletype jobhunt
augroup END
