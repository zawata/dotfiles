#! /usr/bin/env bash

#
# Sourced On Login Shells
#

# source all interactive scripts
for f in ~/.rc/**/core.sh; do source $f; done