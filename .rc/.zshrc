#! /usr/bin/env bash

#
# Sourced On Interactive Sessions
#

# check if we're in tmux and if not, run it
# if [[ -z "$TMUX" ]]; then
#     tmux new
#     exit
# fi

# source all core scripts
for f in ~/.rc/zsh_scripts/**/core.sh; do source $f; done
# source all interactive scripts
for f in ~/.rc/zsh_scripts/**/interactive.sh; do source $f; done

alias dfgit='$(which git) --git-dir=$HOME/.df-repo/ --work-tree=$HOME'

# display Quote on zsh start
fortune
