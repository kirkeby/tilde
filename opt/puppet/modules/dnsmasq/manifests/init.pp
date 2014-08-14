class dnsmasq {
    package {dnsmasq:}

    file { '/etc/dnsmasq.conf':
        source => 'puppet:///modules/dnsmasq/dnsmasq.conf',
        owner => 'root', group => 'root', mode => 0644
    }
    file { '/etc/dhcp/dhclient.conf':
        source => 'puppet:///modules/dnsmasq/dhclient.conf',
        owner => 'root', group => 'root', mode => 0644
    }
}
