# Speed up `brew install`
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

unset zle_bracketed_paste

autoload -Uz compinit && compinit

source ~/dotfiles/zsh/.aliases
source ~/dotfiles/zsh/.safe-paste
source ~/dotfiles/zsh/.history
source ~/dotfiles/zsh/.zsh-git
source ~/dotfiles/zsh/.zsh-theme
source ~/dotfiles/zsh/.pomodoro

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

git_prompt() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')

  if [ ! -z $BRANCH ]; then
    echo -n "%F{yellow}$BRANCH"

    STATUS=$(git status --short 2> /dev/null)

    if [ ! -z "$STATUS" ]; then
      echo " %F{red}✗"
    fi
  fi
}

#Bullet Train Theme Options
BULLETTRAIN_PROMPT_CHAR="%{%K{black}%}%  %{%F{white}%} ➜ %{%f%b%k%}%{%F{black}%}%{%f%b%k%}"
BULLETTRAIN_DIR_BG=yellow
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_PROMPT_ORDER=(
  #time
  #custom
  status
  context
  dir
  virtualenv
  git
)

eval "$(rbenv init -)"
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2

PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

