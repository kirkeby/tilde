class common {
    File {
        owner => root, group => root, mode => '0644',
    }

    ### Packages I use everywhere I go.
    package { ['zsh', 'git', 'build-essential', 'python2.7', 'python2.7-dev',
               'libxml2-dev', 'libxslt1-dev', 'libreadline-dev',
               'libncurses5-dev',
               'python-virtualenv', 'screen',
               'apt-file',
               'libdata-ical-perl', 'libtext-autoformat-perl',
               'html2text', 'dos2unix', 'units',
               'libnss3-tools',
               'realpath',
               'libssl-dev',
               'elinks',
               'ecryptfs-utils',
               'openssh-server',
               ]:
        ensure => present,
    }

    ### Unattended Upgrades are a great idea!
    package { 'unattended-upgrades': ensure => installed }
    file { '/etc/apt/apt.conf.d/20auto-upgrades':
        source => 'puppet:///modules/common/20auto-upgrades',
    }
    file { '/etc/apt/apt.conf.d/50unattended-upgrades':
        content => template('common/50unattended-upgrades.erb'),
    }

    ### Fucking morons mucking around with sitecustomize.py. Eat a bucket of
    ### cocks, please?
    $sitecustomize = '/usr/lib/python2.7/sitecustomize.py'
    exec { 'undivert-python2.7-sitecustomize':
        command => "dpkg-divert --remove --local --rename $sitecustomize",
        onlyif => "test -e $sitecustomize.distrib",
    }
    file { "/etc/python2.7/sitecustomize.py":
        source => 'puppet:///modules/common/sitecustomize.py',
    }
    file { "/etc/python3.7/sitecustomize.py":
        source => 'puppet:///modules/common/sitecustomize.py',
    }
}
