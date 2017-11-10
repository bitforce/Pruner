# ---------------------------------------------------------------------------- #
# MAIN FUNCTIONS
# ---------------------------------------------------------------------------- #
run() {
    args=$*
    subdirectory=1
    options=('-s' '-a' '-w' '-f' '-d')
    if ! contains $1 ${options[*]} && test -d $1; then # might be excessive
        echo 'dir'
        subdirectory=0
        args=${*:2}
    fi
    echo $args
    validate $args # will make sure all the args follow format
    if [ $subdirectory -eq 0 ]; then
        clean $1 $args
    else
        clean $args
    fi
}

# instead of cleaning specific directories; how about we make it so that you 
# can still run the clean command even if you are X subdirectories down--so 
# how about putting a # which signifies how many directories back it needs 
# to traverse to clean from the root
clean() {
    return
}

validate() {
    file='.clean'
    code='0x636c65616e'
    if test -f '.clean'; then
        if ! grep -Fxq $code $file; then
            echo 'found incongruous hidden clean file -> aborting'
            terminate
        elif ! contains '-s' $*; then
            echo 'found .clean file -> proceeding with updates'
        fi
    else
        if ! contains '-s' $*; then
            echo 'creating .clean file'
        fi
        echo '------------' > $file
        echo 'A CLEAN FILE' >> $file
        echo '------------' >> $file
        echo '' >> $file
        echo '------------' >> $file
        echo $code >> $file
    fi
    if test -f '.gitignore'; then
        if ! contains '-s' $*; then
            echo '.gitignore file found -> including .clean'
        fi
        echo '.clean' >> '.gitignore'
    fi
}

add() {
    echo "ADD CALLED"
}
# ---------------------------------------------------------------------------- #
# ASSIST FUNCTIONS
# ---------------------------------------------------------------------------- #
contains() {
    for element in ${*:2}; do
        if [ $1 = $element ]; then
            return 0
        fi
    done
    return 1
}

terminate() {
    return 1 # end program somehow
}

# ---------------------------------------------------------------------------- #
# RUN
# ---------------------------------------------------------------------------- #
run $*
