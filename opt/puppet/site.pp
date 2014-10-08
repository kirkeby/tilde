Exec {
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
}

node slaptop, slappy, moria {
    include common
    include dnsmasq
    include spotify
    include desktop
}

node ibofobot {
    include common
}
