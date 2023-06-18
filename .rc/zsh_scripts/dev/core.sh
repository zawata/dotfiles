#!/usr/bin/env bash

# minikube config
export KUBECONFIG=~/.kube/sandbox.conf

# C++
export VCPKG_ROOT=/opt/vcpkg
# Redirect to null because output from setting up the env is not apparently not governed by EMSDK_NOTTY :)
# EMSDK_NOTTY=1 source "/usr/lib/emsdk/emsdk_env.sh" &> /dev/null

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/nvm_exec" ] && \. "$NVM_DIR/nvm_exec"

# go
export GOROOT="$HOME/.go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"s

# Rust Binaries
export PATH="$PATH:$HOME/.cargo/bin"

# temp, delete me
export PATH="$PATH:$HOME/.other-git/bin"

