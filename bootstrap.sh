#! /bin/bash
git clone --bare git@github.com:zawata/dotfiles ~/.df-repo
git --git-dir=$HOME/.df-repo --work-tree=$HOME checkout master