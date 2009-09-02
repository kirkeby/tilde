export PATH=$HOME/bin:$PATH
if [ -d ~/opt ] ; then
    for x in ~/opt/*/bin
    do
        export PATH=${x}:$PATH
    done
    #for x in ~/opt/*/share/man
    #do
    #    export MANPATH=${x}:$MANPATH
    #done
fi

export VISUAL=vim
export LANG=en_US.UTF-8

test -d /tmp/$USER || mkdir -p /tmp/$USER
export TEMP=/tmp/$USER

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e .zshenv-$postfix && source .zshenv-$postfix
done
