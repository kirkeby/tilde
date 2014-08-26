class desktop {
    File {
        owner => root, group => root, mode => 0644,
    }

    ### Packages I use on my desktops.
    package { ['redshift', 'numlockx',
               'haskell-platform',
               'haskell-platform-doc',
               'haskell-platform-prof',
               'network-manager-openvpn',
               'network-manager-openvpn-gnome',
               'remmina-plugin-rdp',
               ]:
        ensure => present,
    }

    ### Avahi can bite my shiny metal ass!
    exec { "disable-avahi-daemon":
        command => "dpkg-divert --add --local --rename /usr/sbin/avahi-daemon",
        onlyif => "test -f /usr/sbin/avahi-daemon"
    }
    exec { "kill-avahi-daemon":
        command => "pkill -9 avahi",
        onlyif => "pgrep avahi"
    }
}
