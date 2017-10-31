if [ -f ~/TODO ] ; then
    echo
    echo "This is your TODO. Do something!"
    echo
    sed -e '/^$/,$d' ~/TODO
    echo
fi
