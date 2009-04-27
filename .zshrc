export PS1='%n@%m:%~$ '
alias ls='ls --color=auto -BFG'

# mytunes aliases
alias mytunes='~/mytunes/mytunes-remote'
alias n='mytunes next'
alias l='mytunes limit'

# Dunno why, but I prefer emacs bindings in my shell.
bindkey -e

# preload SSH completion so that _ssh_hosts can be overridden
autoload _ssh
_ssh

# Override _ssh_hosts to use .ssh/config and .ssh/known_hosts
_ssh_hosts () {
  if [[ "$IPREFIX" == *@ ]]; then
    _combination -s '[:@]' my-accounts users-hosts \
      "users=${IPREFIX/@}" hosts "$@"
  else
    _combination -s '[:@]' my-accounts users-hosts \
      ${opt_args[-l]:+"users=${opt_args[-l]:q}"} hosts "$@"
  fi
  if [[ -r "$HOME/.ssh/known_hosts" ]]; then
      sed 's/[ ,:].*//' ~/.ssh/known_hosts | tr -d '[]' | while read host ; do
          _wanted hosts expl host \
              compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' "$@" "$host"
      done
  fi
}
