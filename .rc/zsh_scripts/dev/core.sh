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

# deno
export DENO_INSTALL="$HOME/.deno"
[ -s "$DENO_INSTALL/env" ] && \. "$DENO_INSTALL/env"

# pnpm
export PNPM_HOME="/home/johna/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# go
# export GOROOT="$HOME/.go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Rust Binaries
export PATH="$PATH:$HOME/.cargo/bin"

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin"

# # conda-forge
# [ -s "$HOME/miniforge3/bin/conda" ] && eval "$($HOME/miniforge3/bin/conda shell.zsh hook)"

# other
export PATH="$HOME/.local/bin:$PATH"