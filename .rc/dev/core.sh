#!/usr/bin/env bash

# minikube config
export KUBECONFIG=~/.kube/sandbox.conf

export VCPKG_ROOT=/opt/vcpkg

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/nvm_exec" ] && \. "$NVM_DIR/nvm_exec"

# EMSDK
# Redirect to null because output from setting up the env is not apparently not governed by EMSDK_NOTTY :)
# EMSDK_NOTTY=1 source "/usr/lib/emsdk/emsdk_env.sh" &> /dev/null

# Rust Binaries
export PATH="$PATH:$HOME/.cargo/bin"

