" Icons for netrw's local, plain list view. Requires Vim 9 virtual text.
if exists('g:loaded_netrw_devicons') || !has('textprop') || !has('patch-9.0.0067')
  finish
endif
let g:loaded_netrw_devicons = 1

augroup netrw_devicons
  autocmd!
  autocmd FileType netrw call netrw_devicons#schedule()
  autocmd BufWinEnter,TextChanged,TextChangedI * if &filetype ==# 'netrw' | call netrw_devicons#refresh() | endif
augroup END
command! NetrwDeviconsRefresh call netrw_devicons#refresh()
