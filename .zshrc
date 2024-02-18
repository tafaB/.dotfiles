export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    zsh-autosuggestions
)
ZSH_THEME="sunrise"
source $ZSH/oh-my-zsh.sh

# aliases
e() {
    terminator -e "nvim $1"
}
alias cl='clear'
alias att='if tmux has-session 2>/dev/null; then tmux attach; else tmux new-session; fi'
alias dtt='tmux detach-client'
alias gg='xsel -b < git_pass'
alias fg='rg -i'
function ff {
    find . -iname "*$1*"
}

# go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

# react
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"


# promt
PROMPT='%~/ $(git_prompt_info)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
