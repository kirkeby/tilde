# Reset PATH to a sensible default
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add private bin's to head of PATH
export PATH=$HOME/bin:$PATH
if [ -d ~/opt ] ; then
    for x in `ls -dr ~/opt/*/bin`
    do
        export PATH=${x}:$PATH
    done
    #for x in ~/opt/*/share/man
    #do
    #    export MANPATH=${x}:$MANPATH
    #done
fi

test -d $HOME/.rvm/bin && PATH=$PATH:$HOME/.rvm/bin
export PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LANG=en_US.UTF-8
export GREP_OPTIONS='--exclude=*~ --color=auto'

test -d /tmp/$USER || mkdir -p /tmp/$USER
export TEMP=/tmp/$USER

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e ~/.zshenv-$postfix && source ~/.zshenv-$postfix
done
