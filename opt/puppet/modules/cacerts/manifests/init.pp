class cacerts {
    cacerts::forbidden { [
        "mozilla/CNNIC_ROOT.crt",
    ]: } ~>
    exec { "update-ca-certificates":
        refreshonly => true,
    }
}

define cacerts::forbidden($path=$name) {
    exec { "disable CA $path":
        command => "perl -pi -e 's,^$path,!$path,' /etc/ca-certificates.conf",
        onlyif => "grep -q '^$path\$' /etc/ca-certificates.conf",
    }
}
