# ---------------------------------------------------------------------------- #
# MAIN FUNCTIONS
# ---------------------------------------------------------------------------- #
run() {
    if ! [ $# -eq 0 ]; then
        # CHECK SILENT PARAM
        if contains '-s' ${params[*]}; then
            quiet=0
        fi
        # CHECK IF BACKUP
        validate
        if integer $1; then
            levels=$1
            if [ $# -gt 1 ]; then
                params=${*:2}
            fi
            reverse
            include
            clean
            forward
        else
            include
            clean
        fi
    else
        clean
    fi
}

validate() {
    if [ ! "${params[*]}" = '' ]; then
        options=('-s' '-w' '-f' '-d')
        for element in ${params[*]}; do
            e=$element
            if ! contains $element ${options[*]}; then
                # TEST TO SEE IF FILES EXIST AND ASK PRESENT OPTION TO ADD
                if [[ $e =~ ^[/-]+[a-zA-Z0-9] ]]; then
                    color $red 'invalid parameter(s): '$e
                    terminate
                fi
            fi
        done
        if contains '-w' ${params[*]}; then
            out 'writing over existing clean file'
            if test -f '.clean'; then
                rm '.clean'
            else
                echo 'no clean file to write over'
            fi
        fi
    fi
    file='.clean'
    code='0x636c65616e'
    if test -f '.clean'; then
        if ! grep -Fxq $code $file; then
            color $red 'found incongruous hidden clean file -> aborting'
            terminate
        fi
        out 'found .clean file -> proceeding with updates'
    else
        out 'creating .clean file'
        echo '------------' > $file
        echo 'A CLEAN FILE' >> $file
        echo '------------' >> $file
        echo '' >> $file
        echo '------------' >> $file
        echo $code >> $file
    fi
    if test -f '.gitignore' && ! grep -Fxq '.clean' '.gitignore'; then
        out '.gitignore file found -> including .clean'
        echo '.clean' >> '.gitignore'
    fi
}

forward() {
    cd $directory
}

reverse() {
    for ((i = 0; i < $levels; i++)); do
        echo 'went up a dir'
        cd ..
    done
}

include() {
    out 'including new parameters'
    # for loop to include -f and -d items respectively
}

clean() {
    # read from file -> remove all those things
    # thing to worry about, how to differentiate between files and folders
    # my guess is to put a slash behhind all dirs in the include function
    return
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

integer() {
    if [ $1 = 1 ]; then
        return 1;
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        return 0;
    else
        return 1
    fi
}

silent() {
    if [ $quiet -eq 0 ]; then
        return 0
    fi
    return 1
}

color() {
    hue='\033[37m'
    end='\033[m'
    if [ $# -eq 2 ]; then
        if [ $1 = 'r' ]; then
            hue='\033[31m'
        elif [ $1 = 'g' ]; then
            hue='\033[32m'
        elif [ $1 = 'y' ]; then
            hue='\033[33m'
        fi
    elif [ $# -eq 1 ]; then
        echo $hue$1$end
        return
    fi
    echo $hue$2$end
}

out() {
    if ! silent; then
        echo $1
    fi
}

terminate() {
    exit 1
}

# ---------------------------------------------------------------------------- #
# GLOBAL
# ---------------------------------------------------------------------------- #
directory=$(pwd)
params=$*
levels=0
quiet=1
yellow='y'
green='g'
red='r'
run $*
