#===============================================================================
# ZPlug
#===============================================================================

# Z-Bell Config
zbell_ignore=($EDITOR $SUDO_EDITOR $PAGER)

# core
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# plugins
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-auto-fetch", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/zbell", from:oh-my-zsh

# github plugins
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "supercrabtree/k"

# load everything
zplug load
if ! zplug check; then
    zplug install
fi

#===============================================================================
# misc
#===============================================================================

function colortest() {
    T='XXX'   # The test text

    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
            '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
            '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
    done
    echo
}