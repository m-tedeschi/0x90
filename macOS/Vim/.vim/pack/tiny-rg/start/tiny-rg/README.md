# tiny-rg

A deliberately tiny Vim plugin that searches with `ripgrep`, fills quickfix directly, and avoids the terminal flash / `Press ENTER` flow that can happen when shelling out visibly.

## Smallest Architecture

```text
tiny-rg/
  plugin/
    tiny_rg.vim
```

The whole first version lives in one Vimscript file:

- `:RG pattern` runs `rg --vimgrep`, fills quickfix, and jumps to the first result.
- `:RGgo pattern` is an alias for the default `:RG` jump behavior.
- `:RGStay pattern` searches while keeping focus in your editing window.
- Searches keep the quickfix menu hidden by default; use `:RGToggle` to show or hide it.
- Inside TinyRg quickfix results, `<Tab>` opens the next result and `<S-Tab>` opens the previous result instead of running global buffer navigation mappings.
- TinyRg hides the previous result buffer from the buffer list when moving through TinyRg quickfix results, as long as that buffer was not already open and has no unsaved changes.
- Inside TinyRg quickfix results, `q` closes the quickfix window cleanly.
- The quickfix window is named `[TinyRg Quickfix]` so window pickers can show it more clearly.
- `:RGWord` searches the exact word under your cursor.
- `:RGOpen`, `:RGClose`, and `:RGToggle` control quickfix.
- `<Plug>(TinyRgWord)` and `<Plug>(TinyRgToggle)` are exposed so you can choose your own mappings.

## Install

```sh
mkdir -p ~/.vim/pack/tiny-rg/start
cp -R tiny-rg ~/.vim/pack/tiny-rg/start/
```

Then restart Vim.

## Try First

From your project root:

```vim
:RG runOperation
```

Then:

```vim
:RGgo runOperation
:RGStay runOperation
:RGWord
:RGToggle
:RGClose
```

## Suggested Mappings

Put these in your `.vimrc` if they feel good:

```vim
nmap <leader>* <Plug>(TinyRgWord)
nmap <leader>q <Plug>(TinyRgToggle)
```

## Options

Set these before the plugin loads:

```vim
let g:tiny_rg_auto_open_quickfix = 0
let g:tiny_rg_jump_to_first = 1
let g:tiny_rg_height = 10
let g:tiny_rg_quickfix_name = '[TinyRg Quickfix]'
let g:tiny_rg_args = ['--vimgrep', '--smart-case', '--hidden', '--glob', '!.git/*']
```

## Why This Shape

This is intentionally boring and easy to modify. `systemlist()` captures `rg` output silently, `setqflist()` fills quickfix without going through Vim's external grep UI, and the commands are thin wrappers around one search function.

Good next knobs to add:

- Search only Swift files.
- Prompt for a search term when `:RG` is called with no args.
- Add a location-list version for per-window searches.
- Add a preview window or floating result picker later.
