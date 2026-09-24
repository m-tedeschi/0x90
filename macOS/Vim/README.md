# Vim Configuration

An opinionated, terminal-focused Vim setup built around netrw, fzf, ripgrep,
embedded terminals, and a minimal custom interface. The plugins and color
schemes are vendored under `.vim`, so no Vim plugin manager is required.

## Dependencies

Install the external tools with Homebrew:

```sh
brew install vim ripgrep fzf git universal-ctags
```

The core dependencies are Vim, ripgrep, and fzf. Git is used by the Git-aware
fzf commands, while Universal Ctags supports `:MakeTags` and tag navigation.

The status line uses Powerline glyphs, so a Nerd Font is recommended:

```sh
brew install --cask font-hack-nerd-font
```

Select **Hack Nerd Font Mono** (or another Nerd Font) in the terminal.

## Installation

Copy `.vim` and `.vimrc` into the home directory:

```sh
cp -R .vim ~/.vim
cp .vimrc ~/.vimrc
```

If either destination already exists, back it up first. `cp -R` merges into an
existing `.vim` directory rather than replacing it.

Confirm that the Homebrew version of Vim is selected:

```sh
which vim
vim --version
```

On Apple Silicon, `which vim` will usually report `/opt/homebrew/bin/vim`. On
Intel Macs, it will usually report `/usr/local/bin/vim`.

## Features

### Project-aware startup

- Remembers the directory from which Vim was launched as the project root.
- Opens netrw when Vim starts without a file or with a directory.
- Can browse either the current file's directory or the project root.

### Fuzzy navigation

- `<leader>f` searches all files with fzf.
- `<leader>b` searches open buffers.
- `<leader>w` searches open windows.
- `<leader>g` searches Git-tracked files.
- `<leader>G` includes modified and untracked Git files.
- Hidden files are included while noisy directories such as `.git`, `.venv`,
  and `.default` are excluded.

### Project search

- Uses ripgrep through the bundled `tiny-rg` plugin.
- `<leader>t` searches for the word under the cursor.
- `<leader><Tab>` toggles the quickfix results window.
- `<Tab>` and `<Shift-Tab>` move forward and backward through results.
- Typing `:rg` is translated to `:RG`.

### Terminal workflow

- `<leader>s` opens a terminal in the current file's directory.
- `<leader>S` opens a terminal in the project root.
- Closing a terminal prompts before killing its process.

### Buffer management

- `<leader>q` closes the current buffer and returns to its directory in netrw.
- `<leader>Q` closes it and returns to the project root.
- Modified buffers are protected from accidental closure.

### Customized netrw

- Uses a simple directory listing without the banner or help panel.
- Sorts directories before files and hides dotfiles by default.
- Applies custom colors to directories, executables, and symbolic links.
- Uses absolute line numbers while browsing.
- Disables several mutable netrw controls to keep its behavior predictable.

### Custom status line

- Shows the current mode, file or directory, file type, cursor position,
  percentage through the file, and total line count.
- Uses different colors for Normal, Insert, Visual, Replace, Terminal, and FZF
  modes.
- Distinguishes the active split and uses Powerline-style arrows.

### Appearance

- Uses the bundled `monochrome` color scheme.
- Enables true color and a transparent background designed for Ghostty.
- Highlights the current line.
- Uses relative line numbers for editing and absolute numbers in netrw.

### Editing behavior

- Uses four-space indentation with spaces.
- Disables line wrapping.
- Ignores case in lowercase searches and respects case when uppercase letters
  are present.
- Makes substitutions global by default.
- Keeps three context lines visible while scrolling.
- Allows `%` to match angle brackets.
- Disables modelines.

### Filetype behavior

- Text and mail files format at 72 columns.
- C and C++ use C indentation.
- HTML and CSS use literal tabs.
- Makefiles use eight-column tabs.
- Includes custom `jobhunt` and `problemboard` filetypes and syntax definitions.

### Keyboard changes

- `<Space>` and `<Backspace>` act as Page Down and Page Up.
- `<Insert>` and `<Delete>` scroll without moving the cursor.
- `Q` formats the current paragraph or visual selection.
- `Y` yanks to the end of the line.
- `q` is disabled to prevent accidental macro recording.
- `<F2>` toggles visible whitespace.
- `<F4>` toggles paste mode.
- `<F6>` cycles through split windows.
- Mouse-wheel scrolling is disabled.

### Tags

- `:MakeTags` creates a project-local `.tags` file with Universal Ctags.
- Vim searches upward through parent directories for the nearest `.tags` file.

## Workflow

The intended workflow is to launch Vim from a project root, browse with netrw
or fzf, search with ripgrep, and use embedded terminals without adding a large
plugin-management layer.
