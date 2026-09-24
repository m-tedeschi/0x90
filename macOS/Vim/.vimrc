" =============================================================================
" Startup and history
" =============================================================================

" Remember the directory Vim was launched from.
let g:project_root = getcwd()

" Allow buffers to remain loaded when switching away from them.
set hidden

" FZF uses ripgrep and ignores noisy directories.
let g:fzf_exclude_globs = [
      \ '!.git/**',
      \ '!.venv/**',
      \ '!.default/**',
      \ ]

let $FZF_DEFAULT_COMMAND =
      \ 'rg --files --hidden --follow ' .
      \ join(map(copy(g:fzf_exclude_globs),
      \ '"--glob " . shellescape(v:val)'), ' ')

set grepformat=%f:%l:%c:%m

set history=50
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" Command-line completion.
set wildmode=list:longest,full
set shortmess+=rFW

" Disable macro recording.
nnoremap q <Nop>

" Hide successful :w messages.
cnoreabbrev <expr> w
      \ getcmdtype() ==# ':' && getcmdline() ==# 'w'
      \ ? 'silent write <bar> redraw!'
      \ : 'w'

" Search upward through parent directories for the nearest .tags file.
set tags=./.tags;

set showcmd

" Prevent files from overriding this configuration.
set nomodeline

let g:tiny_rg_args = [
      \ '--vimgrep',
      \ '--smart-case',
      \ '--hidden',
      \ '--glob', '!.git/*',
      \ '--glob', '!.fruit/*',
      \ '--glob', '!.default/*',
      \ '--glob', '!tags',
      \ ]


" =============================================================================
" Editing behavior
" =============================================================================

" Do not wrap long lines
set nowrap

" Keep three lines visible above and below the cursor while scrolling.
set scrolloff=3

" Four-space indentation using spaces.
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent

" Allow Backspace across indentation and line boundaries.
set backspace=eol,start,indent

" Format comments, but not ordinary text, at 79 columns.
set formatoptions-=t
set textwidth=79

" Customize recognized comment leaders.
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*
set comments+=b:\"
set comments+=n::

" Display tabs as »· when 'list' is enabled.
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)

" Match angle brackets with %.
set matchpairs+=<:>


" =============================================================================
" Search and substitution
" =============================================================================

" Ignore case unless the search contains uppercase letters.
set ignorecase
set smartcase
set incsearch

" Treat substitutions as global by default.
set gdefault


" =============================================================================
" Filetypes and file-specific behavior
" =============================================================================

filetype on

