Exec {
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
}

node skitop, sune-laptop {
    include common
    include dnsmasq
    include spotify
}
