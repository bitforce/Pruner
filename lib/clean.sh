# MAIN FUNCTIONS
# ---------------------------------------------------------------------------- #
run() {
    validate
    if ! [ $# -eq 0 ]; then
        if contains '-s' ${params[*]}; then
            quiet=0
        fi
        if integer $1; then
            lvls=$1
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
    if test -f '.clean'; then
        if ! grep -Fxq 'A CLEAN FILE' $file; then
            color $red 'found incongruous hidden clean file -> aborting'
            terminate            
        fi
    else
        out 'creating .clean file'
        echo '------------' > $file
        echo 'A CLEAN FILE' >> $file
        echo '------------' >> $file
        echo '------------' >> $file
    fi
    if test -f '.gitignore' && ! grep -Fxq '.clean' '.gitignore'; then
        out '.gitignore file found -> including .clean'
        echo '.clean' >> '.gitignore'
    fi
}

forward() {
    cd $home
}

reverse() {
    for ((i = 0; i < $lvls; i++)); do
        echo 'went up a dir'
        cd ..
    done
}

include() {
    os="$(uname -s)"
    if [ $os = 'Darwin' ]; then
        sed='gsed'
    elif [ $os = 'Linux' ]; then
        sed='sed'
    else
        color $red 'Operating system not supported.'
        terminate
    fi
    out 'including new parameters'
    f=1
    d=1
    if [ ${params[0]} = '-f' ]; then
        for e in ${params[*]:1}; do
            if [ $e = '-d' ]; then
                d=0
                break
            fi
            if grep -Fxq $e $file; then
                out $e' is already tracked'
                continue
            fi
            insertf
        done
    fi
    if [ ${params[0]} = '-d' ]; then
        for e in ${params[*]:1}; do
            if [ $e = '-f' ]; then
                f=0
                break
            fi
            if grep -Fxq $e $file; then
                out $e ' is already tracked'
                continue
            fi
            insertd
        done
    fi
    if [ $f -eq 0 ]; then
        add=1
        for e in ${params[*]}; do
            if [ $e = '-f' ]; then
                add=0
                continue
            fi
            if [ $add -eq 0 ]; then
                insertf
            fi
        done
    fi
    if [ $d -eq 0 ]; then
        add=1
        for e in ${params[*]}; do
            if [ $e = '-d' ]; then
                add=0
                continue
            fi
            if [ $add -eq 0 ]; then
                insertd
            fi
        done
    fi
}

clean() {
    while read line; do
        if [ "$line" = '------------' ]; then
            continue
        fi
        if [ "$line" = 'A CLEAN FILE' ]; then
            continue
        fi
        if [[ $line =~ .*/.* ]]; then
            remove d $line
        else
            remove f $line
        fi
    done < $file
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

insertf() {
    $sed -i "4i $e" $file
}

insertd() {
    $sed -i "4i $e/" $file
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

remove() {
    x=$2
    if [ $1 = d ]; then
        x=${x%?}
    fi
    find . -type $1 -name $x -delete 
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
file='.clean'
params=($*)
home=$(pwd)
quiet=1
lvls=0
yellow='y'
green='g'
red='r'
sed=''
run $*
