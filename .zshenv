# Reset PATH to a sensible default
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=$HOME/bin:$PATH

# Add private bin's to head of PATH
if [ -d ~/opt ] ; then
    for bin in `ls -dr ~/opt/*/bin`
    do
        export PATH=${bin}:$PATH
    done
fi

test -d $HOME/.cabal/bin && export PATH=$PATH:$HOME/.cabal/bin

which rbenv > /dev/null && eval "$(rbenv init -)"

export PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS='--RAW-CONTROL-CHARS --chop-long-lines --ignore-case'
export LANG=en_US.UTF-8
export GREP_OPTIONS='--exclude=*~ --color=auto'

export TMPDIR=/tmp/$LOGNAME
test -d $TMPDIR || mkdir -p $TMPDIR

export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"

export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

test -x $HOME/opt/go/bin/go && export GOROOT=$HOME/opt/go

# I really, really *really* should not have to muck about with TERM, but
# gnome-terminal won't set it to what I want, so here I go :/
if [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] ; then
    export TERM=xterm-256color
fi

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` ; do
    test -e ~/.zshenv-$postfix && source ~/.zshenv-$postfix
done
