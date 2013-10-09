class common {
    File {
        owner => root, group => root, mode => 0644,
    }

    ### Packages I use everywhere I go.
    package { ['zsh', 'git', 'build-essential', 'python2.7', 'python2.7-dev',
               'libxml2-dev', 'libxslt1-dev', 'libreadline-dev',
               'libncurses5-dev',
               'python-virtualenv', 'screen', 'vim',
               'apt-file',
               'libdata-ical-perl', 'libtext-autoformat-perl',
               'html2text',
               'libnss3-tools',
               ]:
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
    $sitecustomize = '/usr/lib/python2.7/sitecustomize.py'
    exec { 'unbreak-python2.7-sitecustomize':
        command => "dpkg-divert --add --local --rename $sitecustomize",
        onlyif => "test -e $sitecustomize",
    }
    Package["python2.7"] ~> Exec["unbreak-python2.7-sitecustomize"]
    file { ["${sitecustomize}c", "${sitecustomize}o"]:
        ensure => absent,
    }
}
