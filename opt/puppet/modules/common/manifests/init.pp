class common {
    File {
        owner => root, group => root, mode => 0644,
    }

    ### Packages I use everywhere I go.
    package { ['zsh', 'git', 'build-essential', 'python2.7', 'python2.7-dev',
               'libxml2-dev', 'libxslt1-dev', 'libreadline-dev',
               'libncurses-dev',
               'python-virtualenv', 'screen', 'vim',
               'redshift', 'numlockx',
               'apt-file',
               'libdata-ical-perl', 'libtext-autoformat-perl',
               'html2text',
               'libnss3-tools']:
        ensure => latest,
    }

    ### Unattended Upgrades are a great idea!
    package { 'unattended-upgrades': ensure => installed }
    file { '/etc/apt/apt.conf.d/20auto-upgrades':
        source => 'puppet:///modules/common/20auto-upgrades',
    }
    file { '/etc/apt/apt.conf.d/50unattended-upgrades':
        source => 'puppet:///modules/common/50unattended-upgrades',
    }

    ### Ubuntu's mucking around with sitecustomize can go fuck itself,
    ### sitecustomize is, has always been and will always be for end-users.
    file { ['/usr/lib/python2.7/sitecustomize.py',
            '/usr/lib/python2.7/sitecustomize.pyc',
            '/usr/lib/python2.7/sitecustomize.pyo']:
        ensure => removed,
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
