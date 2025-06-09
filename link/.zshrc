export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ZPLUG_HOME="${HOME}/.zplug"
export CACHE_DIR="${HOME}/.cache"
[[ ! -d "${CACHE_DIR}" ]] && mkdir -p "${CACHE_DIR}"

export ZSHZ_DATA="${CACHE_DIR}/z"

# history settings
export HISTSIZE=2028
export SAVEHIST=2028
export HISTFILESIZE=$HISTSIZE
# export HISTCONTROL=ignoredups
export HISTFILE="${CACHE_DIR}/.zsh_history"
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export EDITOR='zed --wait'
export VISUAL='zed --wait'
export PAGER='less'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ulimit -Sn 64000
ulimit -Sl 200000

bindkey '[3~' delete-char

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
setopt no_beep                  # Disable sound
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
setopt complete_in_word         # allow completion from within a word/phrase
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt auto_menu
unsetopt menu_complete

setopt auto_pushd
setopt pushd_ignore_dups

fpath=(~/.zsh/completions $fpath)

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # fuzzy
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' menu select

if [[ ! -d "${ZPLUG_HOME}" ]]; then
  echo "Installing zplug"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  # zplug.sh domain has expired
  # curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
  source "${ZPLUG_HOME}/init.zsh"
  zplug update
else
  source "${ZPLUG_HOME}/init.zsh"
fi

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

# theme / promt
eval "$(starship init zsh)"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

[[ -f "${HOME}/.zsh/aliases" ]] && source "${HOME}/.zsh/aliases"

export STARSHIP_CONFIG=~/.starship

eval "$(rbenv init -)"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/Users/jonas/.netlify/helper/path.zsh.inc' ]; then source '/Users/jonas/.netlify/helper/path.zsh.inc'; fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1
export NODE_OPTIONS=--max_old_space_size=6144

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/Users/jonas/Library/Preferences/netlify/helper/path.zsh.inc' && source '/Users/jonas/Library/Preferences/netlify/helper/path.zsh.inc'

TT_AC_ZSH_SETUP_PATH=/Users/jonas/Library/Caches/tt/autocomplete/zsh_setup && test -f $TT_AC_ZSH_SETUP_PATH && source $TT_AC_ZSH_SETUP_PATH; # tt autocomplete setup

source <(COMPLETE=zsh jj)

export XDG_CONFIG_HOME="$HOME/.config/"
eval "$(atuin init zsh)"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
