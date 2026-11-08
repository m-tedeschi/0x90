" Use only public Vim APIs; never alter netrw's text or cursor.
function! netrw_devicons#schedule() abort
  call timer_start(0, function('s:RefreshLater', [bufnr('%')]))
endfunction

function! s:RefreshLater(buf, timer) abort
  if bufnr('%') == a:buf && &filetype ==# 'netrw'
    call netrw_devicons#refresh()
  endif
endfunction

function! netrw_devicons#refresh() abort
  if &filetype !=# 'netrw'
    return
  endif
  let type = 'netrw_devicons'
  if empty(prop_type_get(type, {'bufnr': bufnr('%')}))
    call prop_type_add(type, {'bufnr': bufnr('%'), 'highlight': 'Directory', 'combine': v:true})
  endif
  call prop_remove({'type': type, 'all': v:true}, 1, line('$'))
  if !get(g:, 'netrw_devicons_enabled', 1)
        \ || get(b:, 'netrw_liststyle', get(g:, 'netrw_liststyle', 0)) != 0
        \ || !exists('b:netrw_curdir') || !isdirectory(b:netrw_curdir)
    return
  endif

  " Match actual directory entries, including netrw's classification suffixes.
  " This handles spaces, Unicode, and names ending in *, @, or / safely.
  let entries = {}
  for name in readdir(b:netrw_curdir) + ['.', '..']
    let path = b:netrw_curdir . '/' . name
    let dir = isdirectory(path)
    let suffix = getftype(path) ==# 'link' ? '@' : dir ? '/' : executable(path) ? '*' : ''
    let entry = [path, dir]
    let entries[name . suffix] = entry
    if !has_key(entries, name)
      let entries[name] = entry
    endif
  endfor
  for lnum in range(1, line('$'))
    let text = getline(lnum)
    " netrw can append a link target, even for a literal trailing @.
    if !has_key(entries, text)
      let text = substitute(text, '\t\s*-->.*$', '', '')
    endif
    if !has_key(entries, text)
      continue
    endif
    let [path, dir] = entries[text]
    let icon = exists('*WebDevIconsGetFileTypeSymbol')
          \ ? WebDevIconsGetFileTypeSymbol(path, dir)
          \ : dir ? '▸' : '•'
    if !empty(icon)
      call prop_add(lnum, 1, {'type': type, 'text': icon . ' '})
    endif
  endfor
endfunction
