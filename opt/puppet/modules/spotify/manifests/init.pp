class spotify {
    apt::source { "spotify":
        location => "http://repository.spotify.com",
        release => "stable",
        repos => "non-free",
        key => "BBEBDCB318AD50EC6865090613B00F1FD2C19886",
        key_server => "keyserver.ubuntu.com",
    } ->
    package {'spotify-client':}
}
