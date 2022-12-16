#! /usr/bin/env bash

#
# Sourced On Login Shells
#

# source all core scripts
for f in ~/.rc/**/core.sh; do source $f; done