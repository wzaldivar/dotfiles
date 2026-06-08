export BITWARDEN_SSH_AUTH_SOCK="$HOME/.ssh/.bitwarden-ssh-agent.sock"

disable-bw() {
  if [ -z "$SSH_AGENT_PID" ] || ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
  fi
}

enable-bw() {
  if [ -n "$SSH_AGENT_PID" ]; then
    kill "$SSH_AGENT_PID" 2>/dev/null
    unset SSH_AGENT_PID
  fi

  export SSH_AUTH_SOCK=$BITWARDEN_SSH_AUTH_SOCK
}

enable-bw
