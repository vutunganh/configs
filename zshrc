# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- Shell Options ---
setopt autocd           # Automatically cd into directories when you type just the directory name
setopt appendhistory    # Append to history file instead of overwriting
setopt hist_ignore_dups # Don't record duplicate commands in history
setopt hist_ignore_space # Don't record commands that start with a space
setopt hist_reduce_blanks # Remove superfluous blanks from history lines

# --- History Configuration ---
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# Ignore common commands in history
HISTIGNORE='ls:bg:fg:cd*:vim:nvim'

# --- Aliases ---
alias ls='ls -G'  # Use -G for color on macOS BSD ls
# Note: macOS cal doesn't support -m flag like GNU cal, so we'll skip that alias
alias cp='cp -i'
alias mv='mv -i'

# --- Functions ---
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# --- Git-Aware Prompt ---
# Load zsh's version control info system
autoload -Uz compinit && compinit
autoload -Uz vcs_info

# Configure vcs_info for git
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'    # Show * for unstaged changes
zstyle ':vcs_info:git:*' stagedstr '+'      # Show + for staged changes
zstyle ':vcs_info:git:*' formats '(%b%u%c)' # Format: (branch*+)
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)' # Format during actions like merge

# Function to update vcs_info before each prompt
precmd() {
    vcs_info
}

# Set up the prompt
# Enable prompt substitution so variables are expanded each time
setopt prompt_subst

# %D{%H:%M:%S} = time in HH:MM:S format
# %n = username
# %m = hostname
# %~ = current directory (with ~ substitution)
# ${vcs_info_msg_0_} = git info (expanded each time due to prompt_subst)
PS1='[%D{%H:%M:%S}] [%n@%m %~] ${vcs_info_msg_0_}
$ '

# iTerm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