augroup CustomFiletypes
  autocmd!

  autocmd BufNewFile,BufRead */.Postponed/* setfiletype mail
  autocmd BufNewFile,BufRead *.txt setfiletype human

  autocmd FileType mail,human setlocal formatoptions+=t textwidth=72
  autocmd FileType c,cpp,slang setlocal cindent
  autocmd FileType c setlocal formatoptions+=ro
  autocmd FileType perl,css setlocal smartindent
  autocmd FileType html setlocal formatoptions+=tl
  autocmd FileType html,css setlocal noexpandtab tabstop=4
  autocmd FileType make setlocal noexpandtab shiftwidth=8
augroup END


" =============================================================================
" Movement
" =============================================================================

" Allow horizontal movement to wrap across lines.
set whichwrap=h,l,~,[,]

" Page navigation.
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" Scroll without moving the cursor.
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>

" Cycle through split windows.
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W


" =============================================================================
" Help and formatting mappings
" =============================================================================

" Prompt for a help topic from any mode.
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" Format the current paragraph or visual selection.
nnoremap Q gqap
vnoremap Q gq

" Preserve indentation controls in Visual mode.
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" Make Y behave like D and C.
noremap Y y$


" =============================================================================
" Toggle mappings
" =============================================================================

" Toggle paste mode.
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" Toggle visible whitespace.
nnoremap \tl :set invlist list?<CR>
nmap <F2> \tl

" Toggle search highlighting.
nnoremap \th :set invhls hls?<CR>


" =============================================================================
" Insert-mode mappings
" =============================================================================

" Change indentation instead of inserting a tab.
inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>


" =============================================================================
" Interface
" =============================================================================

syntax on

set nonumber
set relativenumber

" Keep the line-number column as narrow as possible.
set numberwidth=3

set cursorline

set splitbelow
set splitright

set timeoutlen=350
set termguicolors

" Buffer terminal redraws to reduce flickering.
if exists('+termsync')
  set termsync
endif


" =============================================================================
" Colors and Ghostty transparency
" =============================================================================

colorscheme monochrome

function! ApplyGhosttyTransparency() abort
  highlight Normal       ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight NormalNC     ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight SignColumn   ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight LineNr       ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight CursorLineNr ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight EndOfBuffer  ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight NonText      ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight FoldColumn   ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight VertSplit    ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight CursorLine   ctermbg=236 guibg=#303030 cterm=NONE gui=NONE
endfunction

call ApplyGhosttyTransparency()

augroup GhosttyTransparency
  autocmd!
  autocmd ColorScheme * call ApplyGhosttyTransparency()
augroup END


" =============================================================================
" Greyscale Powerline status line
" =============================================================================

set noshowmode
set laststatus=2

" MINIMALIST STATUS FILE LABEL (does not display netrw path)
"function! StatusFileLabel() abort
"  if &filetype ==# 'netrw' || &buftype ==# 'terminal'
"    return ''
"  endif
"
"  return ' %f %m%r'
"endfunction

" TODO: Turn this into a toggle
" Status label displays netrw path
function! StatusFileLabel() abort
  if &filetype ==# 'netrw'
    return ' ' . fnamemodify(b:netrw_curdir, ':~')
  endif

  if &buftype ==# 'terminal'
    return ''
  endif

  return ' %f %m%r'
endfunction

function! StatusActiveIndicator() abort
  if exists('g:actual_curwin')
        \ && g:actual_curwin ==# string(win_getid())
    return 'λ '
  endif

  return ' '
endfunction

function! UpdateStatusLine() abort
  let l:mode = mode()

  " Shared status-line sections.
  highlight StatusLineInfo
        \ guifg=#eeeeee
        \ guibg=#1c1c1c
        \ gui=bold

  highlight StatusRight
        \ guifg=#1c1c1c
        \ guibg=#eeeeee
        \ gui=bold

  highlight StatusRightArrow
        \ guifg=#eeeeee
        \ guibg=#1c1c1c
        \ gui=NONE

  highlight StatusLineNC
        \ guifg=#808080
        \ guibg=#1c1c1c
        \ gui=NONE

  highlight StatusActiveBuffer
        \ guifg=#00afff
        \ guibg=#1c1c1c
        \ gui=bold

  " Mode-specific left section.
  if &buftype ==# 'terminal'
    highlight StatusMode
          \ guifg=#1c1c1c
          \ guibg=#808080
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#808080
          \ guibg=#1c1c1c
          \ gui=NONE

    if &filetype ==# 'fzf'
      let l:label = ' FZF '
    else
      let l:label = ' TERMINAL '
    endif

  elseif l:mode ==# 'n'
    highlight StatusMode
          \ guifg=#1c1c1c
          \ guibg=#eeeeee
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#eeeeee
          \ guibg=#1c1c1c
          \ gui=NONE

    let l:label = ' NORMAL '

  elseif l:mode ==# 'i'
    highlight StatusMode
          \ guifg=#ffffff
          \ guibg=#5f5f5f
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#5f5f5f
          \ guibg=#1c1c1c
          \ gui=NONE

    let l:label = ' INSERT '

  elseif l:mode ==# 'v'
        \ || l:mode ==# 'V'
        \ || l:mode ==# "\<C-v>"
    highlight StatusMode
          \ guifg=#1c1c1c
          \ guibg=#bcbcbc
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#bcbcbc
          \ guibg=#1c1c1c
          \ gui=NONE

    let l:label = ' VISUAL '

  elseif l:mode ==# 'R'
    highlight StatusMode
          \ guifg=#ffffff
          \ guibg=#3a3a3a
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#3a3a3a
          \ guibg=#1c1c1c
          \ gui=NONE

    let l:label = ' REPLACE '

  else
    highlight StatusMode
          \ guifg=#1c1c1c
          \ guibg=#808080
          \ gui=bold

    highlight StatusModeArrow
          \ guifg=#808080
          \ guibg=#1c1c1c
          \ gui=NONE

    let l:label = ' ' . toupper(l:mode) . ' '
  endif

  let &g:statusline =
        \ '%#StatusMode#' .
        \ l:label .
        \ '%#StatusModeArrow#' .
        \ '%#StatusLineInfo#' .
        \ ' ' .
        \ '%#StatusActiveBuffer#' .
        \ '%{%StatusActiveIndicator()%}' .
        \ '%#StatusLineInfo#' .
        \ '%{%StatusFileLabel()%}' .
        \ '%=' .
        \ '%#StatusRightArrow#' .
        \ '%#StatusRight#' .
        \ ' %y ' .
        \ ' %l:%c ' .
        \ ' %p%% ' .
        \ ' %L lines '
endfunction

call UpdateStatusLine()

augroup GreyscaleStatusLine
  autocmd!
  autocmd ColorScheme * call UpdateStatusLine()
  autocmd ModeChanged * call UpdateStatusLine()
  autocmd BufEnter,WinEnter * call UpdateStatusLine()
augroup END


" =============================================================================
" netrw
" =============================================================================

" Hide the help banner.
let g:netrw_banner = 0
let g:netrw_help = 0

" Plain list instead of tree/detail view.
let g:netrw_liststyle = 0

" Open files in the current window.
let g:netrw_browse_split = 0

" Don't maintain netrw's directory history file.
let g:netrw_dirhistmax = 0

" Sort directories first, then files, alphabetically.
let g:netrw_sort_by = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_sort_options = 'i'

" Hide dotfiles by default.
let g:netrw_hide = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Keep browsing behavior predictable.
"let g:netrw_keepdir = 0

" Keep Vim's working directory fixed while browsing with netrw.
let g:netrw_keepdir = 1

" Browse the directory containing the current file.
nnoremap <silent> <leader>n :silent Explore<CR>

" Browse the directory Vim was launched from.
nnoremap <silent> <leader>N :silent execute 'Explore ' . fnameescape(g:project_root)<CR>

" netrw-specific UI.
augroup NetrwSettings
  autocmd!

  " Use absolute line numbers in netrw
  autocmd FileType netrw setlocal number norelativenumber

  " Disable netrw settings that are fixed in the vimrc.
  autocmd FileType netrw nnoremap <buffer> a <Nop>
  autocmd FileType netrw nnoremap <buffer> s <Nop>
  autocmd FileType netrw nnoremap <buffer> r <Nop>
  autocmd FileType netrw nnoremap <buffer> i <Nop>
  autocmd FileType netrw nnoremap <buffer> I <Nop>

  " q remains disabled globally, including netrw.
  autocmd FileType netrw nnoremap <buffer> q <Nop>
augroup END

" netrw colors.
"
" Ordinary files inherit the normal foreground.
" Colors are taken directly from the monochrome colorscheme palette.
highlight netrwDir
      \ guifg=#00afff
      \ gui=bold

highlight netrwExe
      \ guifg=#5f87af
      \ gui=bold

highlight netrwSymLink
      \ guifg=#778899
      \ gui=NONE

" Start in netrw when Vim is opened without a file or with a directory.
augroup NetrwStartup
  autocmd!

  autocmd VimEnter * if argc() == 0 |
        \ silent Explore . |
        \ elseif argc() == 1 && isdirectory(argv(0)) |
        \ silent execute 'Explore ' . fnameescape(argv(0)) |
        \ endif
augroup END


" =============================================================================
" Buffer management
" =============================================================================

" Close the current buffer and land in netrw.
"
" Lowercase: return to the buffer's local directory.
" Uppercase: return to the directory Vim was launched from.
function! CloseBuffer(root) abort
  " netrw is the workspace browser; there is nothing to destroy.
  if &filetype ==# 'netrw'
    return
  endif

  " Terminal buffers may have running processes.
  if &buftype ==# 'terminal'
    let l:answer = confirm('Kill terminal and close window?', "&Yes\n&No", 2)

    if l:answer != 1
      return
    endif

    let l:buf = bufnr('%')

    " Determine the fallback directory in case this is Vim's only window.
    if a:root
      let l:dir = g:project_root
    else
      let l:dir = get(b:, 'terminal_root', g:project_root)
    endif

    " If this is Vim's only window, replace it with netrw so Vim stays open.
    if winnr('$') == 1
      silent execute 'Explore ' . fnameescape(l:dir)

    " Otherwise destroy the entire terminal window.
    else
      silent quit
    endif

    " Kill the terminal job and completely remove its buffer.
    if bufexists(l:buf)
      silent execute 'bwipeout! ' . l:buf
    endif

    return
  endif

  " Let Vim protect unsaved file changes.
  if &modified
    echohl WarningMsg
    echom 'No write since last change'
    echohl None
    return
  endif

  let l:buf = bufnr('%')

  " Determine where netrw should land before leaving this buffer.
  if a:root
    let l:dir = g:project_root
  else
    let l:dir = expand('%:p:h')

    if empty(l:dir)
      let l:dir = getcwd()
    endif
  endif

  " Establish the landing buffer before deleting the old file buffer.
  silent execute 'Explore ' . fnameescape(l:dir)

  if bufexists(l:buf)
    silent execute 'bdelete ' . l:buf
  endif
endfunction

" Close the current buffer and browse its local directory.
nnoremap <silent> <leader>q :call CloseBuffer(0)<CR>

" Close the current buffer and browse the project root.
nnoremap <silent> <leader>Q :call CloseBuffer(1)<CR>


" =============================================================================
" Terminal
" =============================================================================

" Open a terminal in the current buffer's directory.
function! TerminalHere() abort
  let l:dir = expand('%:p:h')

  " netrw's current directory is its browsing location.
  if &filetype ==# 'netrw'
    let l:dir = b:netrw_curdir
  elseif empty(l:dir)
    let l:dir = getcwd()
  endif

  execute 'lcd ' . fnameescape(l:dir)
  terminal

  " Remember where this terminal was originally launched.
  let b:terminal_root = l:dir
endfunction

" Open a terminal in the directory Vim was launched from.
function! TerminalRoot() abort
  let l:dir = g:project_root

  execute 'lcd ' . fnameescape(l:dir)
  terminal

  " Remember where this terminal was originally launched.
  let b:terminal_root = l:dir
endfunction

nnoremap <silent> <leader>s :call TerminalHere()<CR>
nnoremap <silent> <leader>S :call TerminalRoot()<CR>


" =============================================================================
" Fuzzy finding and buffer navigation
" =============================================================================

" Quickfix navigation.
nnoremap <silent> <Tab> :silent! cn<CR>
nnoremap <silent> <S-Tab> :silent! cp<CR>

" Toggle ripgrep results.
nnoremap <silent> <leader><Tab> :RGToggle<CR>

cnoreabbrev <expr> rg
      \ getcmdtype() ==# ':' && getcmdline() ==# 'rg'
      \ ? 'RG'
      \ : 'rg'

" FZF on active buffers.
nnoremap <leader>b :Buffers<CR>

" FZF on active windows.
nnoremap <leader>w :Windows<CR>

" FZF on Git tracked files only.
nnoremap <leader>g :GFiles<CR>

" FZF on Git status files, including untracked files.
nnoremap <leader>G :GFiles?<CR>

" FZF on all files.
nnoremap <leader>f :Files<CR>

" Ripgrep the word under the cursor.
nnoremap <leader>t :RG <C-R><C-W><CR>


" =============================================================================
" Custom commands
" =============================================================================

"command! MakeTags
"      \ silent execute
"      \ '!ctags -R --exclude=.git --exclude=.fruit --exclude=.default .'
"      \ | redraw!

" Generate a hidden tags file in the current working directory.
command! MakeTags
      \ silent execute
      \ '!ctags -R -f .tags --exclude=.git --exclude=.fruit --exclude=.default .'
      \ | redraw!


" =============================================================================
" Mouse
" =============================================================================

set mouse=

" Disable mouse-wheel scrolling while retaining other mouse support.
nnoremap <ScrollWheelUp> <Nop>
nnoremap <ScrollWheelDown> <Nop>
nnoremap <ScrollWheelLeft> <Nop>
nnoremap <ScrollWheelRight> <Nop>

inoremap <ScrollWheelUp> <Nop>
inoremap <ScrollWheelDown> <Nop>
inoremap <ScrollWheelLeft> <Nop>
inoremap <ScrollWheelRight> <Nop>

vnoremap <ScrollWheelUp> <Nop>
vnoremap <ScrollWheelDown> <Nop>
vnoremap <ScrollWheelLeft> <Nop>
vnoremap <ScrollWheelRight> <Nop>
