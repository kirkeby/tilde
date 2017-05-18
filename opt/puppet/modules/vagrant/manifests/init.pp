class vagrant {
    File {
        owner => root, group => root, mode => '0644',
    }

    package { []: ensure => present, }
    package { ['puppet']: ensure => absent, }
}
