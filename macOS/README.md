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

---
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

---
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

---
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

---
### tmux
The preferred terminal sessionizer.

**Install:**

Again, very straightforward. We install with Homebrew, then copy the dotfile to the user directory:

```bash
brew install tmux
cp tmux/.tmux.conf ~/.tmux.conf
```

**Features:**
* Monochrome theme to match Vim
* It's vanilla tmux. Boring and ridiculously useful in the terminal

---
### Workspace Flow
A small tool I wrote for sessionizing the sessionizer. Good for isolating work contexts and switching between them quickly.

**Install:**

Simple, clone the repository and run the install script, then restart your shell:

```bash
git clone https://www.github.com/m-tedeschi/workspace-flow
./workspace-flow/install.sh
```

**Features:**
* Install script automatically adds `wf` to Zsh
* `wf` Displays active workspace contexts
* `wf <workspace>` Switch to a workspace
* `wf .` Creates a workspace using the current directory name
* `wf <name>` Creates a named workspace in this directory, or switches to an
  existing named workspace
* `wf -d` Deletes the current workspace
* `wf -d <name>` Deletes a named workspace
* `wf -x` Detaches from the current workspace

---
### Karabiner Elements
Karabiner will give us access to window tiling management keybinds. Most of the functionality comes from the native macOS "Window" item from the Menu Bar.

**Install:**

Start by installing with Homebrew:

```bash
brew install --cask karabiner-elements
```

You will probably need to go into your Mac's Settings and give Karabiner some Accessibility permissions. I would also add it as a Login Item so it automatically runs on startup.

Then, run the following to copy the configuration to your clipboard:

```bash
grab Karabiner/karabiner.json
```

Open Karabiner Elements. Go into the Complex Modifications tab, add a new one, and paste the configuration. A few more steps remain, mostly in `Settings > Keyboard > Keyboard Shortcuts`:
* `Tile Top Left Quarter` maps to F14 (`Fn + Control + [`)
* `Tile Top Right Quarter` maps to F15 (`Fn + Control + ]`)
* `Tile Bottom Left Quarter` maps to F16 (`Fn + Control + ;`)
* `Tile Bottom Right Quarter` maps to F17 (`Fn + Control + '`)
* `Arrange in Quarters` maps to F13 (`Left Option + 4`)
* Caps Lock modifier key maps to Escape
* `Use F1, F2, etc. keys as standard function keys` enabled
* `App Shortcuts > Safari > Show Start Page` maps to `Left Command + g`
* `Save picture of screen as a file` maps to `Control + Shift + Command + 3`
* `Copy picture of screen to the clipboard` maps to `Shift + Command + 3`
* `Save picture of selected area as a file` maps to `Control + Shift + Command
  + 4`
* `Copy picture of selected area to the clipboard` maps to `Shift + Command +
  4`
* `Move focus to next window` maps to `Left Option + Tab`

I'm probably missing a few but this should cover the majority of functionality.

**Features:**
* Half, triple, and quarter window tiling
* `Right Command` and `Right Option` drive most of this arrangement movement
* `Fn + Control + Arrow Key` drive singular window movement
* `Fn + Control + [ or ] or ; or '` drive quarter-tile singular window movement
* `Left Option + 4` arranges all windows into quarters
* `Left Option + Shift + Right Command or Right Option` arranges windows into
  triple tiles
* `Left Option + Right Command or Right Option` arranges top/bottom splits
* `Control + Down` centers a window
* `Control + Up` maximizes a window
* `Fn + \` launches/focuses Safari
* `Control + \` launches/focuses Ghostty
* `Left Option + \` launches/focuses Cosmil
* `Left Command + Shift + \` marks the current focused application
* `Left Command + \` launches/focuses the marked application
* `Left Command + Shift + .` clears the marked application
* `Fn + Control + \` launches/focuses Messages
* `Fn + Left Option + \` moves a window to/from iPad Sidecar (you will need to
  adjust the AppleScript in the configuration for this)
* `Left Option + Shift + d` shows the desktop
