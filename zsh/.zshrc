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
source ~/dotfiles/worktrees/.wt-switch
source ~/dotfiles/lf/scripts/lfcd.sh


source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

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
BULLETTRAIN_PROMPT_CHAR="%F{white}%} ➝  "
BULLETTRAIN_DIR_BG=yellow
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_CUSTOM_BG=cyan
BULLETTRAIN_CUSTOM_FG=black
BULLETTRAIN_CUSTOM_MSG=
BULLETTRAIN_PROMPT_ORDER=(
  #time
  custom
  status
  #context
  dir
  virtualenv
  git
)

#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.json)"


eval "$(rbenv init -)"
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2

PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH


# bun completions
[ -s "/Users/mikekey/.bun/_bun" ] && source "/Users/mikekey/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"


export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export PKG_CONFIG_PATH="/usr/local/opt/llvm/lib/pkgconfig"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
