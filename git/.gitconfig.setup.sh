setup_git_personal() {
  # NB: do not name this `path` — in zsh `path` is tied to $PATH.
  local gitdir="$1"
  local gitconfig_file="$HOME/.gitconfig"

  # Validate input
  if [[ -z "$gitdir" ]]; then
    echo "Error: Path argument is required"
    return 1
  fi

  # Add trailing slash if not present
  [[ "$gitdir" != */ ]] && gitdir="$gitdir/"

  # Don't append a duplicate block if this path is already configured
  if git config --file "$gitconfig_file" --get-all "includeIf.gitdir:$gitdir.path" 2>/dev/null |
    grep -qxF '~/.gitconfig.personal'; then
    echo "Path '$gitdir' is already configured in $gitconfig_file"
    return 0
  fi

  # Append the includeIf section
  {
    echo ""
    echo "[includeIf \"gitdir:$gitdir\"]"
    echo "    path = ~/.gitconfig.personal"
  } >>"$gitconfig_file"

  echo "Added includeIf section for path '$gitdir' to $gitconfig_file"
}

setup_git_personal_here() {
  setup_git_personal "$(pwd)"
}
