for x in ~/bin ~/opt/*/bin
do
    export PATH=${x}:$PATH
done

#for x in ~/opt/*/share/man
#do
#    export MANPATH=${x}:$MANPATH
#done

export VISUAL=vim

test -d /tmp/$USER || mkdir -p /tmp/$USER
export TEMP=/tmp/$USER
