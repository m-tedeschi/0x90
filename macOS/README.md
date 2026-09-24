# 0x90 | macOS
This is my minimalist macOS setup.

The emphasis here is on *minimalism* and *productivity*. I try not to bolt on too many external programs or dependencies, and make use of what macOS has natively available. The primary development workflow is centered around the command line. I suggest reading this entire document and incorporating the elements you think best suit your style of work. This is not intended to be a one-size-fits-all configuration and it is more representative of how **I** like to use my machine, for work and for fun.

All commands listed here assume you are running them from `../0x90/macOS/` for installation purposes.

## Applications
The following applications are utilized:
* Zsh: Native macOS shell
* Ghostty: Lightweight, fast terminal emulator
* Vim: Text and code editing, `netrw` for in-terminal file navigation
* tmux: Terminal sessionizer, use in conjuction with Workspace Flow
* Workspace Flow: Sessionizes the sessionizer (rapid tmux window creation)
* Karabiner: Key remappings, primarily for window tiling management and app
  launching
* Cosmil: Improved Finder for file browsing
* AltTab: Improved application switching


### Zsh
The native macOS [Zsh](https://en.wikipedia.org/wiki/Z_shell) ("Z shell") is used.

**Install:**

All we need to do for this is drop in a single dotfile to our user home directory:

```bash
cp Zsh/.zshrc ~/.zshrc
```

[Homebrew](https://brew.sh/) is the preferred package manager we will be using. Install it with the following:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

You can close the default Terminal app now, we will never be using it again.

**Features:**
* `grab <file>` Copies file's contents to clipboard using `pbcopy`
* `glog` Improved `git log` display
* `here` Opens current directory in Cosmil/Finder
* `sethost <host_name>` Sets the host name for the prompt
* Loads `fzf` if installed for fuzzy finder shell navigation
* `brew` Homebrew package manager


### Ghostty
Next let's upgrade our terminal emulator. [Ghostty](https://ghostty.org/) is super fast and easily customizable.

**Install:**

Run the following command to install Ghostty with Homebrew: 
```bash
brew install --cask ghostty
```

Launch Ghostty. First we'll install the required Hack Nerd Font:

```bash
brew install --cask font-hack-nerd-font
```

Run the following command to copy the configuration to your clipboard:

```bash
grab Ghostty/config.ghostty
```

In the Menu Bar, click `Ghostty > Settings...` and paste the config. Save it and relaunch Ghostty.

**Features:**
* Sick transparent background
* Super dope Hack Nerd Font
* No title bar: We will use Karabiner to reposition the window later
* Some other general terminal stuff, like sending keys appropriately to tmux


### Vim
The ultimate text editor.

**Install:**

Very straightforward, we're going to install Vim, ripgrep, fzf, git, and Universal Ctags in one shot. Then we're gonna copy the dotfiles to the user directory:

```bash
brew install vim ripgrep fzf git universal-ctags
cp -R Vim/.vim ~/.vim
cp Vim/.vimrc ~/.vimrc
```

**Features:**
* Sick monochrome icy theme
* File navigation with `netrw`, ripgrep, and fzf
* Custom Tiny RG plugin for ripgrep integration with quickfix menu
* Leader key mappings for different fzf modes
* Symbol tracing with bindings for Universal Ctags
* Lots more. Refer to `Vim/README.md`
