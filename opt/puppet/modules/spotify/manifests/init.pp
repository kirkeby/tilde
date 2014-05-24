class spotify {
    apt::source { "spotify":
        location => "http://repository.spotify.com",
        release => "stable",
        repos => "non-free",
        key => "94558F59",
        key_server => "keyserver.ubuntu.com",
    }
    package {'spotify-client':}
}
