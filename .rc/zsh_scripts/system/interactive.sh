#!/usr/bin/env bash

#===============================================================================
# History
#===============================================================================
HISTFILE=~/.rc/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
#HISTDUP=erase
setopt incappendhistory

#===============================================================================
# Power
#===============================================================================

alias suspend="sudo systemctl suspend"
alias hibernate="sudo systemctl hibernate"
alias shutdown="sudo systemctl shutdown"
alias reboot-bios="sudo systemctl reboot --firmware-setup"

#===============================================================================
# Fix my goddamn keyboard
#===============================================================================
autoload zkbd;
source ~/.rc/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Home]} ]]   && bindkey  "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]]    && bindkey  "${key[End]}"  end-of-line
[[ -n ${key[Delete]} ]] && bindkey  "${key[Delete]}"  delete-char

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
            *.rar)     unrar x $1   ;;
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