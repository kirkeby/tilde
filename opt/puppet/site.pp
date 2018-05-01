Exec {
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
}

$desktop = false;

node ski-laptop, moria, erewhon {
    $desktop = true;

    include common
    include dnsmasq
    # Spotify is a fancy snap now.
    #include spotify
    include desktop
    include cacerts
    include postfix
}

node ibofobot, jessica {
    include common
    include cacerts
    include postfix
}

node abraham {
    include common
    include cacerts
    include vagrant
}
