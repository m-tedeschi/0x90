# --- PROMPT STYLE --- #

# username@host directory %
PROMPT="%F{white}%n%F{white}@%F{white}%m %F{#00afff}%1~%f %F{white}%# %f"

# --- END PROMPT STYLE --- #


# --- ALIASES --- #

# Open file browser app in current directory
alias here="open -a Cosmil ."

# Use this one if you want the native Finder app
# alias here="open ."

# --- END ALIASES --- #


# --- CUSTOM COMMANDS --- #

# Copies a file's text to the clipboard
# Usage: grab <file_name>
grab() {
  cat "$1" | pbcopy
}

# Improved git log command
# Usage: glog
glog() {
  git log -n 30 --graph \
    --pretty="format:%C(auto)%h%Creset | %Cblue%aN%Creset | %C(auto)%D%Creset %s" \
    "$@"
}

# Set the host name used by the prompt
# Usage: sethost <host_name>
sethost() {
  if [[ -z "$1" ]]; then
    echo "usage: sethost <host_name>"
    return 1
  fi

  scutil --set HostName "$1" && exec zsh
}

# --- END CUSTOM COMMANDS --- #


# --- LOAD FZF --- #

# Load fzf shell integration if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- END LOAD FZF --- #
