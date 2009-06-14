# Nice and simple does it.
export PS1='%n@%m:%~$ '

# Dunno why, but I prefer emacs bindings in my shell.
bindkey -e

# Enable command-line completion
autoload -U compinit
compinit

# preload SSH completion so that _ssh_hosts can be overridden
autoload _ssh
_ssh

# Override _ssh_hosts to use .ssh/known_hosts
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

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e .zshrc-$postfix && source .zshrc-$postfix
done
