# User configuration
export PATH="$HOME/.emacs.d/bin:/opt/homebrew/bin:/Users/raknahs/.toolbox/bin:$PATH"

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
alias ctags=$(brew --prefix)/bin/ctags

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
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
export EDITOR=vim

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
bindkey '^F' forward-word # Helps with zsh-autosuggestions
bindkey '^B' backward-word # Helps with zsh-autosuggestions

# Evals
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/raknahs/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/raknahs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/raknahs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/raknahs/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

bindkey -e #helps with C-E and C-A in vterm
