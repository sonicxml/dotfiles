setopt AUTO_CD                   # cd to a dir without typing cd
setopt BEEP                      # Beep on error in ZLE
# https://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
# bindkey -mv 2>/dev/null
bindkey -v                      # Enable vim mode
export KEYTIMEOUT=1


#######################
# ZSH History Options #
#######################
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
###########################
# End ZSH History Options #
###########################


###############
# compinstall #
###############
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# Completion for kitty
if type "kitty" > /dev/null; then
    kitty + complete setup zsh | source /dev/stdin
fi

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
###################
# end compinstall #
###################


#################
# zplug Plugins #
#################
case "$OSTYPE" in
  darwin*)
    export ZPLUG_HOME=/usr/local/opt/zplug
  ;;
  linux*)
    export ZPLUG_HOME=/home/linuxbrew/.linuxbrew/opt/zplug
  ;;
esac
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "djui/alias-tips"
zplug "peterhurford/up.zsh"
zplug "olets/zsh-abbr"
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "zsh-users/zsh-completions", depth:1
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3


# Load theme file (zsh-async is required by pure)
# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
#####################
# End zplug Plugins #
#####################

# Make zsh-autosuggestions faster
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

######################
# User configuration #
######################

export LC_ALL=en_US.UTF-8

# Abbreviations
abbr --quiet --force l='exa'
abbr --quiet --force ls='exa -l'
abbr --quiet --force ll='exa -lhF'
abbr --quiet --force lg='exa -la --git'
abbr --quiet --force la='exa -lahF'
abbr --quiet --force tree='exa -l --tree'
abbr --quiet --force g='git'
abbr --quiet --force ga='git add'
abbr --quiet --force gau='git add -u'
abbr --quiet --force gb='git branch'
abbr --quiet --force gd='git diff'
abbr --quiet --force gf='git fetch -pP'
abbr --quiet --force gp='git push'
abbr --quiet --force gs='git status'
abbr --quiet --force gco='git checkout'
abbr --quiet --force gcm='git commit -m'
abbr --quiet --force cat='bat'
abbr --quiet --force vim='nvim'
abbr --quiet --force vimdiff='nvim -d'

alias weather='curl wttr.in'

prompt_newline='%666v '
RPROMPT='%F{white}%*'
PURE_PROMPT_SYMBOL='❯❯❯'
PURE_PROMPT_VICMD_SYMBOL='⦗N⦘ ❯❯❯'

# bindkey "^R" history-incremental-pattern-search-backward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

function cls {
  osascript -e 'tell application "System Events" to keystroke "k" using command down'
}


# Setting PATH for Python 3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/python@3.8/lib"
# Setting PATH for Golang
export PATH="/usr/local/opt/go@1.13/bin:$PATH"


# VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
export VIRTUALENVWRAPPER_PYTHON=BREW_LOC/local/opt/python@3.8/bin/python3.8
export VIRTUALENVWRAPPER_VIRTUALENV=BREW_LOC/bin/virtualenv
source BREW_LOC/bin/virtualenvwrapper.sh


# fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias jj='fasd_cd -d -i' # cd with interactive selection
alias v='f -e nvim'      # quick opening files with vim
alias o='a -e open'      # quick opening files with file explorer


# fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f ~/.zshcustom ]; then
    source ~/.zshcustom
fi

