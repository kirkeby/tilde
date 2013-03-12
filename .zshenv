# Reset PATH to a sensible default
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add private bin's to head of PATH
export PATH=$HOME/bin:$PATH
if [ -d ~/opt ] ; then
    for bin in `ls -dr ~/opt/*/bin`
    do
        export PATH=${bin}:$PATH
    done
fi

which rbenv > /dev/null && eval "$(rbenv init -)"

export PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LANG=en_US.UTF-8
export GREP_OPTIONS='--exclude=*~ --color=auto'

test -d /tmp/$USER || mkdir -p /tmp/$USER
export TEMP=/tmp/$USER

# I really, really *really* should not have to muck about with TERM, but
# gnome-terminal won't set it to what I want, so here I go :/
if [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] ; then
    export TERM=xterm-256color
fi

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e ~/.zshenv-$postfix && source ~/.zshenv-$postfix
done
