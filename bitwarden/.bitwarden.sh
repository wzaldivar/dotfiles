export BITWARDEN_SSH_AUTH_SOCK="$HOME/.ssh/.bitwarden-ssh-agent.sock"

# Start a plain ssh-agent, replacing the Bitwarden socket for this shell.
disable-bw() {
  if [ -z "$SSH_AGENT_PID" ] || ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
  fi
}

# Point this shell at the Bitwarden agent socket, if it is actually there.
# Without the -S check a stopped Bitwarden leaves SSH_AUTH_SOCK dangling and
# every ssh/git operation in the shell fails with "Connection refused".
enable-bw() {
  if [ ! -S "$BITWARDEN_SSH_AUTH_SOCK" ]; then
    [ -n "$1" ] || echo "bitwarden: no agent socket at $BITWARDEN_SSH_AUTH_SOCK" >&2
    return 1
  fi

  if [ -n "$SSH_AGENT_PID" ]; then
    kill "$SSH_AGENT_PID" 2>/dev/null
    unset SSH_AGENT_PID
  fi

  export SSH_AUTH_SOCK="$BITWARDEN_SSH_AUTH_SOCK"
}

# --quiet: at startup, stay silent when Bitwarden simply isn't running.
enable-bw --quiet
