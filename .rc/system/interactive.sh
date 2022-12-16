#!/usr/bin/env bash

#===============================================================================
# Power
#===============================================================================

alias suspend="sudo systemctl suspend"
alias hibernate="sudo systemctl hibernate"
alias shutdown="sudo systemctl shutdown"
# alias reboot="sudo systemctl reboot"
alias reboot-bios="sudo systemctl reboot --firmware-setup"

#===============================================================================
# Other Stuff
#===============================================================================

alias kssh="kitty +kitten ssh"

#===============================================================================
# Fix my goddamn keyboard
#===============================================================================
autoload zkbd;
source ~/.rc/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Home]} ]]   && bindkey  "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]]    && bindkey  "${key[End]}"  end-of-line
[[ -n ${key[Delete]} ]] && bindkey  "${key[Delete]}"  delete-char

#===============================================================================
# Themes
#===============================================================================

#TODO: change to Adw when gnome gets its shit together...or just switch over to KDE
LIGHT_THEME="Flat-Remix-GTK-Green"
DARK_THEME="Flat-Remix-GTK-Green-Dark"

function setmode() {
    if [[ -z $1 ]]; then
        echo "setmode [light|dark]"
        return
    fi

    if [[ "$1" = "light" ]]; then
        gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME";
        # gsettings set org.gnome.desktop.interface color-scheme default
    elif [[ "$1" = "dark" ]] ; then
        gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME";
        # gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    else
        echo Unrecognized mode
        echo "setmode [light|dark]"
    fi
}

function togglemode() {
    eval current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    if [[ "$current_theme" == "$LIGHT_THEME" ]]; then
        setmode dark
    elif [[ "$current_theme" == "$DARK_THEME" ]]; then
        setmode light
    else
        echo "Unrecognized theme: $current_theme $DARK_THEME"
    fi
}

#===============================================================================
# Bash Command Utilities
#===============================================================================

function pm () {
    case $1 in
        autoremove) sudo pacman -R $(pacman -Qdtq) ;;
        *) echo " unknown command: '$1'" ;;
    esac
}

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# ex - archive extractor
# usage: ex <file>
function ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1   ;;
            *.tar.gz)  tar xzf $1   ;;
            *.bz2)     bunzip2 $1   ;;
            *.rar)     unrar x $1     ;;
            *.gz)      gunzip $1    ;;
            *.tar)     tar xf $1    ;;
            *.tbz2)    tar xjf $1   ;;
            *.tgz)     tar xzf $1   ;;
            *.zip)     unzip $1     ;;
            *.Z)       uncompress $1;;
            *.7z)      7z x $1      ;;
            *)         echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}