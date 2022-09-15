source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
eval "$(fasd --init auto)"

# Make shorthands for common flags
alias ll="ls -lh"

# Save a lot of typing for common commands
alias gs="git status"
alias gc="git commit"
alias v="vim"

# Avoid mistyping
alias sl=ls

# Overwrite existing commands for better defaults
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format


source /Users/nikhil/.config/broot/launcher/bash/br

# smartcase autocompletion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit  && compinit

# ^w functionality
autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'
