#!/usr/bin/env bash

#===============================================================================
# SSH
#===============================================================================

# setup auth sock
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

#add all ssh keys
add-ssh-keys() {
  ssh-add $HOME/.ssh/*.id_rsa &> /dev/null
  ssh-add $HOME/.ssh/*.id_ed25519 &> /dev/null
}
add-ssh-keys