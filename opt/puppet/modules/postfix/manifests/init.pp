class postfix {
    class{'postfix::install': } ->
    class{'postfix::config': } ~>
    class{'postfix::service': } ->
    Class["postfix"]
}

class postfix::install {
    package { "postfix":
        ensure => installed,
    }
}

class postfix::config {
    File {
        owner   => root,
        group   => root,
        mode    => '0644',
    }
    Exec {
        refreshonly => true,
    }

    file { '/etc/postfix/main.cf':
        content => template('postfix/main.cf.erb'),
    }

    file { '/etc/postfix/default-forward':
        source => [
            "puppet:///modules/postfix/default-forward-${hostname}",
            "puppet:///modules/postfix/default-forward",
        ],
    }
}

class postfix::service {
    service { "postfix":
        ensure => running,
        enable => true,
    }
}
