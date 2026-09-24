" tiny-rg.vim - minimal ripgrep quickfix search
" Drop this file into ~/.vim/pack/tiny-rg/start/tiny-rg/plugin/tiny_rg.vim

if exists('g:loaded_tiny_rg')
  finish
endif
let g:loaded_tiny_rg = 1

let g:tiny_rg_command = get(g:, 'tiny_rg_command', 'rg')
let g:tiny_rg_args = get(g:, 'tiny_rg_args', [
      \ '--vimgrep',
      \ '--smart-case',
      \ '--hidden',
      \ '--glob', '!.git/*',
      \ ])
let g:tiny_rg_auto_open_quickfix = get(g:, 'tiny_rg_auto_open_quickfix', 0)
let g:tiny_rg_jump_to_first = get(g:, 'tiny_rg_jump_to_first', 1)
let g:tiny_rg_height = get(g:, 'tiny_rg_height', 10)
let g:tiny_rg_quickfix_name = get(g:, 'tiny_rg_quickfix_name', '[TinyRg Quickfix]')
let s:last_result_bufnr = 0
let s:protected_bufnrs = {}

function! s:ShellJoin(parts) abort
  return join(map(copy(a:parts), 'shellescape(v:val)'), ' ')
endfunction

function! s:RegexEscape(text) abort
  return escape(a:text, '\.^$*+?()[]{}|')
endfunction

function! s:BuildCommand(pattern) abort
  return s:ShellJoin([g:tiny_rg_command] + g:tiny_rg_args + [a:pattern])
endfunction

function! s:ParseVimgrepLine(line) abort
  let l:match = matchlist(a:line, '^\(.\{-}\):\(\d\+\):\(\d\+\):\(.*\)$')
  if empty(l:match)
    return {}
  endif

  return {
        \ 'filename': l:match[1],
        \ 'lnum': str2nr(l:match[2]),
        \ 'col': str2nr(l:match[3]),
        \ 'text': l:match[4],
        \ }
endfunction

function! s:IsEditWindow(window) abort
  let l:buftype = getwinvar(a:window, '&buftype')
  let l:filetype = getwinvar(a:window, '&filetype')
  let l:bufname = bufname(winbufnr(a:window))
  return l:buftype ==# ''
        \ && l:filetype !=# 'nerdtree'
        \ && l:bufname !~# 'NERD_tree'
endfunction

function! s:IsNerdTreeWindow(window) abort
  let l:filetype = getwinvar(a:window, '&filetype')
  let l:bufname = bufname(winbufnr(a:window))
  return l:filetype ==# 'nerdtree' || l:bufname =~# 'NERD_tree'
endfunction

function! s:FindEditWindow() abort
  if s:IsEditWindow(winnr())
    return win_getid()
  endif

  for l:window in range(1, winnr('$'))
    if s:IsEditWindow(l:window)
      return win_getid(l:window)
    endif
  endfor

  return 0
endfunction

function! s:InstallQuickfixMappings() abort
  let b:tiny_rg_quickfix = 1
  let b:tiny_rg_quickfix_name = g:tiny_rg_quickfix_name
  silent! execute 'file ' . fnameescape(g:tiny_rg_quickfix_name)
  nnoremap <silent><buffer> <CR> :call <SID>OpenSelectedQuickfixItem(0, 0)<CR>
  nnoremap <silent><buffer> o :call <SID>OpenSelectedQuickfixItem(0, 0)<CR>
  nnoremap <silent><buffer> <Tab> :call <SID>MoveAndOpenQuickfixItem(1)<CR>
  nnoremap <silent><buffer> <S-Tab> :call <SID>MoveAndOpenQuickfixItem(-1)<CR>
  nnoremap <silent><buffer> q :cclose<CR>
endfunction

function! s:OpenQuickfix(focus, target_winid) abort
  if a:target_winid > 0 && win_id2win(a:target_winid) > 0
    call win_gotoid(a:target_winid)
  endif
  execute 'botright ' . g:tiny_rg_height . 'copen'
  call s:InstallQuickfixMappings()
  if !a:focus
    wincmd p
  endif
endfunction

function! s:SetQuickfixIndex(index) abort
  call setqflist([], 'a', {'idx': a:index})
endfunction

function! s:RememberProtectedBuffers() abort
  let s:protected_bufnrs = {}
  for l:bufnr in range(1, bufnr('$'))
    if buflisted(l:bufnr)
      let s:protected_bufnrs[l:bufnr] = 1
    endif
  endfor
endfunction

function! s:ForgetResultBuffer(bufnr) abort
  if a:bufnr <= 0 || has_key(s:protected_bufnrs, a:bufnr)
    return
  endif
  if !bufexists(a:bufnr) || getbufvar(a:bufnr, '&modified')
    return
  endif
  if bufwinnr(a:bufnr) != -1
    return
  endif

  call setbufvar(a:bufnr, '&buflisted', 0)
endfunction

function! s:IsCurrentTinyRgResultBuffer() abort
  if &buftype !=# ''
    return 0
  endif

  let l:info = getqflist({'title': 0, 'items': 0})
  if l:info.title !~# '^TinyRg: '
    return 0
  endif

  let l:bufnr = bufnr('%')
  for l:item in l:info.items
    if get(l:item, 'bufnr', -1) == l:bufnr
      return 1
    endif
  endfor

  return 0
