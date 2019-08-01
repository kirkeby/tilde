# Reset PATH to a sensible default
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=$HOME/bin:$PATH

# Add private software installations
for bin in ~/opt/*/bin(N)
do
    export PATH=${bin}:$PATH
done
for lib in ~/opt/*/lib(N)
do
    export LD_LIBRARY_PATH=${lib}:$LD_LIBRARY_PATH
done

# Source rustup env if installed
test -f $HOME/.cargo/env && source $HOME/.cargo/env

# Tell cargo to put build-artifacts in per $LOGNAME sub-directories of
# target/, so running cargo inside/outside vagrant does not clobber each
# other.
export CARGO_TARGET_DIR=target/${LOGNAME}/

# Source emsdk env if installed
test -f $HOME/opt/emsdk/emsdk_env.sh && source $HOME/opt/emsdk/emsdk_env.sh

test -d $HOME/.cabal/bin && export PATH=$PATH:$HOME/.cabal/bin

which rbenv > /dev/null && eval "$(rbenv init -)"

# This is who I am.
export DEBFULLNAME='Sune Kirkeby'
export DEBEMAIL='mig@ibofobi.dk'
export GIT_AUTHOR_EMAIL='mig@ibofobi.dk'
export GIT_COMMITTER_EMAIL='mig@ibofobi.dk'

export PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS='--RAW-CONTROL-CHARS --chop-long-lines --ignore-case'
export LANG=en_US.UTF-8
export TIME_STYLE=long-iso  # anything else is insane...
export BLOCK_SIZE="'1"  # thosands commas
alias grep='grep --exclude=*~ --color=auto'

# Dear Dimwitted Debian Developers, how about you stop changing shit that's
# worked since before you we're born?
export QUOTING_STYLE=literal

# Seriously, just find somewhere that does not ruin directory listings and tab
# completion, dumbass python-dev.
export PYTHONDONTWRITEBYTECODE=fuck-off-python-dev

export TMPDIR=/tmp/$LOGNAME
test -d $TMPDIR || mkdir -p $TMPDIR

export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"

export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

export PYTHONSTARTUP=$HOME/.startup.py

test -x $HOME/opt/go/bin/go && export GOROOT=$HOME/opt/go

# Even more working around Gnome being brain-damaged, unsafe and stupid.
# I want to run with the ssh-agent written by people I trust, you stupid
# incompetent dimwitted morons.
unset SSH_AGENT_PID SSH_AUTH_SOCK

# Find a working ssh-agent; note we search all the /tmp/, because some clever
# moron decided to sgid ssh-agent, causing it to not honour $TMPDIR
for socket in $(find /tmp/ -path '*/ssh-*/agent*' -user `whoami` 2>/dev/null)
do
    # Suck a fat cock whoever wrote ssh-add, an empty list of identities is
    # not a fucking error, and using stdout to print this one error, but
    # stderr for all others is as retarded as it gets.
    # So, to summarize: We work around the extreme uselessness of ssh-add
    # like this:
    export SSH_AUTH_SOCK="$socket"
    if [ "`ssh-add -l 2>&1`" = "Could not open a connection to your authentication agent." ]
    then
        rm -f $SSH_AUTH_SOCK
        unset SSH_AUTH_SOCK
        break
    fi
done

# Create a persistent shared ssh-agent, if we're running on a desktop and
# did not find one above.
if [ -n "$DISPLAY" -a -z "$SSH_AUTH_SOCK" ] ; then
    ssh-agent | egrep -v "^echo" > $TMPDIR/ssh-agent.env
    . $TMPDIR/ssh-agent.env
fi


# I really, really *really* should not have to muck about with TERM, but
# gnome-terminal won't set it to what I want, so here I go :/
if [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] ; then
    export TERM=xterm-256color
fi

# Source per-platform and per-host configurations.
for postfix in `uname` `hostname` $LOGNAME ; do
    test -e ~/.zshenv-$postfix && source ~/.zshenv-$postfix
done
