export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias cl='clear'
alias cat='bat --theme Dracula'
alias ls='ls --color=always'
alias gg='cat ~/git_pass | pbcopy'
findstring() {
  if [ -z "$1" ]; then
    echo "Usage: findstring <pattern>"
  else
    rg --color=always "$1"
  fi
}
findfile() {
  if [ -z "$1" ]; then
    echo "Usage: findfile <pattern>"
  else
    fdfind "$1" -p | rg --color=always "$1"
  fi
}
tm() {
  local sessions=$(tmux list-sessions -F \#S 2>/dev/null)
  local selected_session=$(echo "$sessions" | fzf --print-query)
  if [[ -z "$selected_session" ]]; then
    echo "You did not select anything"
    return
  fi
  selected_session=$(echo "$selected_session" | tr -d '\n')
  if tmux has-session -t "$selected_session" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      tmux switch-client -t "$selected_session"
    else
      tmux attach-session -t "$selected_session"
    fi
  else
    if [[ -n "$TMUX" ]]; then
      tmux new-session -d -s "$selected_session"
      tmux switch-client -t "$selected_session"
    else
      tmux new-session -s "$selected_session"
    fi
  fi
}


export PATH="$PATH:/home/d3f4ult/.local/bin"



export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# may need : setxkbmap -device 12 -option altwin:swap_alt_win
# setxkbmap -option
