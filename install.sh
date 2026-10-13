#! /bin/sh
#
# Run selected module setup scripts, in an order that keeps ~/.zshrc sane.
#
#   ./install.sh shell git starship
#   ./install.sh --list
#
# Each module's setup.sh still works standalone; this just saves the cd'ing
# and fixes the source order.

set -e

cd "$(dirname "$0")" || exit 1
ROOT=$(pwd)

# zsh-plugins stays last: its source lines go at the end of ~/.zshrc, with
# zsh-syntax-highlighting the final one. carapace (compinit + fzf-tab) goes just
# before it.
# Everything else is order-insensitive.
ORDER="shell git colima ollama remote bitwarden lsd starship ghostty nvim ideavim tmux carapace zsh-plugins"

usage() {
  echo "usage: ./install.sh <module>...   |   ./install.sh --list"
}

# A module counts as installed if a symlink under ~ or ~/.config points into it,
# or if a source line its setup.sh installs is already in ~/.zshrc (covers the
# clone-only modules, which create no symlinks).
links_into() {
  {
    find "$HOME" -maxdepth 1 -type l 2>/dev/null
    find "$HOME/.config" -maxdepth 4 -type l 2>/dev/null
  } | while IFS= read -r _link; do
    case "$(readlink "$_link")" in "$1"/*) echo hit; break ;; esac
  done | grep -q hit
}

sourced_from() {
  grep -o 'source "\$HOME/[^"]*"' "$1/setup.sh" 2>/dev/null | sort -u |
    while IFS= read -r _line; do
      if grep -qxF "$_line" "$HOME/.zshrc" 2>/dev/null; then echo hit; break; fi
    done | grep -q hit
}

# A module declaring PLUGINS= counts as installed once ~/.zshrc sources them,
# whatever path they come from (homebrew, macports, or its own clone).
plugins_sourced() {
  for _p in $(sed -n 's/^PLUGINS="\(.*\)"$/\1/p' "$1/setup.sh" 2>/dev/null); do
    if grep -q "^source .*$_p" "$HOME/.zshrc" 2>/dev/null; then return 0; fi
  done
  return 1
}

is_installed() {
  _dir="$ROOT/$1"
  if links_into "$_dir"; then return 0; fi
  if sourced_from "$_dir"; then return 0; fi
  if plugins_sourced "$_dir"; then return 0; fi
  return 1
}

list() {
  for m in $ORDER; do
    if is_installed "$m"; then
      printf '  \033[0;32m✓\033[0m %s\n' "$m"
    else
      printf '    %s\n' "$m"
    fi
  done
}

[ $# -eq 0 ] && { usage >&2; exit 1; }

case "$1" in
  --list | -l) list; exit 0 ;;
  --help | -h) usage; exit 0 ;;
esac

for m in "$@"; do
  case " $ORDER " in
    *" $m "*) ;;
    *) echo "unknown module: $m" >&2; usage >&2; exit 1 ;;
  esac
done

for m in $ORDER; do
  for want in "$@"; do
    [ "$m" = "$want" ] || continue
    echo "==> $m"
    (cd "$ROOT/$m" && ./setup.sh)
  done
done

# The zsh plugin source lines stay together at the very end of ~/.zshrc, in
# the order zsh-plugins/setup.sh declares them (syntax-highlighting last, as it
# must be). A later install.sh run - or a manual setup.sh - appends after them.
# Put the block back.
if [ -f "$HOME/.zshrc" ]; then
  BLOCK=$(for p in $(sed -n 's/^PLUGINS="\(.*\)"$/\1/p' "$ROOT/zsh-plugins/setup.sh"); do
    grep "^source .*$p" "$HOME/.zshrc" | tail -n 1
  done)
  if [ -n "$BLOCK" ]; then
    n=$(printf '%s\n' "$BLOCK" | wc -l | tr -d ' ')
    if [ "$(tail -n "$n" "$HOME/.zshrc")" != "$BLOCK" ]; then
      _tmp="$HOME/.zshrc.install.$$"
      {
        grep -vxF "$BLOCK" "$HOME/.zshrc" || true
        printf '%s\n' "$BLOCK"
      } >"$_tmp"
      cat "$_tmp" >"$HOME/.zshrc" # rewrite in place, preserving permissions
      rm -f "$_tmp"
      echo "==> moved the zsh plugin block to the end of ~/.zshrc"
    fi
  fi
fi
