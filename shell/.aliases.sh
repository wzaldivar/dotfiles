alias ls=lsd

alias la='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias lr='lsd -R'
alias llr='lsd -lR'
alias lar='lsd -aR'
alias llar='lsd -laR'

alias vi=nvim
alias vim=nvim

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias home='cd ~'
alias dev='go_dir ~/dev'
alias rmdirf='rm -rfv'

alias clone='git clone'
alias fetch='git fetch'
alias pull='git pull'
alias push='git push'
alias merge='git merge'
alias branch='git checkout -b'
alias lsb='git branch -l'
alias rmbranch='git branch -D'
alias checkout='git checkout'
alias rebase='git rebase'
alias stash='git stash'
alias stage='git add'
alias hard='git reset --hard'
alias commit='git commit'
alias commitm='git commit -m'

alias zshconf='nvim ~/.zshrc'

alias compose='docker compose'
alias cup='docker compose up'
alias cdown='docker compose down'
alias clogs='docker compose logs'

repo() {
  RED='\033[0;31m'
  NC='\033[0m'

  local directory=${1:-.}

  target="$directory"

  while [[ ! -d "$target" ]]; do
    target=$(dirname $target)
  done

  if git -C "$target" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "${RED}Error:${NC} Already inside a git repository" >&2
    return 1
  fi

  mkdir -p "$directory" && cd "$directory" && git init
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

go_dir() {
  cd "$1" && lla
}

groot() {
  RED='\033[0;31m'
  NC='\033[0m'

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "${RED}Error:${NC} Not inside a git repository" >&2
    return 1
  fi

  go_dir $(git rev-parse --show-toplevel)
}

initial_git() {
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  BLUE='\033[0;34m'
  NC='\033[0m'

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "${RED}Error:${NC} Already inside a git repository" >&2
    return 1
  fi

  echo "Are you sure you want to add all files in ${BLUE}$(pwd)${NC} to a git repo? ${GREEN}(y/N)${NC}"
  read -r response
  if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "Cancelled"
    return 0
  fi

  git init
  stage -A
  commitm "initial"
}

init_python() {
  local py_version="$1"
  local venv_path="${2:-.venv}"
  local file="${3:-mise.toml}"

  if [ -z "$py_version" ]; then
    echo "Usage: init_python <python_version> [venv_path] [file]"
    return 1
  fi

  {
    echo "[tools]"
    echo "python = \"$py_version\""
    echo
    echo "[env]"
    echo "_.python.venv = { path = \"$venv_path\", create = true }"
  } >"$file"

  echo "Python $py_version venv at '$venv_path' configured in $file"

  mise trust "$file"
  mise install
}

help_aliases() {
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  NC='\033[0m'

  echo -e "\n${BLUE}=== File & Directory Management ===${NC}"
  echo -e "${GREEN}ls${NC}       → Uses lsd (modern ls alternative)"
  echo -e "${GREEN}la${NC}       → lsd -a (show hidden files)"
  echo -e "${GREEN}ll${NC}       → lsd -l (long format)"
  echo -e "${GREEN}lla${NC}      → lsd -la (all files, long format)"
  echo -e "${GREEN}lr${NC}       → lsd -R (recursive)"
  echo -e "${GREEN}lar${NC}      → lsd -aR (show hidden files, recursive)"
  echo -e "${GREEN}llr${NC}      → lsd -lR (long format, recursive)"
  echo -e "${GREEN}llar${NC}     → lsd -laR (all files, long format, recursive)"
  echo -e "${GREEN}..${NC}       → cd .. (move up one directory)"
  echo -e "${GREEN}..2${NC}      → cd ../.. (move up two directories)"
  echo -e "${GREEN}..3${NC}      → cd ../../.. (move up three directories)"
  echo -e "${GREEN}home${NC}     → cd ~ (go to the home directory)"
  echo -e "${GREEN}dev${NC}      → go_dir ~/dev (go to dev directory and list contents)"
  echo -e "${GREEN}rmdirf${NC}   → rm -rfv (forcefully remove directories)"

  echo -e "\n${BLUE}=== Git Shortcuts ===${NC}"
  echo -e "${GREEN}clone${NC}    → git clone (clone a repository)"
  echo -e "${GREEN}fetch${NC}    → git fetch (fetch remote changes)"
  echo -e "${GREEN}pull${NC}     → git pull (fetch and merge remote changes)"
  echo -e "${GREEN}push${NC}     → git push (push local changes)"
  echo -e "${GREEN}merge${NC}    → git merge (merge a branch)"
  echo -e "${GREEN}branch${NC}   → git checkout -b (create and switch to a new branch)"
  echo -e "${GREEN}lsb${NC}      → git branch -l (list branches)"
  echo -e "${GREEN}rmbranch${NC} → git branch -D (delete a branch)"
  echo -e "${GREEN}checkout${NC} → git checkout (switch branches)"
  echo -e "${GREEN}rebase${NC}   → git rebase (reapply commits onto another base)"
  echo -e "${GREEN}stash${NC}    → git stash (temporarily save changes)"
  echo -e "${GREEN}stage${NC}    → git add (stage changes)"
  echo -e "${GREEN}hard${NC}     → git reset --hard (reset repository state to last commit)"
  echo -e "${GREEN}commit${NC}   → git commit (commit changes)"
  echo -e "${GREEN}commitm${NC}  → git commit -m (commit changes with a message)"

  echo -e "\n${BLUE}=== Docker Shortcuts ===${NC}"
  echo -e "${GREEN}compose${NC}  → docker compose (base command for Docker Compose)"
  echo -e "${GREEN}cup${NC}      → docker compose up (start containers and attach to their output)"
  echo -e "${GREEN}cdown${NC}    → docker compose down (stop and remove containers and networks)"
  echo -e "${GREEN}clogs${NC}    → docker compose logs (show logs from containers)"

  echo -e "\n${BLUE}=== Text Editor & Shell Configuration ===${NC}"
  echo -e "${GREEN}vi${NC}       → nvim (use Neovim instead of vi)"
  echo -e "${GREEN}vim${NC}      → nvim (use Neovim instead of vim)"
  echo -e "${GREEN}zshconf${NC}  → nvim ~/.zshrc (edit the Zsh configuration file)"

  echo -e "\n${BLUE}=== Custom Functions ===${NC}"
  echo -e "${YELLOW}repo <name>${NC}                              → Create a new directory, enter it, and initialize a Git repo"
  echo -e "${YELLOW}mkcd <name>${NC}                              → Create a new directory and enter it"
  echo -e "${YELLOW}go_dir <path>${NC}                            → Enter a directory and list its contents"
  echo -e "${YELLOW}groot${NC}                                    → Go to current Git repository root directory"
  echo -e "${YELLOW}initial_git${NC}                              → Initialize Git repo and commit all current files as 'initial'"
  echo -e "${YELLOW}init_python <version> [venv_path] [file]${NC} → Generate mise.toml with Python and venv config"

  echo -e "\n${RED}Usage:${NC} Run ${GREEN}help_aliases${NC} to display this list again."
}