endfunction

function! s:TrackTinyRgResultBuffer() abort
  if !s:IsCurrentTinyRgResultBuffer()
    return
  endif

  let l:current_bufnr = bufnr('%')
  if s:last_result_bufnr != l:current_bufnr
    call s:ForgetResultBuffer(s:last_result_bufnr)
    let s:last_result_bufnr = l:current_bufnr
  endif
endfunction

function! s:SyncQuickfixIndexFromCursor() abort
  if &buftype !=# 'quickfix' || !get(b:, 'tiny_rg_quickfix', 0)
    return
  endif

  let l:index = line('.')
  if l:index >= 1 && l:index <= len(getqflist())
    call s:SetQuickfixIndex(l:index)
  endif
endfunction

function! s:OpenSelectedQuickfixItem(reopen_quickfix, preview) abort
  let l:index = line('.')
  let l:items = getqflist()
  if l:index < 1 || l:index > len(l:items)
    return
  endif

  let l:item = l:items[l:index - 1]
  if !has_key(l:item, 'bufnr') || l:item.bufnr <= 0
    return
  endif

  call s:SetQuickfixIndex(l:index)
  execute 'cc ' . l:index

  if a:preview
    call s:TrackTinyRgResultBuffer()
  endif

  if a:reopen_quickfix
    execute 'botright ' . g:tiny_rg_height . 'copen'
    call s:InstallQuickfixMappings()
    call cursor(l:index, 1)
  endif
endfunction

function! s:MoveAndOpenQuickfixItem(delta) abort
  let l:count = len(getqflist())
  if l:count == 0
    return
  endif

  let l:next = line('.') + a:delta
  if l:next < 1
    let l:next = l:count
  elseif l:next > l:count
    let l:next = 1
  endif

  call cursor(l:next, 1)
  call s:OpenSelectedQuickfixItem(1, 1)
endfunction

function! s:Search(pattern, jump, focus_quickfix) abort
  let l:target_winid = s:FindEditWindow()
  call s:ForgetResultBuffer(s:last_result_bufnr)
  let s:last_result_bufnr = 0
  call s:RememberProtectedBuffers()
  let l:pattern = trim(a:pattern)
  if empty(l:pattern)
    echohl WarningMsg
    echom 'TinyRg: search pattern is empty'
    echohl None
    return
  endif

  let l:lines = systemlist(s:BuildCommand(l:pattern))
  let l:status = v:shell_error

  if l:status > 1
    echohl ErrorMsg
    echom 'TinyRg: rg failed'
    for l:line in l:lines[:4]
      echom l:line
    endfor
    echohl None
    return
  endif

  let l:items = []
  for l:line in l:lines
    let l:item = s:ParseVimgrepLine(l:line)
    if !empty(l:item)
      call add(l:items, l:item)
    endif
  endfor

  call setqflist([], 'r', {
        \ 'title': 'TinyRg: ' . l:pattern,
        \ 'items': l:items,
        \ })

  if empty(l:items)
    cclose
    echom 'TinyRg: no matches for ' . string(l:pattern)
    return
  endif

  if g:tiny_rg_auto_open_quickfix
    call s:OpenQuickfix(a:focus_quickfix, l:target_winid)
  endif
  if a:jump && g:tiny_rg_jump_to_first
    silent! cfirst
    call s:TrackTinyRgResultBuffer()
  endif
  echom 'TinyRg: ' . len(l:items) . ' match(es)'
endfunction

function! s:SearchStay(pattern) abort
  let l:view = winsaveview()
  let l:window = winnr()
  call s:Search(a:pattern, 0, 0)
  if winnr('$') >= l:window
    execute l:window . 'wincmd w'
  endif
  call winrestview(l:view)
endfunction

function! s:SearchWordUnderCursor() abort
  let l:word = expand('<cword>')
  if empty(l:word)
    echohl WarningMsg
    echom 'TinyRg: no word under cursor'
    echohl None
    return
  endif

  call s:Search('\b' . s:RegexEscape(l:word) . '\b', 1, 0)
endfunction

function! s:ToggleQuickfix() abort
  for l:win in range(1, winnr('$'))
    if getwinvar(l:win, '&buftype') ==# 'quickfix'
      cclose
      return
    endif
  endfor
  call s:OpenQuickfix(1, s:FindEditWindow())
endfunction

command! -nargs=+ RG call s:Search(<q-args>, 1, 0)
command! -nargs=+ RGgo call s:Search(<q-args>, 1, 0)
command! -nargs=+ RGStay call s:SearchStay(<q-args>)
command! RGWord call s:SearchWordUnderCursor()
command! RGOpen call s:OpenQuickfix(1, s:FindEditWindow())
command! RGClose cclose
command! RGToggle call s:ToggleQuickfix()

nnoremap <silent> <Plug>(TinyRgWord) :RGWord<CR>
nnoremap <silent> <Plug>(TinyRgToggle) :RGToggle<CR>

augroup tiny_rg_quickfix
  autocmd!
  autocmd CursorMoved * call s:SyncQuickfixIndexFromCursor()
  autocmd BufEnter * call s:TrackTinyRgResultBuffer()
augroup END
