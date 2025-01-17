export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias cl='clear'
alias cat='bat'

function ff {
  fzf \
    --preview 'bat --theme=ansi --style=numbers --color=always {1}' \
    --preview-window 'up,50%' \
    --bind 'enter:execute(vim {1} && echo {1})'
}

function fg {
  local search_term="${*:-}"
  rg "$search_term" --color=always --no-heading --line-number --column \
    | fzf -d':' --ansi \
    --preview "bat --theme=ansi -p --color=always {1} --highlight-line {2}" \
    --preview-window 'up,50%,+{2}-5' \
    --bind 'enter:execute(vim +{2} {1} && echo {1})'
}

function att {
  tmux attach-session -t main
  if [ $? -eq 1 ]; then
      echo "Starting new session"
      tmux new-session -s main
  fi
}

PROMPT='%m%{$fg[green]%}%~%{$reset_color%}$ $(git_prompt_info)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

# may need : setxkbmap -device 12 -option altwin:swap_alt_win
# setxkbmap -option
