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
               'html2text', 'dos2unix', 'units',
               'libnss3-tools',
               'realpath', 'mutt', 'isync', 'pidgin-sipe',
               'vagrant', 'virtualbox', 'virtualbox-dkms', 'virtualbox-qt',
               'libssl-dev',
               'elinks',
               'texlive', 'texlive-latex-extra',
               # A Java development environment
               'openjdk-7-jdk', 'junit4', 'ant',
               ]:
        ensure => present,
    }

    ### Unattended Upgrades are a great idea!
    package { 'unattended-upgrades': ensure => installed }
    file { '/etc/apt/apt.conf.d/20auto-upgrades':
        source => 'puppet:///modules/common/20auto-upgrades',
    }
    file { '/etc/apt/apt.conf.d/50unattended-upgrades':
        source => 'puppet:///modules/common/50unattended-upgrades',
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
}
