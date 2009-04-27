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

test -d /tmp/$USER || mkdir -p /tmp/$USER
export TEMP=/tmp/$USER
