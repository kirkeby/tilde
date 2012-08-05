# Nice and simple does it.
export PS1='%n@%m:%~$ '

# In-core and on-disk history.
HISTSIZE=200
SAVEHIST=200
HISTFILE=~/.zsh_history
# Incremental history, instead of last-to-write-wins history.
setopt inc_append_history

# Automatic pushd on cd.
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome

# Dunno why, but I prefer emacs bindings in my shell.
bindkey -e

# Make rm, mv and cp safe for feeble-minded fools (i.e. me).
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

alias vmi=vim

# Enable command-line completion
autoload -U compinit
compinit

# Always fall back to plain ol' filename completion, if all others fail.
zstyle ':completion:*' completer _complete _ignored _files

# Globbing options
setopt extendedglob
unsetopt nomatch
fignore=(.o .pyc \~)

# Enable C-x-e shortcut to edit command-line in vim
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# preload SSH completion so that _ssh_hosts can be overridden
autoload _ssh
_ssh

# Override _ssh_hosts to use ~/.ssh/known_hosts
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

# If RVM is installed source it.
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e ~/.zshrc-$postfix && source ~/.zshrc-$postfix
done

# Source per-directory configurations (i.e. for per-project screens).
test $PWD != $HOME && test -e .zshrc && source .zshrc
test -f py/bin/activate && source py/bin/activate
