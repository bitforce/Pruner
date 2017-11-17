run() {
    if command && man; then
        echo Command successfully installed.
    else
        echo Command failed to install.
    fi
}

command() {
    dir='/usr/local/bin/'
    if test -d $dir; then
        chmod +x 'lib/clean'
        cp 'lib/clean' $dir
        return 0
    else
        echo Issue locating and installing into appropriate directory: $dir
        return 1
    fi
}

man() {
    dir='/usr/local/share/man/man1/'
    if test -d $dir; then
        cp 'doc/clean.1' $dir
        return 0
    else
        echo Issue locating and installing into appropriate directory: $dir
    fi
}
