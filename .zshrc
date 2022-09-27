# User configuration
export PATH="/opt/homebrew/bin:/Users/raknahs/.toolbox/bin:$PATH"

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

alias python='python3'     # command python will ignore the alias and use python2
alias pip='pip3'
alias ctags="`brew --prefix`/bin/ctags"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# packages
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

source ~/.zsh-z/zsh-z.plugin.zsh
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
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

