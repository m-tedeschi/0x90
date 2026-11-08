set nocompatible
set viminfo=
let s:vimhome = expand('<sfile>:p:h:h:h:h:h:h')
set packpath=$VIMRUNTIME
execute 'set runtimepath^=' . fnameescape(s:vimhome . '/pack/plugins/start/netrw-devicons')
execute 'source ' . fnameescape(s:vimhome . '/pack/plugins/start/vim-devicons/plugin/webdevicons.vim')
runtime plugin/netrw_devicons.vim
runtime plugin/netrwPlugin.vim
filetype plugin on
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_dirhistmax = 0
let s:root = tempname()
call mkdir(s:root, 'p')
call mkdir(s:root . '/folder')
call writefile(['hello'], s:root . '/hello world.py')
call writefile([], s:root . '/日本語.txt')
call writefile([], s:root . '/literal@')
execute 'Explore ' . fnameescape(s:root)
let s:before = getline(1, '$')
call writefile(s:before, "/private/tmp/netrw-lines")
let s:pos = getpos('.')
call netrw_devicons#refresh()
call assert_equal(s:before, getline(1, '$'), 'buffer text unchanged')
call assert_equal(s:pos, getpos('.'), 'cursor unchanged')
let s:count = 0
for s:lnum in range(1, line('$'))
  let s:count += len(prop_list(s:lnum))
endfor
call assert_equal(len(filter(copy(s:before), 'v:val !=# ""')), s:count, 'every listed entry has an icon')
call netrw_devicons#refresh()
let s:count2 = 0
for s:lnum in range(1, line('$'))
  let s:count2 += len(prop_list(s:lnum))
endfor
call assert_equal(s:count, s:count2, 'refresh does not duplicate icons')
call search('^hello world.py$')
execute "normal \<CR>"
call assert_equal(s:root . '/hello world.py', expand('%:p'), 'netrw opens original filename')
execute 'Explore ' . fnameescape(s:root)
call search('^folder/$')
execute "normal \<CR>"
call netrw_devicons#refresh()
call assert_equal(s:root . '/folder', substitute(b:netrw_curdir, '/$', '', ''), 'directory navigation')
let g:netrw_devicons_enabled = 0
call netrw_devicons#refresh()
call assert_equal([], prop_list(1), 'disable clears icons')
call delete(s:root, 'rf')
call writefile(v:errors, '/private/tmp/netrw-devicons-test-errors')
if !empty(v:errors)
  cquit
endif
qa!
