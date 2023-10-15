export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias vim='nvim'
alias cl='clear'

alias fg='rg -i'
function ff {
    find . -iname "*$1*"
}

function att {
  tmux attach-session -t kebiana
  if [ $? -eq 1 ]; then
      echo "Starting new session"
    tmux new-session -s kebiana
  fi
}
