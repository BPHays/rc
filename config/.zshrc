# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="myagnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(dircycle git colored-man-pages zsh-syntax-highlighting) #zsh-autosuggestions)

# User configuration

#export PATH="/homes/hays1/bin/.amd64-linux:/homes/hays1/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.8.3:/usr/games/bin:.:/p/andriod-sdk/tools:/p/andriod-sdk/platform-tools:/p/android-sdk/tools:/p/android-sdk/platform-tools"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

unalias ls

export EDITOR=vim

# make all files private by default
umask 077

# import local zsh settings
[ -f ~/.local.zshrc ] && source ~/.local.zshrc

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
#

# fix vimrc
#export VIMRUNTIME=~/.linuxbrew/Cellar/vim/8.0.0562/share/vim/vim80

# import path stuff
[ -f ~/.paths ] && source ~/.paths

# import user made functions
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.local.functions ] && source ~/.local.functions

# import alias file
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.local.aliases ] && source ~/.local.aliases

# use thefuck
if ! [[ $(type thefuck) =~ "not found" ]]; then
  eval "$(thefuck --alias)"
fi

DEFAULT_USER="$USER"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# local binaries
export PATH="$HOME/.local/bin:$PATH"
