export ZPLUG_HOME="${HOME}/.zplug"
export CACHE_DIR="${HOME}/.cache"
[[ ! -d "${CACHE_DIR}" ]] && mkdir -p "${CACHE_DIR}"

export _FASD_DATA="${CACHE_DIR}/.fasd" # set fasd data file location
function fasd_cd {
  local fasd_ret="$(fasd -d "$@")"
  if [[ -d "$fasd_ret" ]]; then
    cd "$fasd_ret"
  else
    print "$fasd_ret"
  fi
}

# history settings
export HISTSIZE=1024
export SAVEHIST=1024
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTFILE="${CACHE_DIR}/.zsh_history"
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

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
zplug "plugins/fasd",   from:oh-my-zsh

export NVM_LAZY_LOAD=true
zplug "lukechilds/zsh-nvm"

# theme
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "sindresorhus/pure", use:pure.zsh, defer:3

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh --no-rehash)"
fi

[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
