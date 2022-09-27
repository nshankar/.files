# User configuration
export PATH="/opt/homebrew/bin:$PATH"
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

alias python='python3'     # command python will ignore the alias and use python2
alias pip='pip3'

# packages
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

source ~/.zsh-z
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

### Completion and typing utils
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

# Evals
eval "$(starship init zsh)"

