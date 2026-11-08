# netrw-devicons

Local Vim plugin adding virtual-text icons to netrw's local plain list view
(`g:netrw_liststyle = 0`). Filenames, mappings, cursor position, and buffer text
are untouched. Other listing styles and remote directories are left undecorated.

Requires Vim 9.0.0067+ with text properties. Uses vim-devicons when installed;
otherwise uses simple Unicode markers. Select a Nerd Font in your terminal for
devicons glyphs.

Installed automatically from `~/.vim/pack/plugins/start/netrw-devicons`.
Restart Vim after installation. No vimrc changes required.

- `:NetrwDeviconsRefresh` redraws icons.
- `let g:netrw_devicons_enabled = 0` disables icons on the next refresh.
- Remove this package directory to uninstall.
