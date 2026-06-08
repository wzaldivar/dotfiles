#! /bin/sh

setup_git_personal() {
  local path="$1"
  local gitconfig_file="$HOME/.gitconfig"

  # Validate input
  if [[ -z "$path" ]]; then
    echo "Error: Path argument is required"
    return 1
  fi

  # Add trailing slash if not present
  [[ "$path" != */ ]] && path="$path/"

  # Append the includeIf section
  {
    echo ""
    echo "[includeIf \"gitdir:$path\"]"
    echo "    path = ~/.gitconfig.personal"
  } >>"$gitconfig_file"

  echo "Added includeIf section for path '$path' to $gitconfig_file"
}

setup_git_personal_here() {
  setup_git_personal $(pwd)
}
