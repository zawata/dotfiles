#!/usr/bin/env bash

#===============================================================================
# Aliases
#===============================================================================
alias runskaffold="skaffold dev --port-forward -p"


#===============================================================================
# Functions
#===============================================================================

# shortcut to cd to any repo in ~/Documents/repos
function repo() {
    cd ~/Documents/repos/$1

    # auto source nvm if possible
    command -v nvm &> /dev/null && [ -f .nvmrc ] && nvm use
}

# a Function to simmplify building node native modules
# accepts the following parameters in any order:
#  - generate: regenerate sources
#  - build: build
#  - rebuild: clean build
#  - electronXX: build for electron version XX instead of node
#  - debug: include debug symbols in the build
function ng() {
    action=""
    more_args=()
    for var in "$@"
    do
        case $var in
        "build")
            action="build"
            ;;
        "rebuild")
            action="rebuild"
            ;;
        "electron13")
            more_args+=("--target=13.6.7" "--dist-url=https://electronjs.org/headers")
            ;;
        "electron17")
            more_args+=("--target=17.4.11" "--dist-url=https://electronjs.org/headers")
            ;;
        "electron21")
            more_args+=("--target=21.4.0" "--dist-url=https://electronjs.org/headers")
            ;;
        "electron24")
            more_args+=("--target=24.4.1" "--dist-url=https://electronjs.org/headers")
            ;;
        "debug")
            more_args+=("--debug")
            ;;
        "verbose")
            more_args+=("--verbose")
            ;;
        *)
            echo "unrecognized option: $var"
            ;;
        esac
    done

    npx node-gyp $action --arch=x64 -j max ${more_args[@]}
}

function dump-runtime-info {
    echo Library Requirements
    ldd $1

    echo
    echo GLIBC Version requirements
    objdump -T $1 | grep GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu
}