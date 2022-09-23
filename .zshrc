# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-z
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/opt/homebrew/bin:/Users/raknahs/.toolbox/bin:/opt/homebrew/etc/profile.d/z.sh:$PATH"

# fish-like autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

# direnv
eval "$(direnv hook zsh)"

# mwinit helper
cloud_desktop=raknahs.aka.corp.amazon.com
function __yubi() {
 if [[ -z $(print -l ${HOME}/.ssh/id_rsa-cert.pub(N.ms-72000)) ]]; then
   if mwinit; then
      ssh-add -t 72000 ${HOME}/.ssh/*_rsa
      scp ${HOME}/.midway/cookie ${cloud_desktop}:.midway/cookie
   fi
 fi
}

# run kmonday when logging in if no kerberos ticket
kmonday() { kinit -f -l 7d -r 30d; }
if ! klist -s; then kmonday; fi

# Brazil shortcuts
alias bb='brazil-build'
alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use --gitMode -p'
alias bwscreate='bws create -n'
alias brc=brazil-recursive-cmd
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'

# ada helper
export DEV_ACCOUNT=504624935930
myada() {
    if [[ $# -eq 0 ]]
    then
      ACCOUNT_ID=$DEV_ACCOUNT
    else
      ACCOUNT_ID=$1
    fi
    ada credentials update --account=$ACCOUNT_ID --provider=isengard --role=Admin --once
}

# Make shorthands for common flags
alias ll="ls -lh"

# Save a lot of typing for common commands
alias gs="git status"
alias gc="git commit"
alias v="vim"
alias la="ls -la"
alias ll="ls -lh"

# Avoid mistyping
alias sl=ls

# Overwrite existing commands for better defaults
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format


# completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i
complete -C '/usr/local/bin/aws_completer' aws

fpath=(~/.zsh/completion $fpath)

# smartcase autocompletion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# ^w functionality
autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'

[ -f "/Users/nikhil/.ghcup/env" ] && source "/Users/nikhil/.ghcup/env" # ghcup-env
