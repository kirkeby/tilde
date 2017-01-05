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
    file { '/etc/default/dnsmasq':
        source => 'puppet:///modules/dnsmasq/default',
        owner => 'root', group => 'root', mode => 0644
    }
    file { '/etc/dbus-1/system.d/dnsmasq-local.conf':
        source => 'puppet:///modules/dnsmasq/dnsmasq-local.conf',
        owner => 'root', group => 'root', mode => 0644
    }

    file { '/etc/resolv.conf':
        ensure => 'file',
        owner => 'root', group => 'root', mode => 0644,
        content => "nameserver 127.0.0.1\n",
    }
    file { '/etc/NetworkManager/NetworkManager.conf':
        source => 'puppet:///modules/dnsmasq/network-manager.conf',
        owner => 'root', group => 'root', mode => 0644,
    }
}
