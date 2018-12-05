class desktop {
    File {
        owner => root, group => root, mode => '0644',
    }

    ### Packages I use on my desktops.
    package {
        [
            'redshift', 'numlockx',
            'network-manager-openvpn',
            'network-manager-openvpn-gnome',
            'remmina-plugin-rdp',
            'xclip',
            'vim-gtk3',
            'mutt', 'isync',
            'vagrant', 'virtualbox', 'virtualbox-dkms', 'virtualbox-qt',
            'liblockfile-bin',
            'intel-microcode',
        ]:
        ensure => present,
    }

    ### Packages I do not want.
    package {
        [
            'gnome-user-share', 'mate-user-share',
            # libinput is a plague upon the Earth, and I wish it would die in
            # firey purge of goodness (fucking asshat libinput developers do
            # not support mouse acceleration configuration, so fuck them and
            # their useless incompetent shit-software.)
            'xserver-xorg-input-libinput-dev',  'xserver-xorg-input-libinput',
        ]:
        ensure => absent,
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

    ### systemd-resolv can also go die in a fire.
    service { 'systemd-resolved':
        provider => 'systemd',
        ensure => 'stopped',
        enable => false,
    }

    file { '/etc/sysctl.conf':
        source => "puppet:///modules/desktop/sysctl.conf",
    } ~>
    exec { 'sysctl --load': }

    file { '/etc/udev/rules.d/70-u2f.rules':
        source => "puppet:///modules/desktop/u2f-udev.rules",
    }
    file { '/etc/udev/rules.d/10-openmono.rules':
        source => "puppet:///modules/desktop/10-openmono.rules",
    }

    ### Get rid of Mate's brain-damaged Firefox fuckups.
    exec { "disable-mate-firefox-prefs":
        command => "dpkg-divert --add --local --rename /usr/lib/firefox/defaults/pref/all-ubuntumate.js",
        onlyif => "test -f /usr/lib/firefox/defaults/pref/all-ubuntumate.js"
    }
}
