Exec {
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
}

node skitop, slappy {
    include common
    include desktop
    include dnsmasq
    include spotify
}

node ibofobot {
    include common
}
